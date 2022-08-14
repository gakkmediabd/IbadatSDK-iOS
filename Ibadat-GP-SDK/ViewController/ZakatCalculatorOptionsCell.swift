//
//  ZakatCalculatorOptionsCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/10/21.
//

import UIKit

class ZakatCalculatorOptionsCell: UITableViewCell {
    
    @IBOutlet weak var bbackgroundView: UIView!
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var optionDetailsLbl: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    
    static var nib : UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier : String{
        return String(describing: self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        bbackgroundView.layer.shadowColor = UIColor.grayColor.cgColor
        bbackgroundView.layer.shadowOffset = .zero
        bbackgroundView.layer.shadowRadius = 1
        bbackgroundView.layer.shadowOpacity = 0.4
        bbackgroundView.layer.cornerRadius  = 8
        bbackgroundView.layer.masksToBounds = false
        
    }
    
    
    func bindOptions(categoryData: ZakatModel){
        optionLbl.text = categoryData.title
        optionDetailsLbl.text = categoryData.text
    }
    
}
