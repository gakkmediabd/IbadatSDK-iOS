//
//  HadithModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import Foundation

// MARK: - HadithModelElement
struct HadithModel: Codable {
    var id, title, narrator, hadithModelDescription: String
    var source, serial: String
    var sort: String?
    var isFavorite: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case narrator = "Narrator"
        case hadithModelDescription = "Description"
        case source = "Source"
        case serial = "Serial"
        case sort = "Sort"
        case isFavorite = "IsFavorite"
    }
}
