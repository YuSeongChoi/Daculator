//
//  ItemListView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/17.
//

import SwiftUI

import RswiftResources

struct ItemListView: View {
    
    @ObservedObject var viewModel: EquipmentViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 15) {
                ForEach(viewModel.itemDict.sorted{ $0.key < $1.key }, id: \.key) { key, items in
                    VStack(spacing: 10) {
                        Text(key)
                            .font(.system(size: 20, weight: .bold))
                        HStack(spacing: 5) {
                            ForEach(items, id: \.self) { item in
                                VStack(alignment: .center) {
                                    Image(item.image)
                                        .cornerRadius(12)
                                    Text(item.name)
                                        .frame(width: 50)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                                .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
    }
    
}
