//
//  LoverList.swift
//  LoverEdit
//
//  Created by SHIH-YING PAN on 2019/12/18.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct LoverList: View {
    
    @EnvironmentObject var loversData: LoversData
    var body: some View {
        List {
                ForEach(loversData.lovers.indices, id:\.self) { (index) in
                    Text(self.loversData.lovers[index].name)
                }
        }
    }
}

struct LoverList_Previews: PreviewProvider {
    static var previews: some View {
        LoverList()
    }
}
