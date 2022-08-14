//
//  SurhaDetailsModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import Foundation
// MARK: - SurahDetails
struct SurahDetails: Codable {
    var status: Int
    var message: String
    var totalRecords: Int
    var data: [AyatModel]
    var error: String?
}

// Datum.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)
//
// To read values from URLs:
//
//   let task = URLSession.shared.datumTask(with: url) { datum, response, error in
//     if let datum = datum {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Datum
struct AyatModel: Codable {
    var surahID, text, textInArabic: String
    var pronunciation, imageURL, contentURL, surah: String?
    var contentBaseURL: String
    var id, createdBy, createdOn: String
    var updatedBy, updatedOn: String?
    var isActive: Bool
    var language: String
    var order: Int
    var about: String?

    enum CodingKeys: String, CodingKey {
        case surahID = "surahId"
        case text, textInArabic, pronunciation
        case imageURL = "imageUrl"
        case contentURL = "contentUrl"
        case surah
        case contentBaseURL = "contentBaseUrl"
        case id, createdBy, createdOn, updatedBy, updatedOn, isActive, language, order, about
    }
}
