//
//  AlarmManager.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 10/8/22.
//

import UIKit
import Foundation

public class AlarmManager: NSObject {
    public static let shared = AlarmManager()
    private override init() {

        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    private var center = UNUserNotificationCenter.current()
    ///title is app name
    ///subtitle is azan name
    public func addAlarm(title : String,subtitle : String,date : Date,complete : @escaping(_ isAdd : Bool)->Void){
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        
        let sound = UNNotificationSound(named: UNNotificationSoundName("azan.mp3"))
        content.sound = sound
        
        let dateComponant = Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute],
            from: date)
        #if DEBUG
        print(dateComponant.day,dateComponant.month,dateComponant.year,dateComponant.hour,dateComponant.minute)
        #endif
        let tiger = UNCalendarNotificationTrigger(dateMatching: dateComponant, repeats: false)
        //let testTiger =  UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        let request = UNNotificationRequest(identifier: date.getString(), content: content, trigger: tiger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            DispatchQueue.main.async {
                if error == nil{
                    complete(true)
                }else{
                    complete(false)
                }
            }
        }
        
    }
    func checkIsAlarmSet(identifier : String,complete : @escaping (_ isAdd : Bool)->Void){
        center.getPendingNotificationRequests { rerquests in
            var isFind = false
            for rerquest in rerquests {
                if rerquest.identifier == identifier{
                    isFind = true
                    break
                }
            }
            DispatchQueue.main.async {
                complete(isFind)
            }
            
        }
    }
    func removeAlarm(identifier : String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
