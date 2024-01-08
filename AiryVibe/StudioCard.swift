//
//  StudioCard.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/7/24.
//

import SwiftUI

struct StudioCard: View {
    @Binding var studio_data : Studio
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // First Row: Cover Image
            if let cover = studio_data.cover, let imageUrl = URL(string: cover), let imageData = try? Data(contentsOf: imageUrl), let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
            } else {
                Image(systemName: "photo") // Placeholder image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 180)
            }

            // Second Row: Studio Name
            Text(studio_data.studioName)

            // Third Row: City, State and "AiryVibe"
            HStack {
                if let city = studio_data.addressCity, let state = studio_data.addressState {
                    Text("\(city), \(state)")
                }
                Spacer()
                Text("AiryVibe")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color(red: 122, green: 122, blue: 122))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

