//
//  TabView.swift
//  ShipApp
//
//  Created by User24 on 2020/3/30.
//  Copyright © 2020 User24. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            ManualControl()
                .tabItem {
                    Image("handle")
                        .resizable()
                        .frame(width: 5, height: 1)
                    Text("手動控制")
            }
            AutoControl()
                .tabItem {
                    Text("自動控制")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
