//
//  ApiManager.swift
//  AiryVibe
//
//  Created by 黄熙 on 1/6/24.
//

import UIKit

struct apiPath: Codable {
    let path: String
}

struct ApiResponse:Codable {
    let statusCode: Int
    let studioData: [Studio]?
}

let apiUrl =  "https://a8z6txh0d7.execute-api.us-west-2.amazonaws.com/api"
let studioVisitCenterUrl = apiUrl+"/visitStudio"

func fetchAllStudioDataApi() async throws -> [Studio] {
    let path = apiPath(path: "getAllStudioData")
    var request = URLRequest(url: URL(string: studioVisitCenterUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let encoder = JSONEncoder()
    print(path)
    let data = try encoder.encode(path)
    request.httpBody = data
    print(data)
    let (responseData, _) = try await URLSession.shared.upload(for: request, from: data)
    print(responseData)
    if let responseString = String(data: responseData, encoding: .utf8) {
        print(responseString)
        print("this is good")
        // attempt
        // simulate data
        let sim_res_string = "\"{\"statusCode\": 200}\""
        print("sim_res_string", sim_res_string)
        
        if let jsonData = sim_res_string.data(using: .utf8) {
            do {
                // Parse the JSON Data
                let decodedString = try JSONDecoder().decode(String.self, from: jsonData)
                print("decodedString", decodedString) // This will print "name"
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Error: Unable to convert string to Data")
        }
        do {
            if let innerJsonString = try JSONSerialization.jsonObject(with: responseData, options: []) as? String {
                // Step 2: Second Parsing - Handle the inner JSON string
                if let innerJsonData = innerJsonString.data(using: .utf8) {
                    do {
                        if let jsonDict = try JSONSerialization.jsonObject(with: innerJsonData, options: []) as? [String: Any] {
                            // Access the data
                            if let statusCode = jsonDict["statusCode"] as? Int {
                                print("Status Code: \(statusCode)")
                            }
                        }
                    } catch {
                        print("Error parsing inner JSON: \(error)")
                    }
                }
            }
        } catch {
            print("Error parsing outer JSON: \(error)")
        }
    }
    // Decode the responseData into an array of Studio objects
    let decoder = JSONDecoder()
    var fullResponse = ApiResponse(statusCode:0,studioData:nil)
    do{
        fullResponse = try decoder.decode(ApiResponse.self, from: responseData)
        print("statusCode = \(fullResponse.statusCode)")
    } catch {
        print("error decoding JSON: \(error)")
    }
    
    print("statusCode = \(fullResponse.statusCode)")
    
    print(fullResponse.studioData)
    let studios = try decoder.decode([Studio].self, from: responseData)
    return studios
}
