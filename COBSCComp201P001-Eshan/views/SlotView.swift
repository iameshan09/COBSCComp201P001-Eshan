//
//  slotView.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-16.
//

import SwiftUI

struct SlotView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var bookViewModel = BookingViewModel()
    
    var backgroundColor = Color.green
    var slotNumber: String
    var function:()-> Void
    var opacity = 1.0
    var isDisabled = false
    var bVehicle: String
    var cancelBooking:()-> Void
    
    
    
    var body: some View {
        VStack{
            Button(action:{self.function()})
            {
                ZStack{
                    Rectangle().fill(backgroundColor).frame(width: 75, height: 75).opacity(1.0)
                    Text(slotNumber)
                }
            }.disabled(isDisabled)
            if(authViewModel.isSignedIn && authViewModel.currentUser.bookedStatus)
            {
                Button("Cancel", action:  {self.cancelBooking()}).foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            }
            else{
                Text(bVehicle)
            }
           
        }
       
       
    }
}

