//
//  SlotViewModel.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import Foundation
import FirebaseFirestore

class SlotsViewModel : ObservableObject {
    @Published var slots = [Slot]()
    private var db = Firestore.firestore()
    
    func fetchData(){
        db.collection("slots").order(by: "number").addSnapshotListener {(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print ("empty")
                return
            }
            
            self.slots = documents.map { (queryDocumentSnapshot) -> Slot in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                
                let number = data["number"] as? String ?? ""
                let isVIP = data["isVIP"] as? Bool ?? false
                let isAvailable = data["isAvailable"]as?  Bool ?? false
                let bookedTime = data["bookedTime"]as?  String ?? ""
                let bookedUser = data["bookedUser"]as? String ?? ""
                let bookedVehicle = data["bookedVehicle"]as? String ?? ""
                
            
                return Slot(id:id, number: number, isVIP: isVIP, isAvailable: isAvailable, bookedTime: bookedTime, bookedUser: bookedUser, bookedVehicle: bookedVehicle)
            }
        }
      
    }
   
    
}
