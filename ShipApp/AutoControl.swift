//
//  AutoControl.swift
//  ShipApp
//
//  Created by User24 on 2020/3/30.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI
import  MapKit
import Firebase

struct AutoControl: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var showAlert = false
    @EnvironmentObject var locationData: LocationData
    @Environment(\.presentationMode) var presentationMode
    
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
    
    func multiThread() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            self.readData()
            print(self.locationData.DestinationAnnotation.count)
            print(self.locationData.DestinationAnnotation[0].coordinate)
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                MapView()
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.multiThread()
                        }) {
                            Text("Ship")
                        }
                        Button(action: {
                            self.showAlert = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                        .alert(isPresented: $showAlert){ () -> Alert in
                            return Alert(title: Text("是否將此座標設為目的地"), message: Text(""), primaryButton: .default(Text("否"), action: {
                            }), secondaryButton: .default(Text("是"), action: {
                                let newLocation = MKPointAnnotation()
                                newLocation.coordinate = self.locationData.centerCoordinate
                                self.locationData.DestinationAnnotation[0] = newLocation
                                self.locationData.DestinationLatitude = String(String(newLocation.coordinate.latitude).prefix(8))
                                self.locationData.DestinationLongitude = String(String(newLocation.coordinate.longitude).prefix(9))
                                self.locationData.DestinationLocation = "（ \(self.locationData.DestinationLatitude) , \(self.locationData.DestinationLongitude) )"
                                self.presentationMode.wrappedValue.dismiss()
                                self.locationData.canStartNavigation = true
                            }))
                        }
                    }
                }
            }
            .navigationBarItems(leading:Toggle("衛星模式", isOn: self.$locationData.satilizeMode)
                ,trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("close")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 30, height: 30)
            })
        }
    }
}

struct AutoControl_Previews: PreviewProvider {
    static var previews: some View {
        AutoControl().environmentObject(LocationData())
    }
}
