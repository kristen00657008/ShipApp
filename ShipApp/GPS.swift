//
//  GPS.swift
//  ShipApp
//
//  Created by User24 on 2020/3/31.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI

struct GPS: View {
    
    @State var showMap = false
    
    @EnvironmentObject var locationData: LocationData
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
                    //Text("123")
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
