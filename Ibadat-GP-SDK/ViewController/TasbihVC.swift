//
//  TasbihVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit
import AVFoundation

class TasbihVC: UIViewController {
    
    private var systemSoundID: SystemSoundID = 1121 // 1122
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var allCountLabel: UILabel!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var tasbiCountCollectionView: UICollectionView!
    @IBOutlet weak var tasbiCollectionView: UICollectionView!
    @IBOutlet weak var countSetView: UIView!
    @IBOutlet weak var countContentView: UIView!
    @IBOutlet weak var countView: CircularProgressView!
    @IBOutlet weak var btn33: UIButton!
    @IBOutlet weak var btn34: UIButton!
    @IBOutlet weak var btn99: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var countShowLabel: UILabel!
    @IBOutlet weak var maxCountLabel: UILabel!
    
    
    
    private var tashbiList = ConstantData.getTasbi()
    private var tasbiCountList = ConstantData.getTasbiCount()
    
    private var count : Int = 0{
        didSet{
            progressCount()
        }
    }
    private var countMax : Int =  33{
        didSet{
            progressCount()
        }
    }
    private var tasbiModel : TashbiModel!
    
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.ibadat)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor

        topView.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            topView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
        countSetView.layer.cornerRadius =  8
        
        countButton.layer.shadowColor = UIColor.grayColor.cgColor
        countButton.layer.shadowOffset = .zero
        countButton.layer.shadowRadius = 2
        countButton.layer.shadowOpacity = 0.5
        countButton.layer.masksToBounds = false
    
        countContentView.layer.cornerRadius = 172 / 2
        countContentView.layer.borderWidth = 8
        countContentView.layer.borderColor  = UIColor.appWhite.cgColor
        
        bottomView.backgroundColor = .appWhite
        bottomView.centerRounded(centerRadius: 30,cornerRadius: 16,cornerMask: [.layerMinXMinYCorner,.layerMaxXMinYCorner],_bounds: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        //countView.progress = 0.9
        
        tasbiCollectionView.register(TashbiCell.nib, forCellWithReuseIdentifier: TashbiCell.identifier)
        tasbiCollectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        tasbiCollectionView.dataSource = self
        tasbiCollectionView.delegate = self
        
        tasbiCountCollectionView.register(TashbiContCell.nib, forCellWithReuseIdentifier: TashbiContCell.identifier)
        tasbiCountCollectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        tasbiCountCollectionView.dataSource = self
        tasbiCountCollectionView.delegate = self
        
        allCountLabel.text = "\(AppData.shared.ALL_COUNT)"
        
        let select = UIImage(named: "circel_fill", in: .ibadat, compatibleWith: nil)
        let unSelect = UIImage(named: "circel", in: .ibadat, compatibleWith: nil)
        btn33.setImage(unSelect, for: .normal)
        btn33.setImage(select, for: .selected)
        btn33.setTitleColor(.subTitleColot, for: .normal)
        btn33.setTitleColor(.tintColor, for: .selected)
        
        btn34.setImage(unSelect, for: .normal)
        btn34.setImage(select, for: .selected)
        btn34.setTitleColor(.subTitleColot, for: .normal)
        btn34.setTitleColor(.tintColor, for: .selected)
        
        btn99.setImage(unSelect, for: .normal)
        btn99.setImage(select, for: .selected)
        btn99.setTitleColor(.subTitleColot, for: .normal)
        btn99.setTitleColor(.tintColor, for: .selected)
        
        btn33.isSelected = true
        
        gradiantAdd()
        tasbiCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        tasbiModel = tasbiCountList[0]
        
        let bangla = "\(countMax)".banglaNumber
        maxCountLabel.text = " \(bangla) বার"
        countShowLabel.text = "0".banglaNumber
        
        count = 0
        
        btnSound.setImage(AppData.shared.isTasbiSoundEnable ? AppImage.sound.uiImage : AppImage.noSound.uiImage, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let height : CGFloat = 40.0 + 220.0  + 50.0 + 70.0 + 20.0 + tasbiCountCollectionView.contentSize.height  + 50.0
        let constant = height - UIScreen.main.bounds.width
        self.heightConstant.constant  =  constant
           
    }
    @IBAction func onSoundControllPressed(_ sender: Any) {
        AppData.shared.isTasbiSoundEnable  = !AppData.shared.isTasbiSoundEnable
        btnSound.setImage(AppData.shared.isTasbiSoundEnable ? AppImage.sound.uiImage : AppImage.noSound.uiImage, for: .normal)
    }
    @IBAction func onResetPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: ConstantData.RESET_TASHBI_TITLE, message: ConstantData.RESET_TASHBI_SUBTITLE, preferredStyle: .actionSheet)
        let resetCount = UIAlertAction(title: ConstantData.RESET_OPTION_1, style: .default) { action in
            self.count = 0
            self.countShowLabel.text = "0".banglaNumber
        }
        let resetAll = UIAlertAction(title: ConstantData.RESET_OPTION_2, style: .default) { action in
            AppData.shared.resetTashbi()
            
            self.allCountLabel.text = "\(AppData.shared.ALL_COUNT)"
            self.count = 0
            self.countShowLabel.text = "0".banglaNumber
            self.tasbiCountList = ConstantData.getTasbiCount()
            self.tasbiCountCollectionView.reloadData()
        }
        let cancel = UIAlertAction(title: ConstantData.CANCEL, style: .destructive)
        
        alert.addAction(resetCount)
        alert.addAction(resetAll)
        alert.addAction(cancel)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    @IBAction func onCountPressed(_ sender: Any) {
        // to play sound
        if AppData.shared.isTasbiSoundEnable{
            AudioServicesPlaySystemSound(systemSoundID)
        }
        if count == countMax{
            count = 0
        }
        count += 1
        AppData.shared.increseTasbi(type: tasbiModel.type)
        
        let bangla = "\(count)".banglaNumber
        self.countShowLabel.text = bangla
        
        let all = "\(AppData.shared.ALL_COUNT)"
        
        self.allCountLabel.text = "\(all.banglaNumber)"
        //reload count collection for update value instant
        let indx = tasbiCountList.firstIndex(where: {$0.type == tasbiModel.type}) ?? 0
        tasbiCountList[indx].subTitle = "\(AppData.shared.getTasbiCount(type : tasbiModel.type)) বার"
        tasbiCountCollectionView.reloadItems(at: [IndexPath(row: indx, section: 0)])
        
        
        
    }
    @IBAction func on33Pressed(_ sender: Any) {
        btn33.isSelected = true
        btn34.isSelected = false
        btn99.isSelected = false
        countMax  = 33
        count = 0
        let bangla = "\(countMax)".banglaNumber
        maxCountLabel.text = " \(bangla) বার"
        let cc = "0".banglaNumber
        self.countShowLabel.text = "\(cc)"
        
    }
    @IBAction func on34Pressed(_ sender: Any) {
        btn33.isSelected = false
        btn34.isSelected = true
        btn99.isSelected = false
        countMax  = 34
        count = 0
        let bangla = "\(countMax)".banglaNumber
        maxCountLabel.text = " \(bangla) বার"
        let cc = "0".banglaNumber
        self.countShowLabel.text = "\(cc)"
    }
    @IBAction func on99Pressed(_ sender: Any) {
        btn33.isSelected = false
        btn34.isSelected = false
        btn99.isSelected = true
        countMax = 99
        count = 0
        let bangla = "\(countMax)".banglaNumber
        maxCountLabel.text = " \(bangla) বার"
        let cc = "0".banglaNumber
        self.countShowLabel.text = "\(cc)"
        
    }
    
    
}
extension TasbihVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tasbiCountCollectionView{
            return  tasbiCountList.count
        }
        return tashbiList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tasbiCollectionView{
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: TashbiCell.identifier, for: indexPath) as? TashbiCell else{
                fatalError("Surah cell load failed")
            }
            cell.setDataWith(model: tashbiList[indexPath.row])
            return  cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TashbiContCell.identifier, for: indexPath)  as? TashbiContCell else{
            fatalError()
        }
        cell.setTashbiCount(obj: tasbiCountList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tasbiCollectionView{
            let width = (UIScreen.main.bounds.width - 32) / 2
            return CGSize(width: width, height: collectionView.bounds.height - 16)
        }
        let width  = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 44)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tasbiCountCollectionView {
            return
        }
        tasbiModel = tasbiCountList[indexPath.row]
        countShowLabel.text = "০০"
        count  = 0
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
}

extension TasbihVC{
    func progressCount(){
        let pro  = Float(count) / Float(countMax)
        countView.progress = CGFloat(pro)
    }
    func gradiantAdd(){
        let layer0 = CAGradientLayer()

        layer0.colors = [

          UIColor(red: 0, green: 0.471, blue: 0.812, alpha: 1).cgColor,

          UIColor(red: 0.071, green: 0.604, blue: 0.91, alpha: 1).cgColor

        ]

        layer0.locations = [0, 1]

        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)

        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)

        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))

        layer0.bounds = CGRect(x: 0, y: 0, width: 172, height: 172)

        layer0.position = CGPoint(x: countContentView.bounds.midX, y: countContentView.bounds.midY)
        layer0.cornerRadius = 172 / 2
        self.countContentView.clipsToBounds = true

        self.countContentView.layer.insertSublayer(layer0, at: 0)
    }
}
