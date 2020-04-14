//
//  Data.swift
//  ShipApp
//
//  Created by User24 on 2020/3/31.
//  Copyright © 2020 User24. All rights reserved.
//

import Foundation
import MapKit

class LocationData: ObservableObject {
    @Published var DestinationChanged = false
    @Published var DestinationLatitude = ""
    @Published var DestinationLongitude = ""
    @Published var CurrentLatitude = ""
    @Published var CurrentLongitude = ""
    @Published var CurrentAnnotation = MKPointAnnotation()
    @Published var DestinationAnnotation = MKPointAnnotation()
    @Published var Annotations = [MKPointAnnotation]()
}
