//
//  StudioCard.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/7/24.
//

import SwiftUI
import URLImage

struct StudioCard: View {
    var studio : Studio
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // First Row: Cover Image
            
            HStack(alignment: .center) {
                Spacer()
                if let coverURLString = studio.cover, !coverURLString.isEmpty,
                    let coverURL = URL(string: coverURLString) {
                    URLImage(coverURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 180, alignment: .center)
                    }
                } else {
                    Image(systemName: "photo") // Placeholder image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 180)
                }
                Spacer()
            }
            // Second Row: Studio Name
            HStack {
                Text(studio.studioName)
            }
            // Third Row: City, State and "AiryVibe"
            HStack {
                if let city = studio.addressCity, let state = studio.addressState {
                    Text("\(city), \(state)")
                }
                Spacer()
                Text("AiryVibe")
            }
            .font(.subheadline)
        }
        .padding(2)
        .background(Color(red: 122, green: 122, blue: 122))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

