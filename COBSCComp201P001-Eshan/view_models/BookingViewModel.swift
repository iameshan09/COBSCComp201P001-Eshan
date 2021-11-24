//
//  BookingViewModel.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-17.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class BookingViewModel : ObservableObject {
    private var db = Firestore.firestore()
   
    @Published var bookAlert = false
    @Published var bookAlertMsg = ""
    
    func Booking(docId:String, buser:String, bvehicle:String){
       
    
        
     
            self.db.collection("slots").document(docId).updateData([
                "bookedTime": Date(),
                "bookedUser": buser,
                "bookedVehicle": bvehicle,
                "isAvailable": false,
               
            ]) { err in
                if let err = err {
                    self.bookAlert = true
                    self.bookAlertMsg = err.localizedDescription
                } else {
                    self.db.collection("users").document(buser).updateData([
                      
                        "bookedStatus": true,
                       
                    ]) { err in
                        if let err = err {
                            self.bookAlert = true
                            self.bookAlertMsg = err.localizedDescription
                        } else {
                            self.bookAlert = true
                            self.bookAlertMsg = "Booking Successfull!"
                            //print("Document successfully updated")
                        }
                    }
                }
            }
        
        }
        
      
}
