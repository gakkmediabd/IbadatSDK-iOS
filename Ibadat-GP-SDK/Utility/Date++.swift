//
//  Date++.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 3/8/22.
//

import Foundation

extension Date{
    func englishComponent(_ unit: Calendar.Component, value: Int) -> Date? {
            return Calendar.current.date(byAdding: unit, value: value, to: self)
        }
        
        func arabicComponent(_ unit: Calendar.Component, value: Int) -> Date?{
            let calendar = Calendar(identifier: .islamicUmmAlQura)
            return calendar.date(byAdding: unit, value: value, to: self)
        }
        
    func getDateToString()-> String{
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMMM d"
        dateFormate.locale = Locale(identifier: "bn")
        return dateFormate.string(from: self)
    }
    func getTimeToString()-> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "bn")
        return formatter.string(from: self)
    }
    func getMediumTimeToString()-> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "bn")
        return formatter.string(from: self)
    }
    func getString()-> String{
        let time = Int(timeIntervalSince1970)
        return "\(time)"
        
    }
    var hour : Int {
        return Calendar.current.component(.hour, from: self)
    }
    var minute : Int{
        return Calendar.current.component(.minute, from: self)
    }
    var second : Int  {
        return Calendar.current.component(.second, from: self)
    }
    var day : Int  {
        return Calendar.current.component(.day, from: self)
    }
    var month : Int{
        return Calendar.current.component(.month, from: self)
    }
    var year : Int {
        return Calendar.current.component(.year, from: self)
    }
}
extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            //let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            //return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
            return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        }
    }
