//
//  MapViewController.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 21.08.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    override func loadView() {
        super.loadView()
        
        setupMapView()
        configureMapView()
        checkUserLocationPermission()
        //appPin()
        appPin2()
        //addRouter()
        addRouter1()
    }
    
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureMapView() {
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsTraffic = true
        mapView.showsUserLocation = true
        mapView.showsScale = true
        
        let coordinates = CLLocationCoordinate2D(latitude: 55.760275342115456, longitude: 37.61864859845583)
        mapView.setCenter(coordinates, animated: true)
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        //            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        //            self.mapView.setRegion(region, animated: true)
        //        }
    }
    
    
    
    private func checkUserLocationPermission() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            locationManager.delegate = self
            locationManager.desiredAccuracy = 10 
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            print("Попросить пользователя включить локацию")
        @unknown default:
            fatalError("Необрабатываемый статус")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
    }
    
//    private func appPin() {
//        let annotation = MKPointAnnotation()
//        annotation.title = "Наш пин"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30)
//        mapView.addAnnotation(annotation)
//    }
    
//    private func addRouter() {
//        let directionRequest = MKDirections.Request()
//        // вид транспорта
//        directionRequest.transportType = .automobile
//
//        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 59.93, longitude: 30.30))
//        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
//
//        let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 62.93, longitude: 28.30))
//        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
//
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate { response, error in
//
//            guard let route = response?.routes.first else { return }
//            self.mapView.delegate = self
//            self.mapView.addOverlay(route.polyline)
//        }
//    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // с помощью polyline рисуются отрезки на карте
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4
        return renderer
    }
        
        private func addRouter1() {
            let directionRequest = MKDirections.Request()
            
            directionRequest.transportType = .walking
            
            let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.760275342115456, longitude: 37.61864859845583))
            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
            
            let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.760087, longitude: 37.613141))
            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate { response, error in
                guard let route = response?.routes.first else { return }
                self.mapView.delegate = self
                self.mapView.addOverlay(route.polyline)
            }
        }
    
    private func appPin2() {
        let annotation = MKPointAnnotation()
        annotation.title = "МХАТ им. Чехова А.П."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.760087, longitude: 37.613141)
        mapView.addAnnotation(annotation)
    }
}