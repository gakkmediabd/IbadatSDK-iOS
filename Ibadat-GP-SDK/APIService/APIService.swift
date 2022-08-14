//
//  APIService.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import Foundation
import AVFoundation

class APIService : NSObject{
    static let instant = APIService()
    private override init() {
    }
    
    private var main = DispatchQueue.main
    
    func allDua(complete : @escaping(Result<[DuaModel],Error>)->Void ){
        guard let url = URL(string: URLConstant.DUA_LIST) else {
            fatalError("Dua list url not work")
        }
        let loginString = "\(URLConstant.USERNAME):\(URLConstant.PASSWORD)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode([DuaModel].self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    func allHadith(complete : @escaping(Result<[HadithModel],Error>)->Void ){
        
        guard let url = URL(string: URLConstant.HADITH_LIST) else {
            fatalError("Dua list url not work")
        }
        let loginString = "\(URLConstant.USERNAME):\(URLConstant.PASSWORD)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode([HadithModel].self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    func getSurahDetails(id: String, complete : @escaping (Result<SurahDetails,Error>)->Void){
        guard let url = URL(string: URLConstant.SURAH_DETAILS(id)) else {
            fatalError("Surah details url not work")
        }
        

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                //let str = String(data: data, encoding: .utf8)
                do{
                    let arr = try newJSONDecoder().decode(SurahDetails.self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
        }
        
        
        task.resume()
    }
    
    func getSalatLearningList(id : String,complete : @escaping (Result<[SalatLearningModel],Error>)->Void){
        guard let url = URL(string: URLConstant.SALAT_LEARNNING("\(id)")) else {
            fatalError("Dua list url not work")
        }
        let loginString = "\(URLConstant.USERNAME):\(URLConstant.PASSWORD)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode([SalatLearningModel].self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    func getSalatDetails(id : String, complete : @escaping (Result<SalatLearningModel,Error>)->Void){
        let params : [String:String] = ["id":"\(id)","type":"0","lang" : "bn","msisdn" : "01917589656"]
        guard var componant = URLComponents(string: URLConstant.SALAT_LEARNING_DETAILS) else{
            fatalError("URL Componant not maked")
        }
        componant.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        let loginString = "\(URLConstant.USERNAME):\(URLConstant.PASSWORD)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        guard let url = componant.url else{
            fatalError("Url not make")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                 //let str = String(data: data, encoding: .utf8)
                do{
                    let arr = try JSONDecoder().decode([SalatLearningModel].self, from: data)
                    if let first = arr.first{
                        complete(.success(first))
                    }
                    
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    func getWallpaper(complete : @escaping(Result<[WallpaperModel],Error>)->Void){
        guard let url = URL(string: URLConstant.WALLPAPER) else {
            fatalError("Dua list url not work")
        }
        let loginString = "\(URLConstant.USERNAME):\(URLConstant.PASSWORD)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode([WallpaperModel].self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    func getIslamicHoliday(complete : @escaping (Result<IslamicHolidayResponse,Error>)-> Void){
        guard let url = URL(string: URLConstant.ISLAMIC_HOLIDAY) else {
            fatalError("Dua list url not work")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(URLConstant.TOKEN, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode(IslamicHolidayResponse.self, from: data)
                    complete(.success(arr))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    func getLiveVideo(complete :@escaping (Result<[LiveVideo],Error>)-> Void){
        guard let url = URL(string: URLConstant.LIVE_VIDEO) else {
            fatalError("live video url not work")
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                //let str = String(data: data, encoding: .utf8)
                do{
                    let arr = try JSONDecoder().decode(LiveModel.self, from: data)
                    complete(.success(arr.liveVideo))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
    
    func getMosque(radius km : String,complete:@escaping(_ list : [MosqueModel],_ token : String,_ error : String?)->Void){
        guard let url = URL(string: URLConstant.NEAR_BY_PLACE(URLConstant.API_KEY_MAP,km,"\(AppData.shared.currentLocation.coordinate.latitude)","\(AppData.shared.currentLocation.coordinate.longitude)")) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete([],"",error?.localizedDescription)
                    return
                }
                _ = String(data: data, encoding: .utf8)
                do{
                    let arr = try JSONDecoder().decode(NearByPlace.self, from: data)
                    let response = self.mapDataNormalize(allData: arr.results)
                    complete(response,arr.nextPageToken,nil)
                }catch{
                    complete([],"",error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    func getNextMosque(token : String,complete:@escaping(_ list : [MosqueModel],_ token : String,_ error : String?)->Void){
        guard let url = URL(string: URLConstant.NEAR_BY_PLACE_NEXT(URLConstant.API_KEY_MAP,token)) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete([],"",error?.localizedDescription)
                    return
                }
                //let str = String(data: data, encoding: .utf8)
                do{
                    let arr = try JSONDecoder().decode(NearByPlace.self, from: data)
                    let response = self.mapDataNormalize(allData: arr.results)
                    complete(response,arr.nextPageToken,nil)
                }catch{
                    complete([],"",error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    private func mapDataNormalize(allData : [MosqueResult])->[MosqueModel]{
        var arr : [MosqueModel] = []
        
        allData.forEach { mr in
            let mos = MosqueModel(lat: mr.geometry.location.lat, long: mr.geometry.location.lng, name: mr.name, address: mr.vicinity)
            arr.append(mos)
        }
        
        return arr
    }
    
    func getZakat(complete : @escaping (Result<[ZakatModel],Error>)-> Void){
        guard let url = URL(string: URLConstant.ZAKAT) else {
            fatalError("Dua list url not work")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(URLConstant.TOKEN, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            self.main.async {
                guard let data = data else {
                    complete(.failure(error!))
                    return
                }
                do{
                    let arr = try JSONDecoder().decode(ZakatResponse.self, from: data)
                    complete(.success(arr.data))
                }catch{
                    complete(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}
