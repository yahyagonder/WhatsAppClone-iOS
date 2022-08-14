//
//  ChatRow.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 25.08.2022.
//

import SwiftUI
import Firebase

struct ChatRow: View {
    
    var chatMessage : ChatModel
    var userFromChatView : UserModel
    
    var body: some View {
        
        VStack {
            
            if chatMessage.chatUserFrom == Auth.auth().currentUser!.uid && chatMessage.chatUserTo == userFromChatView.userid {
                
                HStack {
                    
                    Text("  \(chatMessage.message)  ")
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .background(Color.cyan)
                        .cornerRadius(15)
                        .padding(8)
                        .frame(width: UIScreen.main.bounds.width, height: 30,alignment: .trailing)
                    
                }
                
            } else if chatMessage.chatUserFrom == userFromChatView.userid && chatMessage.chatUserTo == Auth.auth().currentUser?.uid {
                
                HStack {
                    
                    Text("  \(chatMessage.message)  ")
                        .bold()
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(15)
                        .padding(8)
                        .frame(width: UIScreen.main.bounds.width, height: 30,alignment: .leading)
                    
                }
                
            } else {
                
                //there is no view here.
                
            }
            
        }
        
        
        
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chatMessage: ChatModel(message: "TEST", documentID: "123456", chatUserFrom: "SDFG", chatUserTo: "XCVBN", date: Date(), messageFromMe: true), userFromChatView: UserModel(name: "Yahya", userid: "234567"))
    }
}
