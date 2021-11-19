//
//  SignUp.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-05.
//

import SwiftUI

struct SignUp: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack{
            
            Spacer()
            Form {
                
                ScrollView{
                    Group{
                        
                        TextField("Email", text: $viewModel.newUser.email)
                        Text(viewModel.emailError).foregroundColor(.red)

                        SecureField("Password", text: $viewModel.newUser.password)
                        Text(viewModel.passwordError).foregroundColor(.red)
                    }
                        
                    Group{
                        TextField("Name", text: $viewModel.newUser.name)
                        Text(viewModel.nameError).foregroundColor(.red)
                        
                        TextField("NIC", text: $viewModel.newUser.nic)
                        Text(viewModel.nicError).foregroundColor(.red)

                        TextField("Registration No", text: $viewModel.newUser.regno)
                        Text(viewModel.regnoError).foregroundColor(.red)

                        TextField("Vehicle No", text: $viewModel.newUser.vno)
                        Text(viewModel.vnoError).foregroundColor(.red)
                    }

                }
                
            }
            
            HStack{
                Spacer()
                Button("Register", action:  viewModel.signUPValidations).foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
                Spacer()
            }.padding()
            Spacer()
        }.navigationTitle("Create Account").background(Color.white)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
