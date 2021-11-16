//
//  slotView.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-11-16.
//

import SwiftUI

struct SlotView: View {
//    var productName:String
//    var calories:String
//    var price:String
//    var fontColor = Color.black
    var backgroundColor = Color.green
    var slotNumber: String
    var function:()-> Void

    var body: some View {
        Button(action:{self.function()})
        {
            ZStack{
                Rectangle().fill(backgroundColor).frame(width: 75, height: 75)
                Text(slotNumber)
            }
        }
       
    }
}

