//
//  AyatCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit

class AyatCell: UICollectionViewCell {
    static let identifier : String = "AyatCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.ibadat)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
