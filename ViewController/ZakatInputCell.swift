//
//  ZakatInputCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/13/21.
//

import UIKit

class ZakatInputCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier: String {
        return String(describing: self)
    }

    static var height: CGFloat {
        return 48
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
