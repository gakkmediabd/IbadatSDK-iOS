//
//  ZakatSavedCalculationCell.swift
//  Noor-Celcom
//
//  Created by Azad on 6/10/21.
//

import UIKit

class ZakatSavedCalculationCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var netAssetLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var zakatPayLbl: UILabel!
    
    static var nib: UINib{
        return UINib(nibName: identifier, bundle: Bundle.bundle)
    }
    
    static var identifier : String{
        return String(describing: self)
    }

    static var height: CGFloat{
        return 102
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
//    func bindZakat(item: Zakat){
//        let trimmedDateStr = item.createdOn.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
//        dateLbl.text = trimmedDateStr.UTCToLocal(incomingFormat: "yyyy-MM-ddTHH:mm:ss", outGoingFormat: "MMM d, h:mm a.")
//        
//        netAssetLbl.text = "txt_total_asset".localized() + " : " + "txt_taka".localized() + " " + item.netAsset.toDoubleDecimalString()
//        zakatPayLbl.text = "txt_jakat_baki".localized() + " : " + "txt_taka".localized() + " "  + item.zakat.toDoubleDecimalString()
//    }
    
    
}

extension String {
    
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat

        return dateFormatter.string(from: dt ?? Date())
      }

}
