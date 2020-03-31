//
//  AutoControl.swift
//  ShipApp
//
//  Created by User24 on 2020/3/30.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI
import  MapKit

struct AutoControl: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var location = MKPointAnnotation()
    @State private var showAlert = false
    @EnvironmentObject var locationData: LocationData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate,coordinate: CLLocationCoordinate2D(latitude: 25.1514, longitude: 121.7785) ,annotation: location)
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
                                self.locationData.locationChanged = false
                            }), secondaryButton: .default(Text("是"), action: {
                                let newLocation = MKPointAnnotation()
                                newLocation.coordinate = self.centerCoordinate
                                self.location = newLocation
                                self.locationData.locationChanged = true
                            }))
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
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
