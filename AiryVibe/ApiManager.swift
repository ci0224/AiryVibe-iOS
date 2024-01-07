//
//  ApiManager.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/6/24.
//

import UIKit

struct ApiPath: Codable {
    let path: String
}

struct ApiResponse:Codable {
    let statusCode: Int
    let studioData: [Studio]?
}

let apiUrl =  "https://a8z6txh0d7.execute-api.us-west-2.amazonaws.com/api"
let studioVisitCenterUrl = apiUrl+"/visitStudio"

func fetchAllStudioDataApi() async throws -> [Studio] {
    let path = ApiPath(path: "getAllStudioData")
    var request = URLRequest(url: URL(string: studioVisitCenterUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let encoder = JSONEncoder()
    print(path)
    let data = try encoder.encode(path)
    request.httpBody = data
    let (responseData, _) = try await URLSession.shared.upload(for: request, from: data)
    /*
    if let responseString = String(data: responseData, encoding: .utf8) {
        print(responseString)
    }
    */
    let decoder = JSONDecoder()
    var fullResponse = ApiResponse(statusCode:500, studioData:nil)
    do{
        fullResponse = try decoder.decode(ApiResponse.self, from: responseData)
        print("statusCode = \(fullResponse.statusCode)")
    } catch {
        print("error decoding JSON: \(error)")
    }
    
    let studios = fullResponse.studioData ?? []
    return studios
}
