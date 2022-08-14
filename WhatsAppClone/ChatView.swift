//
//  ChatView.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 23.08.2022.
//

import SwiftUI
import Firebase

struct ChatView: View {
    
    var database = Firestore.firestore()
    
    var userToChat : UserModel
    
    @State var messageToSend = ""
    
    @ObservedObject var chatStore = ChatStore()
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                ForEach(chatStore.chatArray) { chat in
                    
                    ChatRow(chatMessage: chat, userFromChatView: userToChat)
                    
                }
                
            }
            
            HStack {
                TextField("Write", text: $messageToSend)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    sendMessage()
                } label: {
                    Text("Send")
                }.buttonStyle(.borderedProminent)

            }.padding()
                
        }.navigationTitle(userToChat.name)
        
    }
    
    func sendMessage() {
        
        var referance : DocumentReference?
        
        let chatDictionary : [String: Any] = ["chatUserFrom": Auth.auth().currentUser?.uid,"chatUserTo":userToChat.userid,"date":generateDate(),"message": self.messageToSend]
        
        referance = self.database.collection("Chats").addDocument(data: chatDictionary, completion: { error in
            if error  != nil {
                //
            } else {
                self.messageToSend = ""
            }
        })
        
    }
    
    func generateDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(userToChat: UserModel(name: "yahya", userid: "123456"))
    }
}
