//
//  LoverRow.swift
//  LoverEdit
//
//  Created by SHIH-YING PAN on 2019/12/18.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct LoverRow: View {
    var lover: Lover
    
    var body: some View {
        Text(lover.name)
    }
}

struct LoverRow_Previews: PreviewProvider {
    static var previews: some View {
        LoverRow(lover: Lover(name: "penny", weight: 50, trueHeart: true))
    }
}
