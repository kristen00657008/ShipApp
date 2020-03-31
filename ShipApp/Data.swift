//
//  Data.swift
//  ShipApp
//
//  Created by User24 on 2020/3/31.
//  Copyright © 2020 User24. All rights reserved.
//

import Foundation

class LocationData: ObservableObject {
    @Published var locationChanged = false
    @Published var latitude = ""
    @Published var longitude = ""
}
