//
//  TashbiContCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 4/8/22.
//

import UIKit

class TashbiContCell: UICollectionViewCell {
    static let identifier : String = "TashbiContCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.textColor = .titleColot
        subtitleLabel.textColor = .subTitleColot
        
        backgroundColor = .backgroundColor
        
        layer.cornerRadius = 4
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
    }

    func setTashbiCount(obj : TashbiModel){
        self.titleLabel.text = obj.title
        self.subtitleLabel.text = obj.subTitle
    }
}
