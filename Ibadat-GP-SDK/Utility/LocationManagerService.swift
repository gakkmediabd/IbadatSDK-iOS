//
//  LocationDelegate.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 3/8/22.
//

import Foundation
import CoreLocation

class LocationManagerService : NSObject, CLLocationManagerDelegate{
   
    override init() {
        super.init()
        locationManager.delegate = self
    }
    private let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
      $0.desiredAccuracy = kCLLocationAccuracyBest
      $0.startUpdatingLocation()
      $0.startUpdatingHeading()
      return $0
    }(CLLocationManager())
    
    var locationUpdate : (_ location :  CLLocation)-> Void = {_ in}
    var locationHeadingChange : (_ heading : CLHeading)-> Void = {_ in}
    var locationRequestAlert : (Bool)->Void = {_ in}
    func locationAuthorizeCheck(){
        if CLLocationManager.locationServicesEnabled(){
            
            if #available(iOS 14.0, *) {
                if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus  == .authorizedAlways{
                    //do nothing
                    
                }else if locationManager.authorizationStatus == .denied{
                    #if DEBUG
                    print("location deny")
                    #endif
                    self.locationRequestAlert(true)
                }
                
            }else{
                switch CLLocationManager.authorizationStatus(){
                case .authorizedAlways,.authorizedWhenInUse:
                    //do nothing
                    break
                case .denied:
                    #if DEBUG
                    print("location deny")
                    #endif
                    self.locationRequestAlert(true)
                    break
                default:
                    //request for location
                    locationManager.requestWhenInUseAuthorization()
                    break
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            #if targetEnvironment(simulator)
            locationUpdate(AppData.shared.currentLocation)
            #else
            AppData.shared.currentLocation = location
            locationUpdate(location)
            #endif
        }
        manager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        locationHeadingChange(newHeading)
    }
    func stopLocationUpdate(){
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            if manager.authorizationStatus == .denied{
                self.locationRequestAlert(true)
            }
        } else {
            // Fallback on earlier versions
            if CLLocationManager.authorizationStatus() == .denied{
                self.locationRequestAlert(true)
            }
        }
    }
}
