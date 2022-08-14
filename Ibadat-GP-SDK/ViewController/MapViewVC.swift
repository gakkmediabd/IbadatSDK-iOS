//
//  MapViewVC.swift
//  Ibadat-GP-SDK
//
//  Created by Joy on 7/8/22.
//

import UIKit
import MapKit

class MapViewVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var mosqueList : [MosqueModel] = []
    
    //private var locationManager : LocationManagerService = LocationManagerService()
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.ibadat)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.centerCoordinate = AppData.shared.currentLocation.coordinate
        mapView.showsUserLocation = true
        
        var region = MKCoordinateRegion()
        region.center  = AppData.shared.currentLocation.coordinate
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.region = region
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = AppData.shared.currentLocation.coordinate
        mapView.addAnnotation(annotation)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        loadMap()
    }

}
extension MapViewVC{
    func loadMap(){
        mosqueList.forEach { mm in
            let annotation = MKPointAnnotation()
            annotation.title = mm.name
            annotation.subtitle = mm.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: mm.lat, longitude: mm.long)
            mapView.addAnnotation(annotation)
        }
    }
}
extension MapViewVC : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
      guard let newLocation = userLocation.location else { return }
      let region = MKCoordinateRegion(center: newLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
      mapView.setRegion(region, animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
            {
                return nil;
            }else{
                let pinIdent = "Pin";
                var pinView: MKAnnotationView?
                let detailButton: UIButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent)
                {
                    dequeuedView.annotation = annotation;
                    pinView = dequeuedView;
                }
                else
                {
                    pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdent)
                    let img = AppImage.mosque_marker.uiImage
                    pinView?.canShowCallout = true
                    if #available(iOS 11.0, *) {
                        pinView?.accessibilityContainerType = .landmark
                    } else {
                        // Fallback on earlier versions
                    }
                    pinView?.image =  img
                    pinView!.rightCalloutAccessoryView = detailButton

                }


                return pinView;
            }
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(#function)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
        guard let destination = view.annotation?.coordinate ,let url = URL(string: URLConstant.APPLE_DIRECTION_URL(mapView.userLocation.coordinate,destination)) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
//MARK: Location service
//extension MapViewVC{
//    func locationService(){
//        locationManager.locationRequestAlert  = { _ in
//            self.showAlert(title: ConstantData.ALERT, message: ConstantData.LOCATION_ALERT_MESSAGE, done: ConstantData.SETTINGS) {
//                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                                return
//                    }
//                    if UIApplication.shared.canOpenURL(settingsUrl) {
//                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                            //print("Settings opened: \(success)") // Prints true
//                        })
//                    }
//            }
//        }
//        locationManager.locationUpdate =  {location in
//
//            #if DEBUG
//            print(location)
//            #endif
//        }
//        locationManager.locationAuthorizeCheck()
//    }
//}
//

