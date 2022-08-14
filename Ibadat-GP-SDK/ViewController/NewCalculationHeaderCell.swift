//
//  NewCalculationHeaderCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/13/21.
//

import UIKit

class NewCalculationHeaderCell: UITableViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var totalAssetLbl: UILabel!
    @IBOutlet weak var zakatDueLbl: UILabel!
    @IBOutlet weak var headerInfoLbl: UILabel!
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier : String{
        return String(describing: self)
    }

    static var height: CGFloat{
        return 180
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        topView.backgroundColor  = .tintColor
    }
}
