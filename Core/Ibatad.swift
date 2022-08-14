//
//  Ibatad.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 28/7/22.
//

import Foundation
import UIKit

public class IbadatSdkCore : NSObject{
    public static let shared = IbadatSdkCore()
    private override init() {
        super.init()
        
    }
    
    
    private func openFeature(by type : FeatureType)-> UINavigationController{
        
        switch type {
        case .SURAH:
            return UINavigationController(rootViewController: SurahVC())
        case .DUA:
            return UINavigationController(rootViewController: DuaVC())
        case .HADITH:
            return UINavigationController(rootViewController: HadithVC())
        case .TASBIH:
            return UINavigationController(rootViewController: TasbihVC())
        case .WALLPAPER:
            return UINavigationController(rootViewController: WallpaperVC())
        case .None:
            break
        case .SALAT:
            return UINavigationController(rootViewController: SalatLearningVC())
        case .COMPASS:
            return UINavigationController(rootViewController: CompassVC())
        case .CALENDAR:
            return UINavigationController(rootViewController: IslamicCalenderVC())
        case .SALAT_TIME:
            return UINavigationController(rootViewController: SalatTimeVC())
        case .IFTER_SEHRI:
            return UINavigationController(rootViewController: ifterSehriVC())
        case .LIVE_VIDEO:
            return UINavigationController(rootViewController: LiveVideoVC())
        case .NEARIST_MOSQUE:
            return UINavigationController(rootViewController: NearestMosqueVC())
        case .ZAKAT:
            return UINavigationController(rootViewController: ZakatVC())
        }
        return UINavigationController(rootViewController: SurahVC())
    }
    public func openFeature(by type : FeatureType,presentController : UIViewController){
        let nav =  openFeature(by: type)
        //nav.modalPresentationStyle = .fullScreen
        nav.navigationBar.backgroundColor  =  .tintColor
        presentController.present(nav, animated: true)
    }
}

public enum FeatureType : Int{
    case SURAH = 1
    case DUA = 2
    case HADITH = 3
    case TASBIH  = 4
    case SALAT = 5
    case SALAT_TIME = 9
    case WALLPAPER = 6
    case COMPASS = 7
    case CALENDAR = 8
    case IFTER_SEHRI =  10
    case LIVE_VIDEO = 11
    case NEARIST_MOSQUE = 12
    case ZAKAT = 13
    case None = 0
}

