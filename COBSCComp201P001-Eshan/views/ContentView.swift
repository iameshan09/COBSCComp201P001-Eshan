//
//  ContentView.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var tabSelection = 1
    
    var body: some View {
        
        TabView (selection: $tabSelection) {
            Home(tabSelection: $tabSelection).tabItem{Image(systemName:"house" )}.tag(1)
            NavigationView{
                if viewModel.signedIn{
                    Booking(tabSelection: $tabSelection).navigationTitle("Booking")
                }
                else
                {
                    SignIn(tabSelection: $tabSelection)
                }
            }.onAppear{
                viewModel.signedIn = viewModel.isSignedIn
            }.tabItem{
                Image(systemName:"parkingsign.circle" )
            }.tag(2)
            
            NavigationView{
                if viewModel.signedIn{
                    Settings().navigationTitle("Settings")
                }
                else
                {
                    SignIn(tabSelection: $tabSelection)
                }
            }.onAppear{
                viewModel.signedIn = viewModel.isSignedIn
            }.tabItem{
                Image(systemName:"gear.circle" )
            }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
