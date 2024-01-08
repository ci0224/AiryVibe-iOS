//
//  StudioDetail.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/7/24.
//

import SwiftUI

struct StudioDetail: View {
    var studio: Studio

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    if let logoUrl = studio.logo, let url = URL(string: logoUrl) {
                        AsyncImage(url: url){ phase in
                            switch phase {
                                case .empty:
                                    Text("Loading...")
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 40)
                                case .failure:
                                    Text("Failed to load logo")
                                @unknown default:
                                    Text("Unexpected state")
                                }
                        }
                        .frame(height: 40)
                    }
                    Text(studio.studioName)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                if let photographerName = studio.photographerName {
                    Text("Photographer: \(photographerName)")
                }

                if let summary = studio.studioSummary {
                    Text("Summary: \(summary)")
                }

                if let address = formatAddress(studio) {
                    Text("Address: \(address)")
                        .foregroundColor(.blue)
                }

                if let socialMediaData = studio.socialMediaData {
                    ForEach(socialMediaData, id: \.accountID) { media in
                        Text("\(media.platform): \(media.accountID)")
                    }
                }

                if let serviceData = studio.serviceData {
                    ForEach(serviceData, id: \.product_id) { service in
                        VStack(alignment: .leading) {
                            Text(service.serviceName).font(.headline)
                            ForEach(service.prices, id: \.price_id) { price in
                                Text("\(price.priceName): $\(price.price)")
                            }
                        }
                    }
                }

                if let timeData = studio.timeData {
                    ForEach(timeData, id: \.day) { time in
                        Text("\(time.day): \(time.start) - \(time.end)")
                    }
                }
            }
            .padding()
        }
    }

    private func formatAddress(_ studio: Studio) -> String? {
        var addressComponents = [String]()
        if let address1 = studio.address1 { addressComponents.append(address1) }
        if let address2 = studio.address2 { addressComponents.append(address2) }
        if let city = studio.addressCity { addressComponents.append(city) }
        if let state = studio.addressState { addressComponents.append(state) }
        if let zip = studio.addressZip { addressComponents.append(zip) }
        return addressComponents.isEmpty ? nil : addressComponents.joined(separator: ", ")
    }
}

#Preview {
    StudioDetail(studio:
                        Studio(
                            studioName: "Sunrise Photography",
                            photographerName: "Emily Johnson",
                            socialMediaData: [
                                SocialMedia(accountID: "sunrise_photo", platform: "Instagram"),
                                SocialMedia(accountID: "SunrisePhotography", platform: "Facebook")
                            ],
                            logo: "sunrise_logo.png",
                            cover: "studio_cover1.jpg",
                            serviceData: [
                                ServiceData(
                                    images: [S3Image(name: "wedding1.jpg", fileType: "jpg", url: "https://example.com/wedding1.jpg")],
                                    serviceName: "Wedding Photography",
                                    prices: [Price(price_id: "P1", description: "Full-day coverage", priceName: "Full Day", price: 1200, isAdjustable: false)],
                                    product_id: "WED123"
                                )
                            ],
                            timeData: [
                                TimeData(start: "09:00 AM", day: "Monday", end: "05:00 PM")
                            ],
                            address1: "123 Sunshine Blvd",
                            addressCity: "Pleasantville",
                            addressState: "CA",
                            addressZip: "12345",
                            studioSummary: "Specializing in wedding and event photography."
                        ))
}
