//
//  NearByPlace.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import Foundation

// MARK: - NearByPlace
struct NearByPlace: Codable {
    var htmlAttributions: [String]?
    var nextPageToken: String
    var results: [MosqueResult]
    var status: String

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case nextPageToken = "next_page_token"
        case results, status
    }
}


// MARK: - Result
struct MosqueResult: Codable {
    var businessStatus: String
    var geometry: Geometry
    var icon: String
    var iconBackgroundColor: String
    var iconMaskBaseURI: String
    var name: String
    var openingHours: OpeningHours?
    var placeID: String
    var plusCode: PlusCode?
    var reference: String
    var scope: String
    var types: [String]
    var vicinity: String
    var photos: [Photo]?
    var rating: Double?
    var userRatingsTotal: Int?
    var permanentlyClosed: Bool?

    enum CodingKeys: String, CodingKey {
        case businessStatus = "business_status"
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case name
        case openingHours = "opening_hours"
        case placeID = "place_id"
        case plusCode = "plus_code"
        case reference, scope, types, vicinity, photos, rating
        case userRatingsTotal = "user_ratings_total"
        case permanentlyClosed = "permanently_closed"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    var location: Location
    var viewport: Viewport
}



// MARK: - Location
struct Location: Codable {
    var lat, lng: Double
}

// MARK: - Viewport
struct Viewport: Codable {
    var northeast, southwest: Location
}


// MARK: - OpeningHours
struct OpeningHours: Codable {
    var openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}


// MARK: - Photo
struct Photo: Codable {
    var height: Int
    var htmlAttributions: [String]
    var photoReference: String
    var width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}


// MARK: - PlusCode
struct PlusCode: Codable {
    var compoundCode, globalCode: String

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

