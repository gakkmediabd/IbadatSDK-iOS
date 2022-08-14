//
//  SalatCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit

struct SalatModel{
    var name : String
    var time : Date
    var kal : String
}

class SalatCell: UICollectionViewCell {
    static let identifier : String = "SalatCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.ibadat)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notificationIV: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .appWhite
        titleLabel.textColor = .titleColot
        subtitleLabel.textColor = .subTitleColot
        titleLabel.adjustsFontSizeToFitWidth = true
        backgroundColor = .appWhite
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.4
        layer.cornerRadius  = 4
        layer.masksToBounds = false
    }

    func setSalat(salat : SalatModel){
        self.titleLabel.text = salat.name
        self.subtitleLabel.text  = "\(salat.kal)\n\(salat.time.getTimeToString())"
        AlarmManager.shared.checkIsAlarmSet(identifier: salat.time.getString()) { isAdd in
            if isAdd{
                self.notificationIV.image = AppImage.notificationOn.uiImage
            }else{
                self.notificationIV.image = AppImage.notificationOff.uiImage
            }
        }
    }
}
