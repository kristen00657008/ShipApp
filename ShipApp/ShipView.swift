//
//  ContentView.swift
//  ShipApp
//
//  Created by User24 on 2020/3/24.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI
import Firebase


struct ShipView: View {
    
    //@EnvironmentObject var movesData: MovesData
    @State private var leftState = false
    @State private var rightState = false
    @State private var currentState = "停止"
    let db: Any
    init(){
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    func upDate(leftState: Bool, rightState:Bool){
                 
        (db as AnyObject).collection("ship").document("Go").setData([
            "left": leftState,
            "right": rightState
         ]) { err in
             if let err = err {
                 print("Error writing document: \(err)")
             } else {
                 print("Document successfully written!")
             }
         }
    }
    
    var body: some View {
        VStack{
            Text("目前狀態「\(currentState)」")
                .font(Font.system(size: 40))
                .foregroundColor(Color.red)
            Button(action:{
                self.leftState = false
                self.rightState = false
                self.currentState = "前進"
                self.upDate(leftState: self.leftState, rightState: self.rightState)
                print("forward")
            }) {
                Image("direction")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: 270))
                    
                //Text("前進")
            }
            HStack{
                Button(action:{
                    self.leftState = true
                    self.rightState = false
                    self.currentState = "左轉"
                    self.upDate(leftState: self.leftState, rightState: self.rightState)
                    print("left")
                }) {
                    Image("direction")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees: 180))
                }
                Spacer()
                Button(action:{
                    self.leftState = false
                    self.rightState = true
                    self.currentState = "右轉"
                    self.upDate(leftState: self.leftState, rightState: self.rightState)
                    print("right")
                }) {
                    Image("direction")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 100, height: 100)
                }
            }.frame(width: 300)
            
            Button(action:{
                self.leftState = false
                self.rightState = false
                self.currentState = "後退"
                self.upDate(leftState: self.leftState, rightState: self.rightState)
                print("back")
            }) {
                Image("direction")
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: 90))
            }
        }
       
    }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}


