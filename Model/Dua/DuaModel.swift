//
//  DuaModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import Foundation

// MARK: - DuaModelElement
struct DuaModel: Codable {
    var id, title, dua, pronounciation: String
    var meaning, fazilat: String
    var createdBy: String?
    var sort: Int
    var expire: String
    var serial, isFavorite: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case dua = "Dua"
        case pronounciation = "Pronounciation"
        case meaning = "Meaning"
        case fazilat = "Fazilat"
        case createdBy = "CreatedBy"
        case sort = "Sort"
        case expire = "Expire"
        case serial = "Serial"
        case isFavorite = "IsFavorite"
    }
}
