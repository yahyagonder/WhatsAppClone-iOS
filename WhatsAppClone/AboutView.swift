//
//  InfoView.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 6.09.2022.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
            
            VStack {
                
                Text("MESSAGES")
                    .bold()
                    .padding()
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .background(.linearGradient(colors: [.green,.blue], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .frame(width: 300, height: 200, alignment: .center)
                    .offset(x: 0, y: -100)
                
                Text("0.0.B.1")
                    .bold()
                    .font(.system(size: 26))
                    .foregroundColor(.blue)
                    .padding()
                    .offset(y: -170)
                    .layoutPriority(1)
                    
                
            }.navigationTitle("About This App")
            
        
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutView().environment(\.colorScheme, .dark)
        }
    }
}
