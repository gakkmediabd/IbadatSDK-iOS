//
//  ifterSehriVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit
import CoreLocation

class ifterSehriVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var staticStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPlace: UIButton!
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var btnSheriAlert: UIButton!
    @IBOutlet weak var btnIfterAlert: UIButton!
    @IBOutlet weak var ifterTimeLabel: UILabel!
    @IBOutlet weak var sheriTimeLabel: UILabel!
    @IBOutlet weak var rojaVongerKaronLabel: UILabel!
    @IBOutlet weak var rojaHaramDetailsLabel: UILabel!
    @IBOutlet weak var rojaKajaDetails: UILabel!
    @IBOutlet weak var btnRojarNiyomHeader: UIButton!
    @IBOutlet weak var btnDuaHeader: UIButton!
    @IBOutlet weak var btnSeheriIferTimeHeader: UIButton!
    
    private var currentLocation : CLLocationCoordinate2D = ConstantData.DHAKA_LOCATION{
        didSet{
            getsheriAndIfterTime()
            self.ifterTimes = self.get10DaysIfterAndSeheri()
            self.tableView.reloadData()
        }
    }
    private var ifterTimes : [IfterTimeModel] = []
    private var prayerTime : PrayerTimes?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rojaVongerKaronLabel.attributedText = NSAttributedString(string: ConstantData.ROJA_VONGER_KARON_DETAILS)
        self.rojaHaramDetailsLabel.attributedText  = NSAttributedString(string: ConstantData.ROJA_HARAM_DETAILS)
        self.rojaKajaDetails.attributedText = NSAttributedString(string: ConstantData.ROJA_KAJA_DETAILS)
        
        if #available(iOS 11.0, *) {
            btnSeheriIferTimeHeader.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            btnRojarNiyomHeader.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            btnDuaHeader.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        btnSeheriIferTimeHeader.layer.cornerRadius = 8
        btnRojarNiyomHeader.layer.cornerRadius = 8
        btnDuaHeader.layer.cornerRadius = 8
        topView.layer.cornerRadius = 8
        btnPlace.layer.cornerRadius = 8
        
        ifterTimes = get10DaysIfterAndSeheri()
        tableView.register(IfterCell.nib, forCellReuseIdentifier: IfterCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .appWhite
        //header date
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "EEEE, d MMMM YYYY"
        dateFormate.locale = Locale(identifier: "bn")
        
        self.todayDateLabel.text = dateFormate.string(from: Date())
        self.todayDateLabel.textColor = .appWhite
        
        self.btnPlace.setTitle(ConstantData.DHAKA, for: .normal)
        btnBack.setImage(AppImage.back.uiImage, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getsheriAndIfterTime()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let constant = (staticStackView.bounds.height + 200 + 200 ) - UIScreen.main.bounds.height
        self.heightConstraint.constant = constant
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func onPlacePressed(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let dhaka = UIAlertAction(title: ConstantData.DHAKA, style: .default) { action in
            self.currentLocation = ConstantData.DHAKA_LOCATION
            self.btnPlace.setTitle(ConstantData.DHAKA, for: .normal)
        }
        let rajshahi = UIAlertAction(title: ConstantData.RAJSHAHI, style: .default) { action in
            self.currentLocation = ConstantData.RAJSHAHI_LOCATION
            self.btnPlace.setTitle(ConstantData.RAJSHAHI, for: .normal)
        }
        let rangpur = UIAlertAction(title: ConstantData.RANGPUR, style: .default) { action in
            self.currentLocation = ConstantData.RANGPUR_LOCATION
            self.btnPlace.setTitle(ConstantData.RANGPUR, for: .normal)
        }
        let khulna = UIAlertAction(title: ConstantData.KHULNA, style: .default) { action in
            self.currentLocation = ConstantData.KHULNA_LOCATION
            self.btnPlace.setTitle(ConstantData.KHULNA, for: .normal)
        }
        let barishal = UIAlertAction(title: ConstantData.BARISHAL, style: .default) { action in
            self.currentLocation = ConstantData.BARISHAL_LOCATION
            self.btnPlace.setTitle(ConstantData.BARISHAL, for: .normal)
        }
        let ctg = UIAlertAction(title: ConstantData.CHOTTROGRAM, style: .default) { action in
            self.currentLocation = ConstantData.CHOTTROGRAM_LOCATION
            self.btnPlace.setTitle(ConstantData.CHOTTROGRAM, for: .normal)
        }
        let sylhet = UIAlertAction(title: ConstantData.SYLHET, style: .default) { action in
            self.currentLocation = ConstantData.SYLHET_LOCATION
            self.btnPlace.setTitle(ConstantData.SYLHET, for: .normal)
        }
        let maymangshing = UIAlertAction(title: ConstantData.MAYMANGSHING, style: .default) { action in
            self.currentLocation = ConstantData.MAYMANGSHING_LOCATION
            self.btnPlace.setTitle(ConstantData.MAYMANGSHING, for: .normal)
        }
        let cancel = UIAlertAction(title: ConstantData.CANCEL, style: .destructive)
        
        alert.addAction(dhaka)
        alert.addAction(rajshahi)
        alert.addAction(rangpur)
        alert.addAction(khulna)
        alert.addAction(barishal)
        alert.addAction(ctg)
        alert.addAction(sylhet)
        alert.addAction(maymangshing)
        alert.addAction(cancel)
        
        self.present(alert, animated: true) {
            
        }
        
    }
    @IBAction func onSehriAlertPressed(_ sender: Any) {
        guard let prayerTime = prayerTime else {
            return
        }
        if Date() > prayerTime.fajr{
            showAlert(message: ConstantData.ALARM_WARNING)
            return
        }
        AlarmManager.shared.checkIsAlarmSet(identifier: prayerTime.fajr.getString()) { isAdd in
            if isAdd{
                AlarmManager.shared.removeAlarm(identifier: prayerTime.fajr.getString())
                self.btnSheriAlert.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }else{
                AlarmManager.shared.addAlarm(title: "Ibadat", subtitle: ConstantData.IFTER, date: prayerTime.maghrib) { isAdd in
                    if isAdd{
                        self.btnSheriAlert.setImage(AppImage.notificationOn.uiImage, for: .normal)
                    }
                }
                
            }
        }
    }
    @IBAction func onIfterAlertPressed(_ sender: Any) {
        guard let prayerTime = prayerTime else {
            return
        }
        if Date() > prayerTime.maghrib{
            showAlert(message: ConstantData.ALARM_WARNING)
            return
        }
        AlarmManager.shared.checkIsAlarmSet(identifier: prayerTime.maghrib.getString()) { isAdd in
            if isAdd{
                AlarmManager.shared.removeAlarm(identifier: prayerTime.maghrib.getString())
                self.btnIfterAlert.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }else{
                AlarmManager.shared.addAlarm(title: "Ibadat", subtitle: ConstantData.IFTER, date: prayerTime.maghrib) { isAdd in
                    if isAdd{
                        self.btnIfterAlert.setImage(AppImage.notificationOn.uiImage, for: .normal)
                    }
                }
                
            }
        }
    }
    
}

//MARK: Tableview data source
extension ifterSehriVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ifterTimes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IfterCell.identifier, for: indexPath) as? IfterCell else{
            fatalError()
        }
        cell.setIfterTime(obj: ifterTimes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row  == 0{
            return 50
        }
        return 30
    }
}

//MARK: Adhan data process
extension ifterSehriVC{
    func getsheriAndIfterTime(){
        let cordinate = Coordinates(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
        guard let prayers = getPrayerTime(with: cordinate, date: Date()) else {return}
        self.prayerTime = prayers
        self.sheriTimeLabel.text = prayers.fajr.getTimeToString()
        self.ifterTimeLabel.text = prayers.maghrib.getTimeToString()
        
        AlarmManager.shared.checkIsAlarmSet(identifier: prayers.fajr.getString()) { isAdd in
            if isAdd{
                self.btnSheriAlert.setImage(AppImage.notificationOn.uiImage, for: .normal)
            }else{
                self.btnSheriAlert.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }
        }
        AlarmManager.shared.checkIsAlarmSet(identifier: prayers.maghrib.getString()) { isAdd in
            if isAdd{
                self.btnIfterAlert.setImage(AppImage.notificationOn.uiImage, for: .normal)
            }else{
                self.btnIfterAlert.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }
        }
        
        #if DEBUG
        print("fajr \(prayers.fajr.getTimeToString())")
        print("sunrise \(prayers.sunrise.getTimeToString())")
        print("dhuhr \(prayers.dhuhr.getTimeToString())")
        print("asr \(prayers.asr.getTimeToString())")
        print("maghrib \(prayers.maghrib.getTimeToString())")
        print("isha \(prayers.isha.getTimeToString())")
        #endif
    }
    func get10DaysIfterAndSeheri()->[IfterTimeModel]{
        var arr : [IfterTimeModel] = []
        arr.append(.init(date: ConstantData.DATE, ifterTime: ConstantData.IFTER, sehriTime: ConstantData.SEHRI_LAST_TIME))
        
        var dates : [Date] = []
        for i in 0..<10{
            dates.append(Date().englishComponent(.day, value: i)!)
        }
        dates.forEach { next in
            let cordinate = Coordinates(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
            
            if let prayers = getPrayerTime(with: cordinate, date: next) {
                
                let date = next.getDateToString()
                let sehri = prayers.fajr.getTimeToString()
                let ifter = prayers.maghrib.getTimeToString()
                arr.append(.init(date: date, ifterTime: ifter, sehriTime: sehri))
            }
        }
        return arr
    }
}

