//
//  slot.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-29.
//

import Foundation

struct Slot : Identifiable{
    var id: String = UUID().uuidString
    var number: String
    var isVIP: Bool
    var isBooked: Bool
    var bookedTime: String
    var bookedUSer: String
}
