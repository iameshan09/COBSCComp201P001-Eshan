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
                
                let number = data["number"] as? Int ?? 0
                let isVIP = data["isVIP"] as? Bool ?? false
                let isBooked = data["isBooked"]as?  Bool ?? false
                let bookedTime = data["bookedTime"]as?  Date ?? Date()
                let bookedUser = data["bookedUser"]as? String ?? ""
                
                return Slot(number: number, isVIP: isVIP, isBooked: isBooked, bookedTime: bookedTime, bookedUSer: bookedUser)
            }
        }
    }
}
