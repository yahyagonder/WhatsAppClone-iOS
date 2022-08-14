//
//  ContentView.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 15.08.2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import AVFoundation

struct AuthView: View {
    
    let database = Firestore.firestore()
    
    @State var username = ""
    @State var useremail = ""
    @State var password = ""
    
    @State var showMainScreen = false
    
    @State var showAlert = false
    
    @State var testMessage = ""
    
    var body: some View {
        
        NavigationView {
            
                VStack{
                    
                    VStack {
                    
                    Text("")
                        .bold()
                        .font(.system(size: 37))
                        .offset(x: -85, y: -200)
                        .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .leading, endPoint: .trailing))
                    
                    Text("START SCREEN")
                        .italic()
                        .font(.largeTitle)
                        .foregroundStyle(.linearGradient(colors: [.purple,.cyan], startPoint: .leading, endPoint: .trailing))
                        .offset(x: -60, y: -30)
                    
                    TextField("Username", text: $username)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300, height: 40)
                        .offset(x: -30,y: -50)
                        .padding()
                    
                    TextField("E-Mail", text: $useremail)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300, height: 40)
                        .offset(x: -30, y: -50)
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300, height: 40)
                        .offset(x: -30, y: -35)
                        
                    }
                    
                    HStack {
                        
                        Button {
                            
                            //Sign In
                            
                            Auth.auth().signIn(withEmail: self.useremail, password: self.password) { result, error in
                                if error != nil {
                                    self.showAlert.toggle()
                                } else {
                                    //User Signed in
                                    self.showMainScreen = true
                                }
                            }
                            
                        } label: {
                            Text("Sign In")
                        }.buttonStyle(.borderedProminent)
                            .padding(.trailing)

                        
                        Button {
                            
                            //Sign Up
                            
                            Auth.auth().createUser(withEmail: self.useremail, password: self.password) { result, error in
                                if error != nil {
                                    self.showAlert.toggle()
                                } else {
            
                                    var referance : DocumentReference?
                                    
                                    let myUserDictionary : [String : Any] = ["username": self.username, "useremail": self.useremail,"userid": result?.user.uid]
                                    
                                    referance = self.database.collection("users").addDocument(data: myUserDictionary, completion: { error in
                                        if error != nil {
                                            
                                        }
                                        
                                        testMessage = error?.localizedDescription ?? "error"
                                        
                                    })
                                    
                                    self.showMainScreen = true
                                    
                                    
                                }
                                
                            }
                            
                        } label: {
                            Text("Sign Up")
                        }.buttonStyle(.bordered)
                            .padding(.leading)

                    }.offset(x: -23, y: -15).alert("Try Again", isPresented: $showAlert) {
                        Button("OK") {
                            showAlert = false
                        }
                    } message: {
                        Text(testMessage)
                    }


                    
                }
                
        }.fullScreenCover(isPresented: $showMainScreen, onDismiss: {
            //WHEN THE VIEW IS DISMISSED
            
            username = ""
            useremail = ""
            password = ""
            
            
        }) {
            
            MainScreen(isPresented: $showMainScreen)
        
        }
        
    }
    
}

struct MainScreen: View {
    
    @Binding var isPresented : Bool
    @State var presentMain = false
    
    @ObservedObject var userStore = UserStore()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                List(userStore.userArray) { user in
                        NavigationLink {
                            ChatView(userToChat: user)
                        } label: {
                            Text(user.name)
                                .font(.system(size: 20))
                                .foregroundStyle(.linearGradient(colors: [.blue,.green], startPoint: .leading, endPoint: .trailing))
                        }

                        
                    
                }.navigationTitle(Text("CONTACTS")).toolbar {
                    
                    HStack {
                        
                        Button {
                            //LOG OUT(!)
                            try? Auth.auth().signOut()
                            self.isPresented = false
                            
                        } label: {
                            Text("Log Out")
                        }
                        
                        NavigationLink {
                            AboutView()
                        } label: {
                            Text("About")
                        }


                    }

                }
                
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            AuthView()
        }
    }
}
