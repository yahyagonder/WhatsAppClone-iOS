//
//  WhatsAppCloneApp.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 15.08.2022.
//

import SwiftUI
import Firebase
@main
struct WhatsAppCloneApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
