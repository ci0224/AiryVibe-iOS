//
//  StudioDetail.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/7/24.
//

import SwiftUI

struct CarouselItem: View {
    let imageUrl: String

    var body: some View {
        // You can use an asynchronous image loading library or use your own logic to load the image from the URL
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure:
                Image(systemName: "exclamationmark.square")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 200, height: 200) // Adjust the size as needed
        .cornerRadius(10)
        .padding(10)
    }
}

struct StudioDetail: View {
    var studio: Studio
    @State private var selectedServiceIndex: Int = 0
    @State private var selectedPriceOptionIndex: Int = 0

    var body: some View {
        ScrollView {
            // basic info Vstack
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
                .padding(0)
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
                
                if let timeData = studio.timeData?.sorted() {
                    ForEach(timeData.indices, id: \.self) { index in
                        let time = timeData[index]
                        Text("\(time.day): \(time.start) - \(time.end)")
                    }
                }
            }
            .padding(0)
            
            Divider()
            // Service stack
            VStack(alignment: .leading, spacing: 10){
                if let selectedService = studio.serviceData?[selectedServiceIndex] {
                    
                    // Select service image stack
                    if selectedService.images.count != 0 {
                        // if selected service has images
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(selectedService.images, id: \.url) { image in
                                    CarouselItem(imageUrl: image.url)
                                }
                            }
                        }
                        Divider()
                    }
                    // selected price option info
                    VStack(alignment: .leading) {
                        Text("Description:\(selectedService.prices[selectedPriceOptionIndex].description)")
                        Text("Price: $\(String(format: "%.02f", Double(selectedService.prices[selectedPriceOptionIndex].price)/100))")
                        
                        Divider()
                    }
                }
                // service selection stack
                if let serviceData = studio.serviceData {
                    ScrollView(.horizontal) {
                        LazyHStack{
                            ForEach(serviceData.indices, id: \.self) { index in
                                
                                Button(action: {
                                    if selectedServiceIndex != index {
                                        selectedPriceOptionIndex = 0
                                        print("Price selected is reset")
                                    }
                                    selectedServiceIndex = index
                                    print("Item selected at index: \(index)")
                                }, label: {
                                    Text(serviceData[index].serviceName)
                                        .padding(16)
                                        .background(selectedServiceIndex==index ? Color.mint : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                })
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                    .padding(0)
                    Divider()
                }
                // price option selection stack
                if let priceOptions = studio.serviceData?[selectedServiceIndex].prices {
                    ScrollView(.horizontal) {
                        LazyHStack{
                            ForEach(priceOptions.indices, id: \.self) { index in
                                Button(action: {
                                    selectedPriceOptionIndex = index
                                    print("Item selected at index: \(index)")
                                }, label: {
                                    Text(priceOptions[index].priceName)
                                        .padding(6)
                                        .background(selectedPriceOptionIndex==index ? Color.mint : Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .controlSize(.small)
                                })

                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    }
                    .padding(0)
                    Divider()
                }
                
            }
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
                                    prices: [Price(price_id: "P1", description: "Full-day coverage", priceName: "Full Day", price: 1220, isAdjustable: false)],
                                    product_id: "WED123"
                                ),
                                ServiceData(
                                    images: [S3Image(name: "wedding1.jpg", fileType: "jpg", url: "https://example.com/wedding1.jpg")],
                                    serviceName: "Other Photography",
                                    prices: [Price(price_id: "P1", description: "Full-day coverage", priceName: "Full Day", price: 1220, isAdjustable: false)],
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
