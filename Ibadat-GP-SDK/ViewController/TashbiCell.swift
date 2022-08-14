//
//  TashbiCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 4/8/22.
//

import UIKit

struct TashbiModel {
    var title : String
    var subTitle : String
    var type : TashbiType
}

class TashbiCell: UICollectionViewCell {

    static let identifier : String = "TashbiCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.cornerRadius  = 8
        layer.masksToBounds = false
        
        titleLabel.textColor = .titleColot
        subtitleLabel.textColor  = .subTitleColot
        
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.adjustsFontSizeToFitWidth =  true
        
        layer.borderColor =  UIColor.tintColor.cgColor
        layer.borderWidth = 0
        
        backgroundColor = .appWhite
    }

    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                layer.borderWidth = 2
                self.titleLabel.textColor = .tintColor
                self.subtitleLabel.textColor = .titleColot
            }else{
                layer.borderWidth = 0
                self.titleLabel.textColor = .titleColot
                self.subtitleLabel.textColor = .subTitleColot
            }
        }
    }
    
    func setDataWith(model obj : TashbiModel){
        self.titleLabel.text = obj.subTitle
        self.subtitleLabel.text = obj.title
    }
}
