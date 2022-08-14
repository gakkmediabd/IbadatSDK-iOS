//
//  MosqueCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit

class MosqueCell: UICollectionViewCell {
    static let identifier : String = "MosqueCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var subTitelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titelLabel.adjustsFontSizeToFitWidth = true
        titelLabel.textColor = .titleColot
        subTitelLabel.adjustsFontSizeToFitWidth  = true
        subTitelLabel.textColor = .subTitleColot
        backgroundColor = .appWhite
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.4
        layer.cornerRadius  = 8
        layer.masksToBounds = false
    }
    
    func setMosque(mosque : MosqueModel){
        self.titelLabel.text = mosque.name
        self.subTitelLabel.text = mosque.address
    }
}
