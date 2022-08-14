//
//  CompassVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 1/8/22.
//

import UIKit
import CoreLocation

class CompassVC: UIViewController ,CLLocationManagerDelegate{
    @IBOutlet weak var mokkaLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var campassImageView: UIImageView!
    
    var latestLocation: CLLocation? = nil
    var yourLocationBearing: CGFloat { return latestLocation?.bearingToLocationRadian(self.yourLocation) ?? 0 }
    var yourLocation: CLLocation {
        get { return AppData.shared.currentLocation }
      set { AppData.shared.currentLocation = newValue }
    }
    
    let locationManager: CLLocationManager = {
      $0.requestWhenInUseAuthorization()
      $0.desiredAccuracy = kCLLocationAccuracyBest
      $0.startUpdatingLocation()
      $0.startUpdatingHeading()
      return $0
    }(CLLocationManager())
    
    private func orientationAdjustment() -> CGFloat {
      let isFaceDown: Bool = {
        switch UIDevice.current.orientation {
        case .faceDown: return true
        default: return false
        }
      }()
      
      let adjAngle: CGFloat = {
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft:  return 90
        case .landscapeRight: return -90
        case .portrait, .unknown: return 0
        case .portraitUpsideDown: return isFaceDown ? 180 : -180
        @unknown default:
            fatalError()
        }
      }()
      return adjAngle
    }
    
    var currrentLocation = CLLocation(latitude: 23.752536308706137, longitude: 90.38093516615558)
    let kaaba = CLLocation(latitude: 21.4225, longitude: 39.8262)
    var previousAngle = CGFloat.zero
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.bundle)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate  = self
        let bearing = self.currrentLocation.bearingToLocationRadian(kaaba)
        //bearing = bearing - 22
        UIView.animate(withDuration: 0.2) {
            self.campassImageView.transform = CGAffineTransform(rotationAngle: -bearing)
        }
        distanceCalculation()
    }


    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let newHeading = newHeading.trueHeading
        func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
          let heading: CGFloat = {
            let originalHeading = self.yourLocationBearing - newAngle.degreesToRadians
            switch UIDevice.current.orientation {
            case .faceDown: return -originalHeading
            default: return originalHeading
            }
          }()
          
          return CGFloat(self.orientationAdjustment().degreesToRadians + heading)
        }
        
        UIView.animate(withDuration: 0.2) {
          let angle = computeNewAngle(with: CGFloat(newHeading))
          self.contentView.transform = CGAffineTransform(rotationAngle: angle)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
                AppData.shared.currentLocation = location
                self.currrentLocation = location
                let bearing = location.bearingToLocationRadian(kaaba)
                //bearing = bearing - 22
                UIView.animate(withDuration: 0.2) {
                    self.campassImageView.transform = CGAffineTransform(rotationAngle: -bearing)
                }
                distanceCalculation()
            }
            manager.stopUpdatingLocation()
        
    }
    
    func distanceCalculation(){
        let distance = currrentLocation.distance(from: kaaba) / 1000
        self.mokkaLabel.text = "মক্কা থেকে দূরত্ব \(String(format: "%.01f", distance)) KM"
    }
}


