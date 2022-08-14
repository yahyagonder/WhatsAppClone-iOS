//
//  ChatStore.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 25.08.2022.
//

import Foundation
import Firebase
import Combine

class ChatStore: ObservableObject {
    
    let database = Firestore.firestore()
    var chatArray : [ChatModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    init() {
        
        database.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
            if error != nil {
                //error
            } else {
                
                self.chatArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    
                    let documentID = document.documentID
                    
                    if let chatMessage = document.get("message") as? String {
                        
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            
                            if let messageTo = document.get("chatUserTo") as? String {
                                
                                if let dateString = document.get("date") as? String {
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    let dateFirebase = dateFormatter.date(from: dateString)
                                    
                                    let createdChat = ChatModel(message: chatMessage, documentID: documentID, chatUserFrom: messageFrom, chatUserTo: messageTo, date: dateFirebase!, messageFromMe: true)
                                    
                                    self.chatArray.append(createdChat)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                
                self.database.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser?.uid).addSnapshotListener { snapshot, error in
                    if error != nil {
                        //error
                    } else {
                        
                        for document in snapshot!.documents {
                            
                            let documentID = document.documentID
                            
                            if let chatMessage = document.get("message") as? String {
                                
                                if let messageFrom = document.get("chatUserFrom") as? String {
                                    
                                    if let messageTo = document.get("chatUserTo") as? String {
                                        
                                        if let dateString = document.get("date") as? String {
                                            
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                            let dateFirebase = dateFormatter.date(from: dateString)
                                            
                                            let createdChat = ChatModel(message: chatMessage, documentID: documentID, chatUserFrom: messageFrom, chatUserTo: messageTo, date: dateFirebase!, messageFromMe: true)
                                            
                                            self.chatArray.append(createdChat)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                        self.chatArray = self.chatArray.sorted(by: {
                            $0.date.compare($1.date) == .orderedAscending
                        })
                        
                        self.objectWillChange.send(self.chatArray)
                        
                        
                    }
                    
                }
                
                
            }
            
        }
        
    }
    
}
