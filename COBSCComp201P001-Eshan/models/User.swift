//
//  User.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-04.
//

import Foundation

//class UserModel : ObservableObject{
//    @Published var email = ""
//    @Published var password = ""
//    @Published var name = ""
//    @Published var nic = ""
//    @Published var vno = ""
//    @Published var id = ""
//}

struct User : Identifiable{
    var id: String = UUID().uuidString
    var email: String
    var password: String
    var name: String
    var nic: String
    var vno: String
}
