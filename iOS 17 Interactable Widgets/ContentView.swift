//
//  ContentView.swift
//  iOS 17 Interactable Widgets
//
//  Created by Javad on 9/15/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @State var imageUrl = ""
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL(string: imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 250, height: 250)
                
            
            Button("Change Image") {
                let randomImageFromImageList = imageList.randomElement() ?? ""
                UserDefaults(suiteName: "group.com.example.widgy")?.set(randomImageFromImageList, forKey: "image")
                imageUrl = randomImageFromImageList
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        .padding()
        .onAppear(perform: {
            imageUrl = UserDefaults(suiteName: "group.com.example.widgy")?.string(forKey: "image") ?? ""
        })
    }
}

#Preview {
    ContentView()
}
