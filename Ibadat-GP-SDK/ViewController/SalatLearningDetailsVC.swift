//
//  SalatLearningDetailsVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit

class SalatLearningDetailsVC: UIViewController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    var salat : SalatLearningModel?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = .appWhite
        contentView.clipsToBounds = true
        contentView.layer.shadowColor = UIColor.grayColor.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.cornerRadius  = 8
        contentView.layer.masksToBounds = false
        
        titleLabel.textColor = .titleColot
        detailsTextView.textColor = .subTitleColot
        detailsTextView.backgroundColor = .appWhite
        guard let salat = salat else {
            return
        }
        
        titleLabel.text = salat.topicName
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIService.instant.getSalatDetails(id: salat!.id!) { result in
            switch result{
            case .success(let salat):
                self.salat = salat
                if var details = salat.topicDescription{
                    details = details.replacingOccurrences(of: "<br>", with: "\n")
                    self.detailsTextView.text = details
                }
            case .failure(let error):
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    @IBAction func onBackPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
