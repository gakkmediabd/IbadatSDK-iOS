//
//  AppImage.swift
//  Shadhin
//
//  Created by Admin on 19/6/22.
//  Copyright © 2022 Cloud 7 Limited. All rights reserved.
//

import Foundation
import UIKit

enum AppImage : String{
    
    typealias RawValue = String
    
    //version compactability . value change for diffrent version
    
    //Tashbi
    case sound = "sound_on"
    case noSound = "sound_off"
    case reset = "reset"
    case circel = "circel"
    case circel_fill = "circel_fill"
    //Surah
    case play = "icon_play"
    case pause = "icon_pause"
    //Near by place
    case map = "map.fill"
    case mosque = "mosque_on"
    case mosque_marker = "mosq"
    
    //salat
    case notificationOn = "bell.fill"
    case notificationOff = "bell.slash.fill"
    
    //get uiImage from appImage
    var uiImage : UIImage?{
        if #available(iOS 13, *){
            return  UIImage(systemName: rawValue) ?? UIImage(named: rawValue, in: Bundle.bundle, compatibleWith: nil)
        }
        return UIImage(named: rawValue, in: Bundle.bundle, compatibleWith: nil)
    }
    //get system image with tint color
    @available(iOS 13.0, *)
    func uiImage(with fontSize : CGFloat? = nil, tintColor : UIColor? = nil)-> UIImage?{
        var image = uiImage
        if let fontSize = fontSize {
            let font = UIFont.systemFont(ofSize: fontSize)
            image = image?.withConfiguration(UIImage.SymbolConfiguration(font: font))
        }
        if let tintColor = tintColor {
            return image?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        }else{
            return image
        }
    }
}
