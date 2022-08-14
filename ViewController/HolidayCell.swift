//
//  HolidayCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit

class HolidayCell: UICollectionViewCell {
    static let identifier : String = "HolidayCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.textColor = .titleColot
        self.subtitleLabel.textColor = .subTitleColot
        backgroundColor = .appWhite
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 0.5
        layer.shadowOpacity = 0.1
        layer.cornerRadius  = 4
        layer.masksToBounds = false
    }
    
    func setHoliday(holiday : IslamicHolidayModel){
        self.titleLabel.text = holiday.title
        self.subtitleLabel.text = holiday.text
    }
}
