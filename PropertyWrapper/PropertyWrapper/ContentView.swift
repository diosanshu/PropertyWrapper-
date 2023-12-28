//
//  ContentView.swift
//  PropertyWrapper
//
//  Created by Haadhya on 28/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingSettings: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button(action: {
                    isShowingSettings = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                } // Button
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView()
                }
            }
            .padding()
            
        }
    }
}
struct SettingsView : View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
            }
            .navigationBarTitle(Text("Settings"), displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
            )
            .padding()
            
        }
    }
}


#Preview {
    ContentView()
}


