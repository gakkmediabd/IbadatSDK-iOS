//
//  FSCalendarLocale.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 8/8/22.
//

import Foundation
class FSCalendarLocale : FSCalendar{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBehavior()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        addBehavior()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addBehavior()
    }

    func addBehavior(){
        locale = Locale.init(identifier: "bn_BD")
    }
}


