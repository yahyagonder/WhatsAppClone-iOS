//
//  UserStore.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 23.08.2022.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class UserStore : ObservableObject {
    
    let database = Firestore.firestore()
    var userArray : [UserModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        
        database.collection("users").addSnapshotListener { snapshot, error in
            if error != nil {
                
            } else {
                
                self.userArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    
                    if let userid = document.get("userid") as? String {
                        
                        if let username = document.get("username") as? String {
                            
                            let createdUser = UserModel(name: username, userid: userid)
                            
                            self.userArray.append(createdUser)
                            
                        }
                        
                    }
                    
                }
                
                self.objectWillChange.send(self.userArray)
                
            }
        }
        
        
    }
    
}
