//
//  SignIn.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-04.
//

import SwiftUI
import Foundation

struct SignIn: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var tabSelection: Int
    
    var isDisable: Bool {
        viewModel.newUser.email.isEmpty || viewModel.newUser.password.isEmpty
    }
    
    var body: some View {
        VStack{
            
            Spacer()
            Form{
    
                    TextField("Email", text: $viewModel.newUser.email)
                    
                    SecureField("Password", text: $viewModel.newUser.password)
                    if(viewModel.loginErrorStatus){ Text(viewModel.loginError).foregroundColor(.red)}
                    
                    HStack{
                        Spacer()
                        Button("Sign In", action:  viewModel.signIn).foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .disabled(isDisable)
                            .opacity(isDisable ? 0.5 : 1.0)
                        Spacer()
                    }.padding()
                
                NavigationLink("Create Account", destination: SignUp()).padding().foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(8)
                Spacer()
            }

        }.navigationTitle("Sign In").background(Color.white)
        
       
        
    }
    
}

