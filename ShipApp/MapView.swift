//
//  MapView.swift
//  ShipApp
//
//  Created by User24 on 2020/3/31.
//  Copyright © 2020 User24. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import Firebase

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
        parent.centerCoordinate = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

extension Double {
    func floor(toDecimal decimal: Int) -> Double {
        let numberOfDigits = pow(10.0, Double(decimal))
        return (self * numberOfDigits).rounded(.towardZero) / numberOfDigits
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var coordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    @EnvironmentObject var locationData: LocationData
    @State private var currentLatitude: Double = 0.0
    @State private var currentLongitude: Double = 0.0
    let db = Firestore.firestore()
    var locationCoordinates: [CLLocationCoordinate2D]
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        /*if(locationData.locationChanged){
            view.removeAnnotations(view.annotations)
            annotations[0].title = "目的地"
            let latitude = annotations[0].coordinate.latitude.floor(toDecimal: 4)
            let longitude = annotations[0].coordinate.longitude.floor(toDecimal: 4)
            annotations[0].subtitle = String(latitude) + "\"N , " + String(longitude) + "\"E"
            view.addAnnotation(annotations[0])
            locationData.latitude = String(latitude)
            locationData.longitude = String(longitude)
        }
        locationData.locationChanged = false*/
        
        
        
       /* (db as AnyObject) .collection("ship").document("gps").getDocument{ (document,
        error)in
            if document?.documentID == "CurrentLatitude"{
                self.currentLatitude = document?.data()?["CurrentLatitude"] as! Double
            }
            else if document?.documentID == "CurrentLongitude"{
                self.currentLongitude = document?.data()?["CurrentLongitude"] as! Double
            }
        }*/
        
        //view.removeAnnotations(view.annotations)
        view.addAnnotations(annotations)
        
        print(currentLatitude)
        print(currentLongitude)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), annotations: [MKPointAnnotation](), locationCoordinates: [CLLocationCoordinate2D()]).environmentObject(LocationData())
    }
}
