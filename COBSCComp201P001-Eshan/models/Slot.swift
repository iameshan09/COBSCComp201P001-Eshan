//
//  slot.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import Foundation

struct Slot : Identifiable{
    
    var id: String 
    var number: String
    var isVIP: Bool
    var isAvailable: Bool
    var bookedTime: String
    var bookedUser: String
    var bookedVehicle: String
}

