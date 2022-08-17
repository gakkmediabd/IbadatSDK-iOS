//
//  ViewController.swift
//  Ibadat-GP
//
//  Created by Joy on 28/7/22.
//

import UIKit
import Ibadat_GP_SDK

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    
    private var dataSource : [String] = ["Surah","Dua","Hadith","Salat Learning","Wallpaper","Compass","Calendar","Salat Time","Ifter Sehri","Tasbih","Live Video","Nearist Mosque","Zakat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            
            if let error = error {
                // Handle the error here.
                print(error.localizedDescription)
            }
            
            // Enable or disable features based on the authorization.
        }
    }

}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            IbadatSdkCore.shared.openFeature(by: .SURAH, presentController: self)
        case 1:
            IbadatSdkCore.shared.openFeature(by: .DUA, presentController: self)
        case 2:
            IbadatSdkCore.shared.openFeature(by: .HADITH, presentController: self)
        case 3:
            IbadatSdkCore.shared.openFeature(by: .SALAT, presentController: self)
            
        case 4:
            IbadatSdkCore.shared.openFeature(by: .WALLPAPER, presentController: self)
        case 5:
            IbadatSdkCore.shared.openFeature(by: .COMPASS, presentController: self)
            
        case 6:
            IbadatSdkCore.shared.openFeature(by: .CALENDAR, presentController: self)
            
        case 7:
            IbadatSdkCore.shared.openFeature(by: .SALAT_TIME, presentController: self)
            
        case 8 :
            IbadatSdkCore.shared.openFeature(by: .IFTER_SEHRI, presentController: self)
            
        case 9:
            IbadatSdkCore.shared.openFeature(by: .TASBIH, presentController: self)
        case 10:
            IbadatSdkCore.shared.openFeature(by: .LIVE_VIDEO, presentController: self)
        case 11:
            IbadatSdkCore.shared.openFeature(by: .NEARIST_MOSQUE, presentController: self)
            
        case 12:
            IbadatSdkCore.shared.openFeature(by: .ZAKAT, presentController: self)
            
//        case 13:
//
//            AlarmManager.shared.addAlarm(title: "Ibadat", subtitle: "Check", date: Date()) { isAdd in
//                print("Alarm set : \(isAdd)")
//            }
        default:
            break
        }
    }
}

extension Date{
    func englishComponent(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
        
    func arabicComponent(_ unit: Calendar.Component, value: Int) -> Date?{
        let calendar = Calendar(identifier: .islamicUmmAlQura)
        return calendar.date(byAdding: unit, value: value, to: self)
    }
    func getTimeToString()-> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "bn")
        return formatter.string(from: self)
    }
    func getMediumTimeToString()-> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.locale = Locale(identifier: "bn")
        return formatter.string(from: self)
    }
    func getDateToString()-> String{
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMMM d"
        dateFormate.locale = Locale(identifier: "bn")
        return dateFormate.string(from: self)
    }
}
