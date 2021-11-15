//
//  ContentView.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-26.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    //@StateObject var viewModel = AuthViewModel()
    
    var body: some View {
        
        TabView{
            Home().tabItem{Image(systemName:"house" )}
            
            NavigationView{
                if viewModel.signedIn{
                    Booking().navigationTitle("Booking")
                }
                else
                {
                    SignIn()
                }
            }.onAppear{
                viewModel.signedIn = viewModel.isSignedIn
            }.tabItem{
                Image(systemName:"parkingsign.circle" )
            }
            
            NavigationView{
                if viewModel.signedIn{
                    Settings().navigationTitle("Settings")
                }
                else
                {
                    SignIn()
                }
            }.onAppear{
                viewModel.signedIn = viewModel.isSignedIn
            }.tabItem{
                Image(systemName:"gear.circle" )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
