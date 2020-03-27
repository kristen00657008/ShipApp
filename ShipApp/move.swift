//
//  move.swift
//  ShipApp
//
//  Created by User24 on 2020/3/24.
//  Copyright © 2020 User24. All rights reserved.
//

import Foundation

struct DirectionState {
    var leftState: Bool
    var rightState: Bool
}

class MovesData: ObservableObject  {
    @Published var states = [DirectionState]()
}
