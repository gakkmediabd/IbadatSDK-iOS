//
//  WallpaperModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import Foundation
// MARK: - WallpaperModelElement
struct WallpaperModel: Codable {
    var contentCode: String
    var title: String
    var previwURL: String
    var ownerName: String
    var typeName: String
    var physicalURL: String
    var contentType: String
    var rbtgp, rbtRobi, rbtAirtel, rbttt: String?
    var rbtBanglalink: String?

    enum CodingKeys: String, CodingKey {
        case contentCode, title
        case previwURL = "previwUrl"
        case ownerName, typeName
        case physicalURL = "physicalUrl"
        case contentType
        case rbtgp = "RBTGP"
        case rbtRobi = "RBTRobi"
        case rbtAirtel = "RBTAirtel"
        case rbttt = "RBTTT"
        case rbtBanglalink = "RBTBanglalink"
    }
}
