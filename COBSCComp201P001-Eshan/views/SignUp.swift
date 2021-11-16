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
                      TextField("Email", text: $viewModel.newUser.email)
                      if(viewModel.emailErrorStatus){ Text(viewModel.emailError).foregroundColor(.red)}
                      
                      SecureField("Password", text: $viewModel.newUser.password)
                      if(viewModel.passwordErrorStatus){ Text(viewModel.passwordError).foregroundColor(.red)}
                      
                      TextField("Name", text: $viewModel.newUser.name)
                      if(viewModel.nameErrorStatus){ Text(viewModel.nameError).foregroundColor(.red)}
                      
                      TextField("NIC", text: $viewModel.newUser.nic)
                      if(viewModel.nicErrorStatus){ Text(viewModel.nicError).foregroundColor(.red) }
                      
                      TextField("Vehicle No", text: $viewModel.newUser.vno)
                      if(viewModel.vnoErrorStatus){ Text(viewModel.vnoError).foregroundColor(.red)}
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
