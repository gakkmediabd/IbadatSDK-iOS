//
//  AppData.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import Foundation
import CoreLocation
class AppData : NSObject{
    static let shared = AppData()
    private override init() {
    }
    
    private var userDefault = UserDefaults.standard
    
    var curentLat : Double {
        set{
            userDefault.set(newValue, forKey: "currentLat")
            userDefault.synchronize()
        }
        get{
            return userDefault.double(forKey: "currentLat")
        }
    }
    var currentLong : Double {
        set{
            userDefault.set(newValue, forKey: "currentLong")
            userDefault.synchronize()
        }
        get{
            return userDefault.double(forKey: "currentLong")
        }
    }
    var currentLocation: CLLocation {
      get { return CLLocation(latitude: latitude ?? 23.752536308706137, longitude: longitude ?? 90.38093516615558) } // default value is North Pole (lat: 90, long: 0)
      set { latitude = newValue.coordinate.latitude
            longitude = newValue.coordinate.longitude }
    }
    
    private var latitude: Double? {
      get {
          if let _ = userDefault.object(forKey: #function) {
              return userDefault.double(forKey: #function)
        }
        return nil
      }
        set { userDefault.set(newValue, forKey: #function) }
    }
    
    private var longitude: Double? {
      get {
          if let _ = userDefault.object(forKey: #function) {
              return userDefault.double(forKey: #function)
        }
        return nil
      }
        set { userDefault.set(newValue, forKey: #function) }
    }
    
    var isTasbiSoundEnable : Bool{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.bool(forKey: #function)
        }
    }
    var SUBAHANALLAH : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var ALHAMDULILLAH : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var BISMILLAH : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var ALLAHU_AKBAR : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var ALLAH : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var ASTAGFIRULLAH  : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var LA_ILAHA_ILLALLAH : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var LA_HAWALA : Int{
        set{
            userDefault.set(newValue, forKey: #function)
            userDefault.synchronize()
        }get{
            return userDefault.integer(forKey: #function)
        }
    }
    var ALL_COUNT : Int  {
        get{
            return SUBAHANALLAH  + ALHAMDULILLAH + BISMILLAH + ALLAHU_AKBAR + ALLAH + ASTAGFIRULLAH + LA_ILAHA_ILLALLAH + LA_HAWALA
        }
    }
    func increseTasbi(type : TashbiType){
        switch type {
        case .SubahanAllah:
            SUBAHANALLAH =  SUBAHANALLAH + 1
        case .Alhamdulilla:
            ALHAMDULILLAH = ALHAMDULILLAH + 1
        case .Bismillahh:
            BISMILLAH = BISMILLAH + 1
        case .Astagfirullah:
            ASTAGFIRULLAH = ASTAGFIRULLAH + 1
        case .AllahuAkbbar:
            ALLAHU_AKBAR = ALLAHU_AKBAR + 1
        case .Allah:
            ALLAH = ALLAH + 1
        case .LaIlaha:
            LA_ILAHA_ILLALLAH = LA_ILAHA_ILLALLAH + 1
        case .LaHawla:
            LA_HAWALA = LA_HAWALA + 1
        }
    }
    func getTasbiCount(type : TashbiType)-> Int{
        switch type {
        case .SubahanAllah:
            return SUBAHANALLAH
        case .Alhamdulilla:
            return ALHAMDULILLAH
        case .Bismillahh:
            return BISMILLAH
        case .Astagfirullah:
            return ASTAGFIRULLAH
        case .AllahuAkbbar:
            return ALLAHU_AKBAR
        case .Allah:
            return ALLAH
        case .LaIlaha:
            return LA_ILAHA_ILLALLAH
        case .LaHawla:
            return LA_HAWALA
        }
    }
    func resetTashbi(){
        SUBAHANALLAH = 0
        ALHAMDULILLAH = 0
        BISMILLAH = 0
        ALLAHU_AKBAR = 0
        ALLAH = 0
        ASTAGFIRULLAH = 0
        LA_ILAHA_ILLALLAH = 0
        LA_HAWALA = 0
    }
}
