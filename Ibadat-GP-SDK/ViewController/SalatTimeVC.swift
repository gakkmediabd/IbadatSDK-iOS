//
//  SalatTimeVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 2/8/22.
//

import UIKit

class SalatTimeVC: UIViewController {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var circularView: CircularProgressView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var salatLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    private var locationManager = LocationManagerService()
    private var currentLocation = AppData.shared.currentLocation{
        didSet{
            currentLocation.getAddress { address in
                self.placeLabel.text = address
            }
            self.setData()
        }
    }
    
    private var date = Date()
    private var salatTimeList : [SalatModel] = []
    
    private var clockTimer : Timer!
    private var nextSalatTimer : Timer!
    private var prayersTime : PrayerTimes?
    private var todayPrayerTime : PrayerTimes?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SalatCell.nib, forCellWithReuseIdentifier: SalatCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        circularView.clipsToBounds = true
        circularView.layer.shadowColor = UIColor.grayColor.cgColor
        circularView.layer.shadowOffset = CGSize(width: 0, height: 0)
        circularView.layer.shadowRadius = 1
        circularView.layer.shadowOpacity = 0.4
        circularView.layer.cornerRadius  = 100
        circularView.layer.masksToBounds = false
        
        //place setup
        self.placeLabel.adjustsFontSizeToFitWidth = true
        self.placeLabel.textColor = .tintColor
        currentLocation.getAddress { place in
            self.placeLabel.text = place
        }
        //date set
        self.setData()
        
        contentView.layer.cornerRadius = 172 / 2
        contentView.layer.borderWidth = 8
        contentView.layer.borderColor  = UIColor.appWhite.cgColor
        
        salatLabel.adjustsFontSizeToFitWidth = true
        timerLabel.adjustsFontSizeToFitWidth = true
        
        clockTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(currentTime), userInfo: nil, repeats: true)
        nextSalatTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(nextSalatRemaing), userInfo: nil, repeats: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clockTimer.fire()
        nextSalatTimer.fire()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clockTimer.invalidate()
        nextSalatTimer.invalidate()
    }
    
    @IBAction func onnPreviousDatePressed(_ sender: Any) {
        date = date.englishComponent(.day, value: -1)!
        setData()
    }
    @IBAction func onNextDayPressed(_ sender: Any) {
        date = date.englishComponent(.day, value: 1)!
        setData()
    }
    @IBAction func onSunriseAlarmPressed(_ sender: Any) {
        guard let prayersTime = prayersTime else {
            return
        }
        
        if Date() > prayersTime.sunrise{
            showAlert(message: "You cant set alarm on past")
            return
        }
        
        AlarmManager.shared.checkIsAlarmSet(identifier: prayersTime.sunrise.getString()) { isAdd in
            if isAdd{
                //remove from notification
                AlarmManager.shared.removeAlarm(identifier: prayersTime.sunrise.getString())
                self.sunriseLabel.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }else{
                //add notification
                AlarmManager.shared.addAlarm(title: "Ibadat", subtitle: Prayer.sunrise.rawValue, date: prayersTime.sunrise) { isAdd in
                    if isAdd{
                        self.sunriseLabel.setImage(AppImage.notificationOn.uiImage, for: .normal)
                    }
                    #if DEBUG
                    print("Sunrise alarm add : \(isAdd)")
                    #endif
                }
            }
        }
    }
    
    func checkSunrise(date : Date){
        AlarmManager.shared.checkIsAlarmSet(identifier: date.getString()) { isAdd in
            if isAdd{
                self.sunriseLabel.setImage(AppImage.notificationOn.uiImage, for: .normal)
            }else{
                self.sunriseLabel.setImage(AppImage.notificationOff.uiImage, for: .normal)
            }
        }
    }

    func setData(){
        if let prayers =  getPrayerTime(with: Coordinates(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude), date: date){
            if self.todayPrayerTime == nil{
                self.todayPrayerTime = prayers
            }
            self.prayersTime = prayers
            self.currentDateLabel.text = date.getDateToString()
            self.sunriseLabel.setTitle("\(ConstantData.SOKAL) \(prayers.sunrise.getTimeToString())", for: .normal)
            salatTimeList.removeAll()
            salatTimeList.append(.init(name: Prayer.fajr.rawValue, time: prayers.fajr, kal: ConstantData.VOR))
            salatTimeList.append(.init(name: Prayer.dhuhr.rawValue, time: prayers.dhuhr, kal: ConstantData.DUPUR))
            salatTimeList.append(.init(name: Prayer.asr.rawValue, time: prayers.asr, kal: ConstantData.BIKAL))
            salatTimeList.append(.init(name: Prayer.maghrib.rawValue, time: prayers.maghrib, kal: ConstantData.SONDHA))
            salatTimeList.append(.init(name: Prayer.isha.rawValue, time: prayers.isha, kal: ConstantData.RAT))
            collectionView.reloadData()
            checkSunrise(date: prayers.sunrise)
        }
    }
    
}
extension SalatTimeVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return salatTimeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: SalatCell.identifier, for: indexPath) as? SalatCell else{
            fatalError("Surah cell load failed")
        }
        cell.setSalat(salat: salatTimeList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height - 16
        return CGSize(width: height * 0.7, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let salat = salatTimeList[indexPath.row]
        if Date() > salat.time{
            showAlert(message: "You cant set alarm on past")
            return
        }
        AlarmManager.shared.checkIsAlarmSet(identifier: salat.time.getString()) { isAdd in
            if isAdd{
                AlarmManager.shared.removeAlarm(identifier: salat.time.getString())
                self.collectionView.reloadItems(at: [indexPath])
            }else{
                AlarmManager.shared.addAlarm(title: "Ibadat", subtitle: salat.name, date: salat.time) { isAdd in
                    #if DEBUG
                    print("\(salat.name) alarm set \(isAdd)")
                    #endif
                    self.collectionView.reloadItems(at: [indexPath])
                }
            }
        }
    }
}

//MARK: Location service
extension SalatTimeVC{
    func locationService(){
        locationManager.locationRequestAlert  = { _ in
            self.showAlert(title: ConstantData.ALERT, message: ConstantData.LOCATION_ALERT_MESSAGE, done: ConstantData.SETTINGS) {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            //print("Settings opened: \(success)") // Prints true
                        })
                    }
            }
        }
        locationManager.locationUpdate =  {location in
            self.currentLocation = location
            #if DEBUG
            print(location)
            #endif
        }
        locationManager.locationAuthorizeCheck()
    }
}

//timer
extension SalatTimeVC{
    @objc
    func currentTime(){
        let time = Date().getMediumTimeToString()
        self.currentTimeLabel.text = time
    }
    @objc
    func nextSalatRemaing(){
        guard let prayersTime = self.todayPrayerTime else {return}
        var nextSalat  :  Prayer = prayersTime.nextPrayer() == nil ? .fajr : prayersTime.nextPrayer()!
        let currentSalat : Prayer = prayersTime.currentPrayer()!
        if nextSalat == .sunrise{
            nextSalat = .dhuhr
        }else if nextSalat == .isha{
            nextSalat = .fajr
        }
        let currentPrayerTime = prayersTime.time(for: currentSalat)
        let nextTime = prayersTime.time(for: nextSalat)
        //total time
        let totalTime = nextTime.timeIntervalSince(currentPrayerTime)
        //remaining time
        let diff = nextTime.timeIntervalSince(Date())
        //all ready spend
        let d : CGFloat = totalTime - diff
        
        let progress = CGFloat(Int(d)) / CGFloat(Int(totalTime))
        self.circularView.progress = progress
        #if DEBUG
        print(Int(diff))
        print(Int(totalTime))
        print(Int(d))
        print(currentSalat.rawValue)
        print(currentPrayerTime.getMediumTimeToString())
        print(progress)
        #endif
        self.salatLabel.text = nextSalat.rawValue
        self.timerLabel.text = diff.stringFromTimeInterval().banglaNumber
    }
    
    func nextSalatCalculation(){
        
    }
}
