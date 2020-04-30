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
import UIKit


struct MapView: UIViewRepresentable {
    @EnvironmentObject var locationData: LocationData
    var timer = Timer()
    
    func readData(){
        let db = Firestore.firestore()
        
        db.collection("ship").document("gps").getDocument { (document, error) in
            if let document = document, document.exists {
                self.locationData.CurrentLatitude = document.data()?["CurrentLatitude"] as! String
                self.locationData.CurrentLongitude = document.data()?["CurrentLongitude"] as! String
                print("Current latitude:\(self.locationData.CurrentLatitude)"  )
                print("Current longitude:\(self.locationData.CurrentLongitude)"  )
            } else {
                print("Document does not exist")
            }
            
            let shipAnnotation = MKPointAnnotation()
            shipAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double((self.locationData.CurrentLatitude as NSString).doubleValue), longitude: Double((self.locationData.CurrentLongitude as NSString).doubleValue))
            
            self.locationData.CurrentAnnotation = shipAnnotation
            self.locationData.Annotations[0] = self.locationData.CurrentAnnotation
        }
        
    }
    
    
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        
        let currentLocation = CLLocationCoordinate2D(latitude: Double((self.locationData.CurrentLatitude as NSString).doubleValue), longitude: Double((self.locationData.CurrentLongitude as NSString).doubleValue))
        let region = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
        mapView.delegate = context.coordinator
        readData()
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(self.locationData.Annotations)
        return mapView
    }
    
    func updateUIView(_ uiview: MKMapView, context: UIViewRepresentableContext<MapView>) {
               
        uiview.removeAnnotations(uiview.annotations)
        uiview.addAnnotations(self.locationData.Annotations)
        if(self.locationData.satilizeMode){
            uiview.mapType = .satellite
        }
        else{
            uiview.mapType = .standard
        }
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ control: MapView) {
            self.parent = control
        }
        
        func mapView(_ mapView: MKMapView, viewFor
            annotation: MKAnnotation) -> MKAnnotationView?{
            //Custom View for Annotation
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
            annotationView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            annotationView.canShowCallout = true
            //Your custom image icon
            
            annotationView.image = UIImage(named: "ship")
            return annotationView
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.locationData.centerCoordinate = mapView.centerCoordinate
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator{
        MapViewCoordinator(self)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
