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
    @State private var selectedStudio: Studio?
    var body: some View {
        NavigationStack {
            ScrollView {
                if allStudios.count > 0 {
                    LazyVStack(spacing: 10) {
                       ForEach(allStudios, id: \.studioName) { studio in
                           NavigationLink(value: studio) {
                               StudioCard(studio: studio)
                                   .foregroundColor(.primary)
                                   .navigationTitle("AiryVibe")
                           }
                        }
                    }
                }
                if !errorMessage.isEmpty{
                    Text(errorMessage)
                }
            }
            .navigationDestination(for: Studio.self) { studio in
                StudioDetail(studio: studio)
            }
        }
        .task {
            do {
               allStudios = try await fetchAllStudioDataApi()
            } catch {
                errorMessage = "Failed to fetch studio data."
                print("Error: \(error)")
            }
        }.contentMargins(4)
    }
}

#Preview {
    ContentView()
}
