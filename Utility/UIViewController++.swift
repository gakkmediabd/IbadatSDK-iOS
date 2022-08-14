//
//  UIViewController++.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 3/8/22.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title : String? = ConstantData.ALERT, message : String?, done : String? = nil, cancel : String = ConstantData.CANCEL, complete : (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: cancel, style: .destructive) { action in
            
        }
        if let done = done {
            let ok = UIAlertAction(title: done, style: .default) { action in
                if let complete = complete {
                    complete()
                }
            }
            alert.addAction(ok)
        }
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}
//MARK: prayer time get
extension UIViewController{
    func getPrayerTime(with cordinate : Coordinates,date : Date)-> PrayerTimes?{
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let prayerDate = cal.dateComponents([.year, .month, .day], from: date)
        var params = CalculationMethod.karachi.params
        params.madhab = .hanafi
        return PrayerTimes(coordinates: cordinate, date: prayerDate, calculationParameters: params)
    }
    
}
