//
//  TestView.swift
//  WhatsAppClone
//
//  Created by Yahya Gönder on 23.08.2022.
//

import SwiftUI

struct TestView: View {
    
    @State var x = true
    
    var body: some View {
        
        NavigationView {
            if x {
                VStack {
                    Text("???")
                    Button {
                        //
                        self.x = false
                    } label: {
                        Text("Change")
                    }

                }
            } else {
                Text("Hello, Swift")
                }
        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
