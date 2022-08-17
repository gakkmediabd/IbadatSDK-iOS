//
//  URLConstant.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 28/7/22.
//

import Foundation
import CoreLocation

internal class URLConstant{
    static let TOKEN = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI2MDE5Mzc3NjU3N2E3ZGYxM2VkYTRjNjciLCJVc2VySWQiOiI2MDE5Mzc3NjU3N2E3ZGYxM2VkYTRjNjciLCJVc2VyTmFtZSI6Ijg4MDE1Mzc2NzM5NzciLCJJbWFnZSI6IiIsInJvbGUiOiJ1c2VyIiwibmJmIjoxNjEyMjY1MzM1LCJleHAiOjE5Mjc2MjUzMzUsImlhdCI6MTYxMjI2NTMzNSwiaXNzIjoibG9sbGlwb3AiLCJhdWQiOiJsb2xsaXBvcCJ9.pA0fJa5dSCIJUuwmOY4RxQ0fSAQNhoZCHMaG94-ZkndOn9RxHqsEdq_uByTTQR3MCC2V_ajkcCBl7e4idNp5SA"
    static let USERNAME = "Gakkmedia"
    static let PASSWORD = "GaramD@nC0k@"
    
    static let QURAN_BASE_URL = "http://118.67.219.130:801/api"
    static let DUA_BASE_URL = "http://43.240.103.34/ebadattest/api"
    
    static let DUA_LIST = "\(DUA_BASE_URL)/dua"
    static let HADITH_LIST = "\(DUA_BASE_URL)/Hadith"
    
    static let SURAH_DETAILS = {(_ id : String)-> String in
        return "\(QURAN_BASE_URL)/ayat/ibadat/bysurah/\(id)-bn//"
    }
    static let SURAH_PLAY_URL = {(_ id : String)-> String in
        return "http://43.240.103.34/ebadattest/ftp/quran/\(id).mp3"}
    
    //id = 1 for salat learnign list/ after that item id will be pass throw here
    static let SALAT_LEARNNING = {(_ id : String)-> String in return "\(DUA_BASE_URL)/topic?id=\(id)&lang=bn"}
    static let SALAT_LEARNING_DETAILS = "\(DUA_BASE_URL)/topic?"
    
    static let WALLPAPER = "http://43.240.103.34/ebadattest/api/Content?portalCode=1872L0-Ibad&categoryCode=1873L1-Wall&contentType=wp"
    static  let ISLAMIC_HOLIDAY = "http://118.67.219.130:801/api/textcontent/bycategory/627c8495c44068285dde96c2/undefined/1/30"
    static let LIVE_VIDEO = "http://43.240.103.34/ebadattest/api/home?id=8801000000000&lang=bn&waqt=duhar"
    
    static let API_KEY_MAP = ""
    static let NEAR_BY_PLACE = {(_ apiKey : String,_ radius : String,_ lat : String,_ long:String)->String in
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=true&key=\(apiKey)&radius=\(radius)&location=\(lat),\(long)&type=mosque&language=bn"
    }
    static let NEAR_BY_PLACE_NEXT = {(_ apiKey : String,_ token : String)-> String in
        return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=\(token)&key=\(apiKey)"
    }
    static let APPLE_DIRECTION_URL = {(_ source : CLLocationCoordinate2D, _ destination : CLLocationCoordinate2D)-> String in
        return "http://maps.apple.com/?saddr=\(source.latitude),\(source.longitude)&daddr=\(destination.latitude),\(destination.longitude)"
    }
    
    static let ZAKAT = "http://118.67.219.130:801/api/textcontent/bycategory/6047013cf255bfe281719874/undefined/1/30"
}
