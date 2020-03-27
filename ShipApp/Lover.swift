//
//  Lover.swift
//  LoverEdit
//
//  Created by SHIH-YING PAN on 2019/12/18.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct Lover {
    var name: String
    var weight: Int
    var trueHeart: Bool
}


class LoversData: ObservableObject  {
    @Published var lovers = [Lover]()
}

