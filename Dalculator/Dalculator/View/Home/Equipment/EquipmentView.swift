//
//  EquipmentView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

struct EquipmentView: View {
    
    @StateObject private var viewModel = EquipmentViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.championList, id: \.self) { champ in
                Image(champ.name)
            }
        }
        .onAppear {
            viewModel.loadChampionName(fileName: R.file.dfclassJson.name)
        }
        
    }
    
}
