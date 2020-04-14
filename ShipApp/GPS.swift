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
    @EnvironmentObject var locationData: LocationData
    
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
            self.locationData.Annotations.append(shipAnnotation)
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("選擇目的地: ")
                Button(action: {
                    self.showMap = true
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
                TextField("", text: $locationData.DestinationLatitude )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }.frame(width: 300)
            HStack{
                Text("緯度")
                TextField("", text: $locationData.DestinationLongitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .disabled(true)
            }.frame(width: 300)
            
            Button(action: {
                
            }) {
                Text("開始導航")
            }
            
            HStack{
                Text("船的經度")
                TextField("", text: $locationData.CurrentLatitude )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(true)
            }.frame(width: 300)
            HStack{
                Text("船的緯度")
                TextField("", text: $locationData.CurrentLongitude)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .disabled(true)
            }.frame(width: 300)
            
            Button(action: {
                self.readData()
            }) {
                Text("重新整理")
            }
        }
    }
}

struct GPS_Previews: PreviewProvider {
    static var previews: some View {
        GPS()
    }
}
