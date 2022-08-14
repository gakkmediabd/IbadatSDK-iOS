//
//  SectionHeaderCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/13/21.
//

import UIKit

protocol SectionHeaderSelectionDelegate {
    func didSelectSectionHeader(Selected: Bool, UserHeader: SectionHeaderCell)
}

class SectionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier : String{
        return String(describing: self)
    }

    static var height: CGFloat{
        return 48
    }
    
    var delegate : SectionHeaderSelectionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
//        self.infoBtn.setClickListener {
//            self.delegate?.didSelectSectionHeader(Selected: true, UserHeader: self)
//        }
        
    }
    
}
