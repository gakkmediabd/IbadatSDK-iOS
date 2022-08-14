//
//  CalenderCell.swift
//  Noor-Celcom
//
//  Created by Eashan on 2/8/21.
//

import UIKit

class CalenderCell: UICollectionViewCell {

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var height: CGFloat {
        return 280
    }
    
    @IBOutlet weak var calendarView: FSCalendarLocale!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    var monthValue : Int = 0
    var currentDate : Date = Date()
    
    fileprivate let hijri = Calendar(identifier: .islamicUmmAlQura)
    
    var localeIdentifier: String = "bn" {
        didSet{
            self.monthLbl.text = self.getIslamicCalender(unit: .month, value: 0, date: Date())
        }
    }
    
    fileprivate var isPrevious: Bool = false
    
    private var currentPage: Date?

    private lazy var today: Date = {
        return Date()
    }()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        //calendarView.locale = Locale(identifier: "bn")
        self.initialSetup()

        monthLbl.adjustsFontSizeToFitWidth = true
        calendarView.delegate = self
        calendarView.dataSource = self
        //calendarView.locale = Locale(identifier: localeIdentifier)
       
        self.calendarView.appearance.headerDateFormat = "MMM, yyyy"
        self.calendarView.select(Date())
        self.calendarView.locale = Locale(identifier: "bn")
    }
    
    
    func initialSetup(){
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        self.nextBtn.addTarget(self, action: #selector(moveCurrentPage(sender:)), for: .touchDown)
        self.previousBtn.addTarget(self, action: #selector(moveCurrentPage(sender:)), for: .touchDown)
        
    }
    
    func getIslamicCalender(unit: Calendar.Component, value: Int, date: Date) -> String {
        let hijri = Calendar(identifier: .islamicUmmAlQura)
        
        let formatter = DateFormatter()
        formatter.calendar = hijri
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        //print("identifier-->\(localeIdentifier)")
        formatter.locale = Locale(identifier: localeIdentifier)
//        formatter.locale = Locale(identifier: "bn")
        
        let today = hijri.date(byAdding: unit, value: value, to: date)
        return formatter.string(from: today!)
    }
    @objc
    private func moveCurrentPage(sender : UIButton) {
        let moveUp = sender == self.nextBtn ? true : false 
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
}

extension CalenderCell : FSCalendarDataSource, FSCalendarDelegateAppearance{
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.monthLbl.text = self.getIslamicCalender(unit: .month, value: 0, date: calendar.currentPage)
    }

}

extension Date {
    func monthAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMMM")
        return df.string(from: self)
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}

extension Date {
    var monthMedium: String  { return Formatter.monthMedium.string(from: self) }
    var hour12:  String      { return Formatter.hour12.string(from: self) }
    var minute0x: String     { return Formatter.minute0x.string(from: self) }
    var amPM: String         { return Formatter.amPM.string(from: self) }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

extension FSCalendarScope {
    func asCalendarComponent() -> Calendar.Component {
        switch (self) {
        case .month: return .month
        case .week: return .weekOfYear
        @unknown default: return .month
        }
     }
}

extension Date{
    func addMonth(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: n, to: self)!
    }
}
//


