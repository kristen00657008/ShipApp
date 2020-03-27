//
//  LoverDetail.swift
//  LoverEdit
//
//  Created by SHIH-YING PAN on 2019/12/18.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct LoverDetail: View {
    @EnvironmentObject var loversData: LoversData
    var editLoverIndex: Int

    var body: some View {
        
        let lover = loversData.lovers[editLoverIndex]
        return List {
            Text(lover.name)
            Text("體重 \(lover.weight)")
            Image(systemName: lover.trueHeart ? "heart.fill" : "heart")
        }
        .navigationBarItems(trailing: NavigationLink(destination:
            
            LoverEditor(editLoverIndex: editLoverIndex), label: {
            Text("Edit")
        }))
    }
}

struct LoverDetail_Previews: PreviewProvider {
    static var previews: some View {
        let loversData = LoversData()
        loversData.lovers.append(Lover(name: "Penny", weight: 30, trueHeart: true))
        return LoverDetail(editLoverIndex: 0)
    }
}


