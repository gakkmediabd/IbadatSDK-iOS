//
//  SurahCell.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import UIKit

internal class ListCell: UICollectionViewCell {
    
    static let identifier : String = "ListCell"
    static let nib = UINib(nibName: identifier, bundle: Bundle.ibadat)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.textColor = .titleColot
        subtitleLabel.textColor = .subTitleColot
        countLabel.textColor = .tintColor
        
        clipsToBounds = true
        layer.shadowColor = UIColor.grayColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.4
        layer.cornerRadius  = 8
        layer.masksToBounds = false
    }

    func surahSetup(indx : Int, surah : SurahModel){
        self.countLabel.text = "\(indx)"
        self.titleLabel.text = surah.surhaName
        self.subtitleLabel.text = surah.ayetCount
    }
    func duaSetup(indx : Int, obj : DuaModel){
        self.subtitleLabel.isHidden = true
        self.countLabel.text = "\(indx)"
        self.titleLabel.text = obj.title
    }
    func hadithSetup(indx : Int , obj : HadithModel){
        self.countLabel.text = "\(indx)"
        self.titleLabel.text = obj.title
        self.subtitleLabel.text = obj.source
    }
    func salatLearningSetup(indx : Int,salat : SalatLearningModel){
        self.countLabel.text = "\(indx + 1)"
        self.titleLabel.text = salat.topicName
        self.subtitleLabel.isHidden = true
    }
}
