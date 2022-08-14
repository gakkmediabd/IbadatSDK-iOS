//
//  File.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 4/8/22.
//

import Foundation

extension String{
    var banglaNumber : String{
        var number = self.replacingOccurrences(of: "0", with: "০").replacingOccurrences(of: "1", with: "১").replacingOccurrences(of: "2", with: "২").replacingOccurrences(of: "3", with: "৩").replacingOccurrences(of: "4", with: "৪").replacingOccurrences(of: "5", with: "৫").replacingOccurrences(of: "6", with: "৬").replacingOccurrences(of: "7", with: "৭").replacingOccurrences(of: "8", with: "৮").replacingOccurrences(of: "9", with: "৯")
        if number.count == 1{
            number = "০\(number)"
        }
        return number
    }
    var toDouble : Double?{
        return Double(self)
    }
}
