//
//  SignIn.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-04.
//

import SwiftUI
import Foundation

struct SignIn: View {
    //@StateObject var userModel = UserModel()
    @EnvironmentObject var viewModel: AuthViewModel
    //@StateObject var viewModel = AuthViewModel()

    var body: some View {

            VStack{
                //Image("AppLogo").resizable().scaledToFit().frame(width: 150, height: 150)

                VStack{
                    TextField("Email Address",text: $viewModel.newUser.email).disableAutocorrection(false).autocapitalization(.none).padding().background(Color(.secondarySystemBackground))
                     

                    SecureField("Password",text: $viewModel.newUser.password).padding().background(Color(.secondarySystemBackground))

                    Button(action:{
//                        guard !email.isEmpty, !password.isEmpty else {
//                            return
//                        }
                        viewModel.signIn()
                    },label: {Text("Sign In").foregroundColor(Color.white).frame(width: 200, height: 50).cornerRadius(10).background(Color.blue)})

                    NavigationLink("Create Account", destination: SignUp()).padding()
                    
                    //NavigationLink("Forgot password ?", destination: ForgotPasswordView()).padding()



                }.padding()

                Spacer()

            }.navigationTitle("Sign In")

    }
}

