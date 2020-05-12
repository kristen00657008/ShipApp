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
    @State private var showAlert: Bool = false
    @State private var showMapAlert: Bool = false
    func readData(){
        let db = Firestore.firestore()
        
        db.collection("ship").document("gps").getDocument { (document, error) in
            if let document = document, document.exists {
                self.locationData.CurrentLatitude = document.data()?["CurrentLatitude"] as! String
                self.locationData.CurrentLongitude = document.data()?["CurrentLongitude"] as! String
                self.locationData.CurrentLocation = "（ \(self.locationData.CurrentLatitude) , \(self.locationData.CurrentLongitude) )"
                print("Current latitude:\(self.locationData.CurrentLatitude)"  )
                print("Current longitude:\(self.locationData.CurrentLongitude)"  )
            } else {
                print("Document does not exist")
            }
            
            let shipAnnotation = MKPointAnnotation()
            shipAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double((self.locationData.CurrentLatitude as NSString).doubleValue), longitude: Double((self.locationData.CurrentLongitude as NSString).doubleValue))
            
            self.locationData.CurrentAnnotation = shipAnnotation
            self.locationData.Annotations.append(shipAnnotation)
            self.locationData.DestinationAnnotation.append(shipAnnotation)
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text("你的位置")
                            TextField("( , )" , text: $locationData.CurrentLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 230)
                                .disabled(true)
                            Button(action: {
                                self.readData()
                                self.locationData.canOpenMap = true
                            }) {
                                Image("refresh")
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        HStack{
                            Text("目的地    ")
                            TextField("( , )" , text: $locationData.DestinationLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 230)
                                .disabled(true)
                        }
                    }
                    
                }.frame(width: 350)
                HStack(alignment: .center){
                    Text("選擇目的地: ")
                    Button(action: {
                        if(!self.locationData.canOpenMap){
                            self.showMapAlert = true
                        }
                        else{
                            self.showMap = true
                        }
                        
                    }) {
                        Image("map")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .alert(isPresented:self.$showMapAlert) {
                        Alert(title: Text("請先重新整理你的位置"), dismissButton: .default(Text("OK")))
                    }
                    .sheet(isPresented: $showMap){
                        AutoControl().environmentObject(self.locationData)
                    }
                    
                    Button(action: {
                        if(!self.locationData.canStartNavigation){
                            self.showAlert = true
                        }
                    }) {
                        Text("開始導航")
                    }
                    .alert(isPresented:self.$showAlert) {
                        Alert(title: Text("請先選擇目的地"), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
            }
        }
        
    }
}

struct GPS_Previews: PreviewProvider {
    static var previews: some View {
        GPS()
    }
}
