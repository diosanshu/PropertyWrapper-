//
//  ContentView.swift
//  PropertyWrapper
//
//  Created by Haadhya on 28/12/23.
//

import SwiftUI

struct ChatMessage: Identifiable {
    var id = UUID()
    var text: String
    var user: String
}

// Observable object to manage the state of the chat room
class ChatRoom: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    func sendMessage(text: String, user: String) {
        let newMessage = ChatMessage(text: text, user: user)
        messages.append(newMessage)
    }
}

// SwiftUI view for the chat room
struct ChatRoomView: View {
    @ObservedObject var chatRoom: ChatRoom
    @State private var newMessageText: String = ""
    
    var body: some View {
        VStack {
            List(chatRoom.messages) { message in
                Text("\(message.user): \(message.text)")
            }
            
            HStack {
                TextField("Type your message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    chatRoom.sendMessage(text: newMessageText, user: "User")
                    newMessageText = ""
                }
            }
            .padding()
        }
        .navigationTitle("Chat Room")
    }
}

// SwiftUI view for the first page with a button to go to the chat room
struct FirstPageView: View {
    @State private var isShowingChatRoom = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Button to go to the chat room
                NavigationLink(destination: ChatRoomView(chatRoom: ChatRoom()), isActive: $isShowingChatRoom) {
                    EmptyView()
                }
                Button("Go to Chat Room") {
                    isShowingChatRoom = true
                }
            }
            .navigationTitle("First Page")
        }
    }
}

struct ContentView: View {
    var body: some View {
        FirstPageView()
    }
}

