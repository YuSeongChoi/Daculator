//
//  ItemListView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/17.
//

import SwiftUI

import DalculatorResources

struct ItemListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: EquipmentViewModel
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView {
            Divider()
            LazyVStack(alignment: .center, spacing: 15) {
                ForEach(viewModel.itemSetDict.sorted{ $0.key < $1.key }, id: \.key) { key, items in
                    VStack(spacing: 10) {
                        Text(key)
                            .font(.system(size: 20, weight: .bold))
                        HStack(spacing: 5) {
                            ForEach(items, id: \.self) { item in
                                VStack(alignment: .center) {
                                    Image(item.image, bundle: R.bundle)
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
                    .onTapGesture {
                        viewModel.itemSetDict[key]?.forEach { item in
                            viewModel.equipItem(item: item)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            partItemView()
        }
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
    
    @ViewBuilder
    private func partItemView() -> some View {
        LazyVGrid(columns: columns) {
            ForEach(viewModel.selectedItem, id: \.self) { item in
                VStack {
                    Image(item.image, bundle: R.bundle)
                        .cornerRadius(12)
                    Text(item.name)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .multilineTextAlignment(.center)
                .onTapGesture {
                    viewModel.equipItem(item: item)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
}
