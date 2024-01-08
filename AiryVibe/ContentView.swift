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
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach($allStudios, id: \.studioName) { studio in
                            StudioCard(studio_data: studio)
                                // No padding around each card
                        }
                    }
                }
                .padding(2)
            }
            if !errorMessage.isEmpty{
                Text(errorMessage)
            }
            
        }
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
