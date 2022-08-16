//
//  DuaHadithDetailsVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 31/7/22.
//

import UIKit

class DuaHadithDetailsVC: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var duaList : [DuaModel]?
    var hadithList : [HadithModel]?
    var index : Int = 0
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.countLabel.textColor  = .tintColor
        
        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor.grayColor.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.cornerRadius  = 8
        contentView.layer.masksToBounds = false
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        contentView.isLayoutMarginsRelativeArrangement = true
        
        if let duaList = duaList {
            setDataWith(dua: duaList[index])
        }else if let hadithList = hadithList {
            setDataWith(hadith: hadithList[index])
        }
        
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func onNextPressed(_ sender: Any) {
        index += 1
        if let duaList = duaList {
            if index == duaList.count{
                self.index = 0
            }
            self.setDataWith(dua: duaList[index])
        }else if let hadithList = hadithList {
            if index == hadithList.count{
                self.index = 0
            }
            self.setDataWith(hadith: hadithList[index])
        }
    }
    @IBAction func onPreviousPressed(_ sender: Any) {
        index -= 1
        if let duaList = duaList {
            if index < 0{
                self.index = duaList.count - 1
            }
            self.setDataWith(dua: duaList[index])
        }else if let hadithList = hadithList {
            if index < 0 {
                self.index = hadithList.count - 1
            }
            self.setDataWith(hadith: hadithList[index])
        }
    }
    

    private func setDataWith(dua : DuaModel){
        self.subtitleLabel.textAlignment = .right
        self.countLabel.text = "\(index + 1)"
        self.titleLabel.text  =  dua.title
        self.subtitleLabel.text = dua.dua
        let details = "\(dua.pronounciation)<br><br>\(dua.meaning)<br><br>\(dua.fazilat)"
        let txt = details.replacingOccurrences(of: "<br>", with: "\n").replacingOccurrences(of: "\r", with: "")
        self.detailsLabel.text  = txt
        
        let allTxt = "\(dua.title) \n\n \(dua.dua) \n \n  \(details)"

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.detailsLabel.bounds.width, height: CGFloat(MAXFLOAT)))
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.text = allTxt
        label.sizeToFit()
        
        if scrollView.bounds.height < label.bounds.height {
            let h = label.bounds.height  - scrollView.bounds.height
            self.heightConstraint.constant = h
        }else{
            self.heightConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    private  func setDataWith(hadith : HadithModel){
        self.subtitleLabel.textAlignment = .left
        self.countLabel.text = "\(index + 1)"
        self.titleLabel.text = hadith.title
        self.subtitleLabel.text = hadith.source
        let details = "\(hadith.narrator)<br>\(hadith.hadithModelDescription)"
        let txt = details.replacingOccurrences(of: "<br>", with: "\n")
        self.detailsLabel.text  = txt
        
        let allTxt = "\(hadith.title) \n \(hadith.source) \n \(details)"

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.detailsLabel.bounds.width, height: CGFloat(MAXFLOAT)))
        label.text = allTxt
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.sizeToFit()
        
        if scrollView.bounds.height < label.bounds.height {
            let h = label.bounds.height - scrollView.bounds.height
            self.heightConstraint.constant = h
        }else{
            self.heightConstraint.constant =  0
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
