//
//  ContentView.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var allStudios: [Studio] = []
    @State var errorMessage: String = ""
    var body: some View {
        VStack {
            VStack {
                Text("AiryVibe")
                    .font(.title)
            }
            if allStudios.count > 0 {
                NavigationView {
                    List(allStudios, id:\.studioName) { studio_data in
                        HStack{
                            Text(studio_data.studioName)
                        }
                    }
                }
            }
            if !errorMessage.isEmpty{
                Text(errorMessage)
            }
            
        }
        .padding()
        .task {
            do {
               allStudios = try await fetchAllStudioDataApi()
            } catch{
                errorMessage = "no"
                print("hi")
                print("Error: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
