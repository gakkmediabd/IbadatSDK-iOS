//
//  IfterCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 3/8/22.
//

import UIKit

struct IfterTimeModel{
    var date : String
    var ifterTime: String
    var sehriTime : String
}

class IfterCell: UITableViewCell {
    static let identifier : String = "IfterCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.bundle)
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sehriLastTimeLabel: UILabel!
    @IBOutlet weak var ifterTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIfterTime(obj : IfterTimeModel){
        self.dateLabel.text = obj.date
        self.ifterTimeLabel.text = obj.ifterTime
        self.sehriLastTimeLabel.text = obj.sehriTime
    }
}
