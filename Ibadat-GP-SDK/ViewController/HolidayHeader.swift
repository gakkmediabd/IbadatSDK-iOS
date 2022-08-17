//
//  HolidayHeader.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit

class HolidayHeader: UICollectionReusableView {

    static let identifier : String = "HolidayHeader"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 8
        backgroundColor = .backgroundColor
        tittleLabel.textColor = .titleColot
        subtitleLabel.textColor = .subTitleColot
        
        tittleLabel.text = "ইসলামিক ছুটিরদিন"
        subtitleLabel.text = "*স্থান ভেদে চাঁদ দেখার উপর নির্ভর করে আরবি মাসের তারিখ পরিবর্তন হতে পারে"
    }
    
}
