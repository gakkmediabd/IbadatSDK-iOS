//
//  ZakatResponse.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 10/8/22.
//

import Foundation

// MARK: - ZakatResponse
struct ZakatResponse: Codable {
    var status: Int
    var message: String
    var totalRecords: Int
    var data: [ZakatModel]
    var error: String?
}

// MARK: - Datum
struct ZakatModel: Codable {
    var category, categoryName: String
    var subcategory: String?
    var subcategoryName: String?
    var title, text: String
    var textInArabic, pronunciation, refURL, imageURL: String?
    var billBoardImageURL, exImageOneURL, exImageTwoURL, exImageThreeURL: String?
    var exImageFourURL, exImageFiveURL: String?
    var contentBaseURL: String
    var userFavoriteThis: Bool
    var id, createdBy, createdOn, updatedBy: String
    var updatedOn: String
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
