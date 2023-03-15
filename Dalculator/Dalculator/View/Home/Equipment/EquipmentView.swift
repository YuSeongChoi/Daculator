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
        ScrollView {
            VStack {
                ForEach(viewModel.championList, id: \.self) { champ in
                    Image(champ.name)
                }
                ForEach(viewModel.itemList, id: \.self) { item in
                    Image(item.name)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.loadChampionList()
            viewModel.loadItemList()
        }
    }
    
}
