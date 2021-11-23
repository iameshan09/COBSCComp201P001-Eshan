//
//  Home.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = SlotsViewModel()
    @Binding var tabSelection: Int
    @Binding var selectedSlot: String
    
    let gItem=[GridItem(.adaptive(minimum: 75, maximum: 150))]
    
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                ScrollView(.vertical, showsIndicators: false){
                    
                 
                        LazyHGrid(rows: gItem,alignment: .top, content: {
                            ForEach(viewModel.slots){ slot in
                                
                                if(authViewModel.isSignedIn && authViewModel.currentUser.bookedStatus)
                                {
                                    if(authViewModel.currentUser.id == slot.bookedUser){
                                        SlotView(backgroundColor: slot.isVIP ? Color.orange : Color.green, slotNumber: String(slot.number), function: {self.selectedSlot = slot.id; self.tabSelection = 2}, opacity: slot.isAvailable ? 1.0 : 0.3, isDisabled: slot.isAvailable ? false : true, bVehicle: slot.bookedVehicle)
                                    }

                                }else if(authViewModel.isSignedIn && !authViewModel.currentUser.bookedStatus){
                                    SlotView(backgroundColor: slot.isVIP ? Color.orange : Color.green, slotNumber: String(slot.number), function: {self.selectedSlot = slot.id; self.tabSelection = 2}, opacity: slot.isAvailable ? 1.0 : 0.3, isDisabled: slot.isAvailable ? false : true, bVehicle: slot.bookedVehicle)
                                }else if(!authViewModel.isSignedIn){
                                    SlotView(backgroundColor: slot.isVIP ? Color.orange : Color.green, slotNumber: String(slot.number), function: {self.selectedSlot = slot.id; self.tabSelection = 2}, opacity: slot.isAvailable ? 1.0 : 0.3, isDisabled: slot.isAvailable ? false : true, bVehicle: slot.bookedVehicle)
                                }
                            
                            }
                        })
                    
                }
                
            }
            
            
        }.onAppear(){
                self.viewModel.fetchData()
                self.authViewModel.loadCurrentUser()
                
        
          
         }
        
    }
}
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
