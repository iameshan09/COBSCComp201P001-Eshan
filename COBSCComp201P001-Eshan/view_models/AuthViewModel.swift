//
//  AuthViewModel.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-04.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    
    let auth = Auth.auth()
    private var db = Firestore.firestore()
    @Published var newUser: User = User(email:"", password: "", name:"", nic:"",regno: "", vno: "")
    @Published var currentUser: User = User(email:"", password: "", name:"", nic:"",regno: "", vno: "")
    
    @Published var users = [User]()

    @Published var signedIn = false
    
    @Published var emailErrorStatus = false
    @Published var passwordErrorStatus = false
    @Published var nameErrorStatus = false
    @Published var nicErrorStatus = false
    @Published var regnoErrorStatus = false
    @Published var vnoErrorStatus = false
    @Published var loginErrorStatus = false
    
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var nameError = ""
    @Published var nicError = ""
    @Published var regnoError = ""
    @Published var vnoError = ""
    
    @Published var loginError = ""
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(){
        auth.signIn(withEmail: newUser.email, password: newUser.password) {[weak self]result,error in
            guard result != nil, error == nil else {
                self?.loginErrorStatus = true
                self?.loginError = error?.localizedDescription ?? ""
               return
            }
                       
            DispatchQueue.main.async {
                // success
                self?.loginErrorStatus = false
                self?.loginError = ""
                self?.newUser.email = ""
                self?.newUser.password = ""
                self?.signedIn = true
            }
            
        }
        
    }
    
    func signUp(){
        auth.createUser(withEmail: newUser.email, password: newUser.password) {[weak self] result,error in
            guard result != nil, error == nil else {
               return
            }
                        
            DispatchQueue.main.async {
                // success
                let user = Auth.auth().currentUser
                var uid : String = ""
                if let  user = user{
                    uid = user.uid

                    let authenticatedUser : [String : Any] = [
                        "email": self?.newUser.email ?? "",
                        "password": self?.newUser.password ?? "",
                        "name": self?.newUser.name ?? "",
                        "nic":self?.newUser.nic ?? "",
                        "regno":self?.newUser.regno ?? "",
                        "vno": self?.newUser.vno ?? ""
                    ]
                    
                    let record = self?.db.collection("users").document(uid)
                    record?.setData(authenticatedUser)
                }
                self?.newUser.email = ""
                self?.newUser.password = ""
                self?.newUser.name = ""
                self?.newUser.nic = ""
                self?.newUser.regno = ""
                self?.newUser.vno = ""
                self?.signedIn = true
                
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
    
    func loadCurrentUser() {
        
        let uId = Auth.auth().currentUser?.uid ?? ""
             
//        database.collection("users").whereField("uid",isEqualTo: uId ?? "").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.users = documents.map { (queryDocumentSnapshot) -> User in
//                let data = queryDocumentSnapshot.data()
//                let uid = data["uid"] as? String ?? ""
//                let name = data["uName"] as? String ?? ""
//                let nic = data["uNic"] as? String ?? ""
//                let vno = data["uVno"] as? String ?? ""
//
//                return User(id:uid, name: name, nic: nic, vno :vno)
//
//            }
//        }
        db.collection("users").document(uId).getDocument{ snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            self.currentUser.id =  snapshot?.documentID ?? ""
            self.currentUser.email = data["email"] as? String ?? ""
            self.currentUser.password = data["password"] as? String ?? ""
            self.currentUser.name = data["name"] as? String ?? ""
            self.currentUser.nic = data["nic"] as? String ?? ""
            self.currentUser.regno = data["regno"] as? String ?? ""
            self.currentUser.vno = data["vno"] as? String ?? ""
            
            
        }
    }
    
    func signUPValidations()
    {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", self.emailRegEx)
        let semaPhore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        var i=0
        
        DispatchQueue.main.async{
            self.emailErrorStatus = false
            self.passwordErrorStatus = false
            self.nameErrorStatus = false
            self.nicErrorStatus = false
            self.regnoErrorStatus = false
            self.vnoErrorStatus = false
            self.emailError = ""
            self.passwordError = ""
            self.nameError = ""
            self.nicError = ""
            self.regnoError = ""
            self.vnoError = ""
        }
        
        dispatchQueue.async {
            
            self.db.collection("users").whereField("email", isEqualTo: self.newUser.email).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                }
                else {
                    for document in querySnapshot!.documents {
                        let data=document.data()
                        let email = data["email"] as? String ?? ""
                        if(email == self.newUser.email)
                        {
                            self.emailErrorStatus = true
                            self.emailError = "Email is already exists"
                            i += 1
                        }
                        
                    }
                  
                }
                semaPhore.signal()
            }
            semaPhore.wait()
            
            self.db.collection("users").whereField("nic", isEqualTo: self.newUser.nic).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data=document.data()
                        let nic = data["nic"] as? String ?? ""
                        
                        if(nic == self.newUser.nic)
                        {
                            self.nicErrorStatus = true
                            self.nicError = "NIC is already exists"
                            i += 1
                        }
                       
                    }
                }
                semaPhore.signal()
            }
            semaPhore.wait()
            
            self.db.collection("users").whereField("regno", isEqualTo: self.newUser.regno).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data=document.data()
                        let regno = data["regno"] as? String ?? ""
                        
                        if(regno == self.newUser.regno)
                        {
                            self.regnoErrorStatus = true
                            self.regnoError = "Registration no is already exists"
                            i += 1
                        }
                       
                    }
                }
                semaPhore.signal()
            }
            semaPhore.wait()
            
            self.db.collection("users").whereField("vno", isEqualTo: self.newUser.vno).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data=document.data()
                        let vno = data["vno"] as? String ?? ""
                        
                        if(vno == self.newUser.vno)
                        {
                            self.vnoErrorStatus = true
                            self.vnoError = "Vehicle no is already exists"
                            i += 1
                        }
                       
                    }
                }
                semaPhore.signal()
            }
            semaPhore.wait()
            
            
            
            if(self.newUser.email.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.emailErrorStatus = true
                    self.emailError = "Email is required"
                }
              
                
                i += 1
            }
            if(!self.newUser.email.isEmpty && !emailPred.evaluate(with: self.newUser.email))
            {
                DispatchQueue.main.async {
                    self.emailErrorStatus = true
                    self.emailError = "Not a valid email"
                }
               
                i += 1
            }
            if(self.newUser.password.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.passwordErrorStatus = true
                    self.passwordError = "Password is required"
                }
              
                
                i += 1
            }
            if(!self.newUser.password.isEmpty && self.newUser.password.count<8)
            {
                
                DispatchQueue.main.async {
                    self.passwordErrorStatus = true
                    self.passwordError = "Password must include at least 8 characters"
                }
              
                
                i += 1
            }
            if(self.newUser.name.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.nameErrorStatus = true
                    self.nameError = "Name is required"
                }
              
                
                i += 1
            }
            if(self.newUser.nic.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.nicErrorStatus = true
                    self.nicError = "NIC is required"
                }
              
                
                i += 1
            }
            if(self.newUser.regno.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.regnoErrorStatus = true
                    self.regnoError = "Registration no is required"
                }
              
                
                i += 1
            }
            if(self.newUser.vno.isEmpty)
            {
                
                DispatchQueue.main.async {
                    self.vnoErrorStatus = true
                    self.vnoError = "Vehicle no is required"
                }
              
                
                i += 1
            }
            if(i<1)
            {
              self.signUp()
            }
        }
    }

   
}
