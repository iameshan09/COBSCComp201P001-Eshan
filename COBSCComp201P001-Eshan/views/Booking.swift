//
//  Booking.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-04.
//

import CodeScanner
import SwiftUI

struct Booking: View {
    
    @Binding var tabSelection: Int
    @State private var slotsViewModel = SlotsViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var bookViewModel = BookingViewModel()
    @State private var isShowingScanner = false
    
    @Binding var selectedSlot: String
    
    var isDisable: Bool {
        selectedSlot.isEmpty || selectedSlot == "0"
    }
    
    
    var body: some View {
        
        VStack{
            
            if(!authViewModel.currentUser.bookedStatus)
            {
                Form{
                    Group{
                        
                        HStack{
                            Text("Registration No :").font(.system(size: 14)).fontWeight(.bold)
                            Text(authViewModel.currentUser.regno).font(.system(size: 16)).foregroundColor(.gray)
                            Spacer()
                        }
                        HStack{
                            Text("Vehicle No :").font(.system(size: 14)).fontWeight(.bold)
                            Text(authViewModel.currentUser.vno).font(.system(size: 16)).foregroundColor(.gray)
                            Spacer()
                        }
                        
                    }
                    HStack{
                        Text("Parking slot :").font(.system(size: 14)).fontWeight(.bold)
                        if(!slotsViewModel.slots.isEmpty /*&& !slotsViewModel.selectedSlot.isEmpty*/)
                        {
                            SwiftUI.Picker("Parking slot", selection: $selectedSlot, content:  {
                                Text("Select slot").tag("0")
                                ForEach(slotsViewModel.slots){ slot in
                                if(slot.isAvailable)
                                {
                                    Text(slot.number).tag(slot.id)
                                }
                            }
                            }).pickerStyle(MenuPickerStyle())
                        }
                    }
                    
                    Group{
                        HStack{
                            Spacer()
                            Button("Book", action: { bookViewModel.Booking(docId: selectedSlot, buser: authViewModel.currentUser.id, bvehicle: authViewModel.currentUser.vno)}).foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                                .disabled(isDisable)
                                .opacity(isDisable ? 0.5 : 1.0)
                                .alert(isPresented: $bookViewModel.bookAlert, content:{
                                    Alert(title: Text("Info"), message: Text(bookViewModel.bookAlertMsg), dismissButton:  .default(Text("Ok"), action:{self.tabSelection = 1} ))
                                })
                            Spacer()
                        }.padding()
                        
                        HStack{
                            Spacer()
                            Button{
                                self.isShowingScanner = true
                            }label: {
                                Label("Scan",systemImage: "qrcode.viewfinder")
                            }.foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(8)
                                .alert(isPresented: $bookViewModel.bookAlert, content:{
                                    Alert(title: Text("Info"), message: Text(bookViewModel.bookAlertMsg), dismissButton:  .default(Text("Ok"), action:{self.tabSelection = 1} ))
                                })
                            Spacer()
                        }.padding()
                    }
                    
                    
                    
                }

            }else{
                Text("Booking is already in progress!")
            }
    
            
        }.onAppear{
            self.authViewModel.loadCurrentUser()
            self.slotsViewModel.fetchData()
            print("selected slot:", selectedSlot)
                
        }
        .sheet(isPresented: $isShowingScanner ){
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com",completion: self.handleScan)
        }
    }
    func handleScan (result: Result<String, CodeScannerView.ScanError>){
        self.isShowingScanner = false
        
        switch result {
        case.success(let code):
            bookViewModel.Booking(docId: code, buser: authViewModel.currentUser.id, bvehicle: authViewModel.currentUser.vno)
            print(code)
        case.failure(let error):
            print("scan failed",error)
        }
    }

}
//struct Booking_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Booking()
//    }
//}
