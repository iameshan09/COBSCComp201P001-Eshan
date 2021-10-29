//
//  COBSCComp201P001_EshanApp.swift
//  COBSCComp201P001-Eshan
//
//  Created by Eshan Gallage on 2021-10-26.
//

import SwiftUI
import Firebase


@main
struct COBSCComp201P001_EshanApp: App {
    // init firebase
        init() {
            FirebaseApp.configure()
          }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
