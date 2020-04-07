//
//  GPS.swift
//  ShipApp
//
//  Created by User24 on 2020/3/31.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI
import MapKit
import Firebase
struct GPS: View {
    
    @State var showMap = false
    @State private var annotations = [MKPointAnnotation]()
    @EnvironmentObject var locationData: LocationData
    @State private var currentLatitude: Double = 0
    @State private var currentLongitude: Double = 0
    
    func readData(){
        let db = Firestore.firestore()
       
        db.collection("ship").document("gps").getDocument { (document, error) in
             print("1111111111")
           if let document = document, document.exists {
            
            
            print(document.data()?["CurrentLatitude"] as! String)
            
            //Double((document.data() as NSString).doubleValue)
            self.currentLatitude = Double(document.data()?["CurrentLatitude"] as! String) as! Double
            self.currentLongitude = Double(document.data()?["CurrentLongitude"] as! String) as! Double
            print("CLT:\(self.currentLatitude)"  )
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.currentLatitude, longitude: self.currentLongitude)
            self.annotations.append(annotation)
            print(annotation.coordinate.latitude)
           } else {
              print("Document does not exist")
           }
        }
        
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Text("選擇目的地: ")
                Button(action: {
                    self.showMap = true
                    //let annotation = MKPointAnnotation()
                    self.readData()
                    
                    
                    //annotation.coordinate = CLLocationCoordinate2D(latitude: self.currentLatitude, longitude: self.currentLongitude)
                    //self.annotations.append(annotation)
                    
                }) {
                    Image("map")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .sheet(isPresented: $showMap){
                    AutoControl().environmentObject(self.locationData)
                }
            }
            HStack{
                Text("經度")
                TextField("", text: $locationData.latitude )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }.frame(width: 300)
            HStack{
                Text("緯度")
                TextField("", text: $locationData.longitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .disabled(true)
            }.frame(width: 300)
            
            Button(action: {
                
            }) {
                Text("開始導航")
            }
            
            
        }
    }
}

struct GPS_Previews: PreviewProvider {
    static var previews: some View {
        GPS()
    }
}
