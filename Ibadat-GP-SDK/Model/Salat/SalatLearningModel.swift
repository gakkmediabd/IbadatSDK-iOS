//
//  SalatLearningModel.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import Foundation
// MARK: - SurahDetail
struct SalatLearningModel : Codable {
    var id, topicName: String?
    var topicDescription, isFavorite: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case topicName = "TopicName"
        case topicDescription = "TopicDescription"
        case isFavorite = "IsFavorite"
    }
}
