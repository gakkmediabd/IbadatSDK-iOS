//
//  NoInfoFoundCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/14/21.
//

import UIKit

class NoInfoFoundCell: UITableViewCell {
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier: String{
        return String(describing: self)
    }

    static var height : CGFloat{
        return 180
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
