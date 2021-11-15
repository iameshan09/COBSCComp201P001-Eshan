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
        NavigationView{
            Button(action:{
                viewModel.signOut()
            }){
                Text("Sign Out")
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
