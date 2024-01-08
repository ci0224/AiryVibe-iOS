//
//  StudioDataModel.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/6/24.
//

import Foundation

// Studio struct with initializer
struct Studio: Codable, Hashable {
    static func == (lhs: Studio, rhs: Studio) -> Bool {
        return lhs.studioName == rhs.studioName
    }
    func hash(into hasher: inout Hasher) {
           hasher.combine(studioName)
   }
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
    init(studioName: String, photographerName: String? = nil, socialMediaData: [SocialMedia]? = nil, logo: String? = nil, cover: String? = nil, serviceData: [ServiceData]? = nil, timeData: [TimeData]? = nil, address1: String? = nil, address2: String? = nil, addressCity: String? = nil, addressState: String? = nil, addressZip: String? = nil, studioSummary: String? = nil) {
        self.studioName = studioName
        self.photographerName = photographerName
        self.socialMediaData = socialMediaData
        self.logo = logo
        self.cover = cover
        self.serviceData = serviceData
        self.timeData = timeData
        self.address1 = address1
        self.address2 = address2
        self.addressCity = addressCity
        self.addressState = addressState
        self.addressZip = addressZip
        self.studioSummary = studioSummary
    }
}

// SocialMedia struct with initializer
struct SocialMedia: Codable {
    let accountID: String
    let platform: String

    init(accountID: String, platform: String) {
        self.accountID = accountID
        self.platform = platform
    }
}

// ServiceData struct with initializer
struct ServiceData: Codable {
    let images: [S3Image]
    let serviceName: String
    let prices: [Price]
    let product_id: String

    init(images: [S3Image], serviceName: String, prices: [Price], product_id: String) {
        self.images = images
        self.serviceName = serviceName
        self.prices = prices
        self.product_id = product_id
    }
}

// S3Image struct with initializer
struct S3Image: Codable {
    let name: String
    let fileType: String
    let url: String

    init(name: String, fileType: String, url: String) {
        self.name = name
        self.fileType = fileType
        self.url = url
    }
}

// Price struct with initializer
struct Price: Codable {
    let price_id: String
    let description: String
    let priceName: String
    let price: Int
    let isAdjustable: Bool
    let timeReserve: Bool?
    let reserveTimeInMinute: Int?

    init(price_id: String, description: String, priceName: String, price: Int, isAdjustable: Bool, timeReserve: Bool? = nil, reserveTimeInMinute: Int? = nil) {
        self.price_id = price_id
        self.description = description
        self.priceName = priceName
        self.price = price
        self.isAdjustable = isAdjustable
        self.timeReserve = timeReserve
        self.reserveTimeInMinute = reserveTimeInMinute
    }
}

// TimeData struct with initializer
struct TimeData: Codable {
    let start: String
    let day: String
    let end: String

    init(start: String, day: String, end: String) {
        self.start = start
        self.day = day
        self.end = end
    }
}
