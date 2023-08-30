//
//  MapViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 21.08.2023.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation
import Layoutless

class MapViewController: UIViewController {
    
    var steps: [MKRoute.Step] = []
    var stepCounter = 0
    var route: MKRoute?
    var showMapRoute = false
    var navigationStarted = false
    let locationDistance: Double = 500
    
    var speechsynthesizer = AVSpeechSynthesizer()
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            handleAuthorizationStatus(locationManager: locationManager, status: CLLocationManager.authorizationStatus())
        } else {
            print("Location services are not enabled")
        }
        
       return locationManager
    }()
    
    
    lazy var directionLabel: UILabel = {
        let label = UILabel()
        label.text = "Куда поедем?"
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите адрес пункта назначения"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var getDirectionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ок", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(getDirectionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var startStopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать маршрут", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    
    @objc fileprivate func getDirectionButtonTapped() {
        guard let text = textField.text else { return }
        showMapRoute = true
        textField.endEditing(true)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(text) { (placemarks, error) in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
            let placemark =  placemarks.first,
            let location = placemark.location
            else { return }
            
            let destinationCoordinate = location.coordinate
            self.mapRoute(destinationCoordinate: destinationCoordinate)
            
        }
    }
    
    @objc fileprivate func startStopButtonTapped() {
        if !navigationStarted {
            showMapRoute = true
            if let location = locationManager.location {
                let center = location.coordinate
                centerViewToUserLocation(center: center)
            }
        } else {
           if let route = route {
               self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
               self.steps.removeAll()
               self.stepCounter = 0
               
            }
        }
        
        navigationStarted.toggle()
        
        startStopButton.setTitle(navigationStarted ? "Завершить маршрут" : "Начать маршрут", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        locationManager.startUpdatingLocation()
        
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .systemBackground
       
        stack(.vertical)(directionLabel.insetting(by: 16), stack(.horizontal, spacing: 16) (textField, getDirectionButton).insetting(by: 16), startStopButton.insetting(by: 16), mapView).fillingParent(relativeToSafeArea: true).layout(in: view)
    }
    
    fileprivate func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: locationDistance, longitudinalMeters: locationDistance)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //
            break
        case .denied:
            //
            break
        case .authorizedAlways:
            //
            break
        case .authorizedWhenInUse:
            if let center = locationManager.location?.coordinate {
                centerViewToUserLocation(center: center)
            }
            break
        
        }
    }
    
    fileprivate func mapRoute(destinationCoordinate: CLLocationCoordinate2D) {
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark:  destinationPlacemark)
        
        let routeRequest = MKDirections.Request()
        routeRequest.source = sourceItem
        routeRequest.destination = destinationItem
        routeRequest.transportType = .automobile
        
        let directions = MKDirections(request: routeRequest)
        directions.calculate { ( response, error ) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response, let route = response.routes.first else { return }
            
            self.route = route
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), animated: true)
            
            self.getRouteSteps(route: route)
        }
    }
    
    fileprivate func getRouteSteps(route: MKRoute) {
        for monitoredRegion in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: monitoredRegion)
        }
        
        let steps = route.steps
        self.steps = steps
        
        for i in 0..<steps.count {
            let step = steps[i]
            print(step.instructions)
            print(step.distance)
            
            let region = CLCircularRegion(center: step.polyline.coordinate, radius: 20, identifier: "\(i)")
            locationManager.startMonitoring(for: region)
        }
        
        stepCounter += 1
        let initialMessage  = "Через \(steps[stepCounter].distance) метров \(steps[stepCounter].instructions), затем через \(steps[stepCounter + 1].distance) метров, \(steps[stepCounter + 1].instructions)"
        directionLabel.text = initialMessage
        let speechUtterance = AVSpeechUtterance(string: initialMessage)
        speechsynthesizer.speak(speechUtterance)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !showMapRoute {
            if let location = locations.last {
                let center = location.coordinate
                centerViewToUserLocation(center: center)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus(locationManager: locationManager, status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        stepCounter += 1
        if stepCounter < steps.count {
            let message = "Через \(steps[stepCounter].distance) метров \(steps[stepCounter].instructions)"
            directionLabel.text = message
            let speechUtterance = AVSpeechUtterance(string: message)
            speechsynthesizer.speak(speechUtterance)
            
        } else {
            let message = "Вы приехали в пункт назначения"
            directionLabel.text = message
            stepCounter = 0
            navigationStarted = false
            for monitoredRegion in locationManager.monitoredRegions {
                locationManager.stopMonitoring(for: monitoredRegion)
            }
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemBlue
        return renderer
    }
}

//class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
//
//    let mapView = MKMapView()
//    let locationManager = CLLocationManager()
//
//    override func loadView() {
//        super.loadView()
//        view.backgroundColor = .white
//        setupMapView()
//        configureMapView()
//        checkUserLocationPermission()
//        //appPin()
//        appPin2()
//        //addRouter()
//        addRouter1()
//    }
//
//    private func setupMapView() {
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mapView)
//
//        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    private func configureMapView() {
//        mapView.mapType = .standard
//        mapView.showsCompass = true
//        mapView.showsTraffic = true
//        mapView.showsUserLocation = true
//        mapView.showsScale = true
//
//        let coordinates = CLLocationCoordinate2D(latitude: 55.760275342115456, longitude: 37.61864859845583)
//        mapView.setCenter(coordinates, animated: true)
//
//        //        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//        //            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        //            self.mapView.setRegion(region, animated: true)
//        //        }
//    }
//
//
//
//    private func checkUserLocationPermission() {
//        switch locationManager.authorizationStatus {
//
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//
//        case .authorizedWhenInUse, .authorizedAlways:
//            mapView.showsUserLocation = true
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = 10
//            locationManager.startUpdatingLocation()
//
//        case .denied, .restricted:
//            print("Попросить пользователя включить локацию")
//        @unknown default:
//            fatalError("Необрабатываемый статус")
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(region, animated: true)
//
//    }
//
////    private func appPin() {
////        let annotation = MKPointAnnotation()
////        annotation.title = "Наш пин"
////        annotation.coordinate = CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30)
////        mapView.addAnnotation(annotation)
////    }
//
////    private func addRouter() {
////        let directionRequest = MKDirections.Request()
////        // вид транспорта
////        directionRequest.transportType = .automobile
////
////        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30))
////        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
////
////        let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 62.93, longitude: 28.30))
////        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
////
////        let directions = MKDirections(request: directionRequest)
////        directions.calculate { response, error in
////
////            guard let route = response?.routes.first else { return }
////            self.mapView.delegate = self
////            self.mapView.addOverlay(route.polyline)
////        }
////    }
//
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        // с помощью polyline рисуются отрезки на карте
//        let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = .blue
//        renderer.lineWidth = 4
//        return renderer
//    }
//
//        private func addRouter1() {
//            let directionRequest = MKDirections.Request()
//
//            directionRequest.transportType = .walking
//
//            let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.760275342115456, longitude: 37.61864859845583))
//            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
//
//            let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.760087, longitude: 37.613141))
//            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
//
//            let directions = MKDirections(request: directionRequest)
//            directions.calculate { response, error in
//                guard let route = response?.routes.first else { return }
//                self.mapView.delegate = self
//                self.mapView.addOverlay(route.polyline)
//            }
//        }
//
//    private func appPin2() {
//        let annotation = MKPointAnnotation()
//        annotation.title = "МХАТ им. Чехова А.П."
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.760087, longitude: 37.613141)
//        mapView.addAnnotation(annotation)
//    }
//}
