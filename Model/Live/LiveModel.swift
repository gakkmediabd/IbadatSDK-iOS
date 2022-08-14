//
//  LiveModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import Foundation

// MARK: - LiveModel
struct LiveModel: Codable {
    var billboardList: [BillboardList]
    var catagoryList: String?
    var namazerSomoiSuchiList: [NamazerSomoiSuchiList]
    var protidinArOnupreronaList: [ProtidinArOnupreronaList]
    var ajkerHadithList: [AjkerHadithList]
    var liveVideo: [LiveVideo]
    var allahARNameList: [AllahARNameList]

    enum CodingKeys: String, CodingKey {
        case billboardList = "BillboardList"
        case catagoryList = "CatagoryList"
        case namazerSomoiSuchiList = "NamazerSomoiSuchiList"
        case protidinArOnupreronaList = "ProtidinArOnupreronaList"
        case ajkerHadithList = "AjkerHadithList"
        case liveVideo = "LiveVideo"
        case allahARNameList = "AllahARNameList"
    }
}



// MARK: - AjkerHadithList
struct AjkerHadithList: Codable {
    var categoryCode: String
    var previewImage: String
    var userID: String?
    var isFavourite: String

    enum CodingKeys: String, CodingKey {
        case categoryCode = "CategoryCode"
        case previewImage = "PreviewImage"
        case userID = "UserId"
        case isFavourite
    }
}



// MARK: - AllahARNameList
struct AllahARNameList: Codable {
    var serial, name, meaning, arabic: String
    var fazilat: String
    var preview: String
    var audio: String
    var smallPreview: String

    enum CodingKeys: String, CodingKey {
        case serial = "Serial"
        case name = "Name"
        case meaning = "Meaning"
        case arabic = "Arabic"
        case fazilat = "Fazilat"
        case preview = "Preview"
        case audio = "Audio"
        case smallPreview = "SmallPreview"
    }
}



// MARK: - BillboardList
struct BillboardList: Codable {
    var categoryCode, contentCode: String
    var bannerPreview: String
    var todayDate, crash: String?

    enum CodingKeys: String, CodingKey {
        case categoryCode = "CategoryCode"
        case contentCode = "ContentCode"
        case bannerPreview
        case todayDate = "TodayDate"
        case crash
    }
}



// MARK: - LiveVideo
struct LiveVideo: Codable {
    var id, name, videoLink: String
    var previewImage: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case videoLink = "VideoLink"
        case previewImage = "PreviewImage"
    }
}



// MARK: - NamazerSomoiSuchiList
struct NamazerSomoiSuchiList: Codable {
    var categoryCode: String?
    var todayDate, oktoName, oktoTime: String
    var azanAudio: String

    enum CodingKeys: String, CodingKey {
        case categoryCode = "CategoryCode"
        case todayDate = "TodayDate"
        case oktoName = "OktoName"
        case oktoTime
        case azanAudio = "AzanAudio"
    }
}


// MARK: - ProtidinArOnupreronaList
struct ProtidinArOnupreronaList: Codable {
    var id: String
    var previewImage: String
    var protidinArOnupreronaListDescription: String?
    var isFavourite: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case previewImage = "PreviewImage"
        case protidinArOnupreronaListDescription = "Description"
        case isFavourite
    }
}
