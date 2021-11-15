//
//  Home.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject private var viewModel = SlotsViewModel()
    
    let gItem=[GridItem(.adaptive(minimum:100))]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: gItem, content: {
                    ForEach(viewModel.slots){ slot in
                        Button(String(slot.number)) {
                            print("Button tapped!")
                        }.padding(20)
                    }
                }).onAppear(){
                    self.viewModel.fetchData()
                }
                
            }
    }
       

           
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
