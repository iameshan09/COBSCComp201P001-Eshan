//
//  Settings.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-05.
//

import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
           Form {
                   TextField("Email", text: $viewModel.currentUser.email).disabled(true)
                   TextField("Name", text: $viewModel.currentUser.name).disabled(true)
                   TextField("NIC", text: $viewModel.currentUser.nic).disabled(true)
                   TextField("Vehicle No", text: $viewModel.currentUser.vno).disabled(true)
              
               HStack{
                   Spacer()
                   Button("Log out", action:  viewModel.signOut).foregroundColor(.white)
                       .padding()
                       .background(Color.red)
                       .cornerRadius(8)
                   Spacer()
               }.padding()
            }
        }.onAppear(){
            self.viewModel.loadCurrentUser()
        }.navigationTitle("Settings").background(Color.white)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
