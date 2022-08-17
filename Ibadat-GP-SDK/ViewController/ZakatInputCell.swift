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
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        let btnDone = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        if #available(iOS 14.0, *) {
            let fixed = UIBarButtonItem(systemItem: .flexibleSpace)
            toolbar.setItems([fixed,btnDone], animated: true)
        } else {
            // Fallback on earlier versions
            toolbar.setItems([btnDone], animated: true)
        }
       
        inputTextField.inputAccessoryView = toolbar
    }
    @objc
    func donePressed(){
        inputTextField.resignFirstResponder()
    }
}
