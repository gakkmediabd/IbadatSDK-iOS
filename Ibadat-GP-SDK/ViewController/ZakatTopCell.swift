//
//  ZakatTopCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 10/8/22.
//

import UIKit

class ZakatTopCell: UITableViewCell {

    @IBOutlet weak var bbackgroundView: UIView!
    @IBOutlet weak var discriptionCell: UILabel!
    
    //MARK: create nib for access this view
    static var identifier : String{
        return String(describing: self)
    }
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bbackgroundView.layer.shadowColor = UIColor.grayColor.cgColor
        bbackgroundView.layer.shadowOffset = .zero
        bbackgroundView.layer.shadowRadius = 1
        bbackgroundView.layer.shadowOpacity = 0.4
        bbackgroundView.layer.cornerRadius  = 8
        bbackgroundView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
