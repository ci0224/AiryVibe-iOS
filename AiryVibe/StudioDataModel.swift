//
//  StudioDataModel.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/6/24.
//

import Foundation


// Main structure representing each studio
struct Studio: Codable {
    let studioName: String
    let photographerName: String?
    let socialMediaData: [SocialMedia]?
    let logo: String?
    let cover: String?
    let serviceData: [ServiceData]?
    let timeData: [TimeData]?
    let address1: String?
    let address2: String?
    let addressCity: String?
    let addressState: String?
    let addressZip: String?
    let studioSummary: String?
}

// Structure for social media data
struct SocialMedia: Codable {
    let accountID: String
    let platform: String
}

// Structure for service data
struct ServiceData: Codable {
    let images: [S3Image]
    let serviceName: String
    let prices: [Price]
    let product_id: String
}

// Structure for each image in service data
struct S3Image: Codable {
    let name: String
    let fileType: String
    let url: String
}

// Structure for price information in service data
struct Price: Codable {
    let price_id: String
    let description: String
    let priceName: String
    let price: Int
    let isAdjustable: Bool
    let timeReserve: Bool?
    let reserveTimeInMinute: Int?
}

// Structure for time data
struct TimeData: Codable {
    let start: String
    let day: String
    let end: String
}
