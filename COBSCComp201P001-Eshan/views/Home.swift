//
//  Home.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject private var viewModel = SlotsViewModel()
    @Binding var tabSelection: Int
    
    let gItem=[GridItem(.adaptive(minimum: 75, maximum: 75))]
   
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                LazyVGrid(columns: gItem, content: {
                    ForEach(viewModel.slots){ slot in
//                        Button(String(slot.number)) {
//                            self.tabSelection = 2
//                        }.padding(20).background(slot.isVIP ? Color.orange : Color.green).frame(width: 75, height: 75, alignment: .center)
//                        Rectangle()
//                                      .fill(slot.isVIP ? Color.orange : Color.green)
//                                      .frame(width: 75, height: 75)
                        
                        SlotView(backgroundColor: slot.isVIP ? Color.orange : Color.green, slotNumber: String(slot.number), function: {self.tabSelection = 2})
                     
                       
                    }
                }).onAppear(){
                    self.viewModel.fetchData()
                }
                
            }
    }
       

           
        
        
    }
}

//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
