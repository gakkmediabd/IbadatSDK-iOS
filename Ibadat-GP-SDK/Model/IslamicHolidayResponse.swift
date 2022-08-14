//
//  IslamicHolidayResponse.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import Foundation

// MARK: - WallpaperModel
struct IslamicHolidayResponse: Codable {
    var status: Int
    var message: String
    var totalRecords: Int
    var data: [IslamicHolidayModel]
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
struct IslamicHolidayModel: Codable {
    var category, categoryName: String
    var subcategory, subcategoryName: String?
    var title, text: String
    var textInArabic: String?
    var pronunciation, refURL, imageURL, billBoardImageURL: String?
    var exImageOneURL, exImageTwoURL, exImageThreeURL, exImageFourURL: String?
    var exImageFiveURL: String?
    var contentBaseURL: String
    var userFavoriteThis: Bool
    var id, createdBy, createdOn: String
    var updatedBy, updatedOn: String?
    var isActive: Bool
    var language: String
    var order: Int
    var about: String?

    enum CodingKeys: String, CodingKey {
        case category, categoryName, subcategory, subcategoryName, title, text, textInArabic, pronunciation
        case refURL = "refUrl"
        case imageURL = "imageUrl"
        case billBoardImageURL = "billBoardImageUrl"
        case exImageOneURL = "exImageOneUrl"
        case exImageTwoURL = "exImageTwoUrl"
        case exImageThreeURL = "exImageThreeUrl"
        case exImageFourURL = "exImageFourUrl"
        case exImageFiveURL = "exImageFiveUrl"
        case contentBaseURL = "contentBaseUrl"
        case userFavoriteThis, id, createdBy, createdOn, updatedBy, updatedOn, isActive, language, order, about
    }
}

