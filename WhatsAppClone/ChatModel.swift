//
//  ChatModel.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 25.08.2022.
//

import Foundation

struct ChatModel : Identifiable {
    
    var id = UUID()
    
    var message : String
    var documentID : String
    var chatUserFrom : String
    var chatUserTo : String
    var date : Date
    
    var messageFromMe : Bool
    
}
