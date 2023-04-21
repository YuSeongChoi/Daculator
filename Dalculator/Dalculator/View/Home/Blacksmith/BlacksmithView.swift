//
//  BlacksmithView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

struct BlacksmithView: View {
    
    @ObservedObject var viewModel: EquipmentViewModel
    
    @State private var itemToggle: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                R.image.bg.swiftImage
                    .resizable()
                
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        HStack(spacing: 5) {
                            itemImage(item: viewModel.selectedShoulder)
                            itemImage(item: viewModel.selectedCoat)
                            itemImage(item: viewModel.selectedPants)
                            itemImage(item: viewModel.selectedBelt)
                            itemImage(item: viewModel.selectedShoes)
                        }
                        HStack(spacing: 5) {
                            itemImage(item: viewModel.selectedWeapon)
                            itemImage(item: viewModel.selectedNecklace)
                            itemImage(item: viewModel.selectedBracelet)
                            itemImage(item: viewModel.selectedRing)
                            itemImage(item: viewModel.selectedSupEquip)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
            }
        }
    }
    
    @ViewBuilder
    private func itemImage(item: ItemVOElement) -> some View {
        VStack {
            Button {
                itemToggle.toggle()
            } label: {
                R.image.epicBackground.swiftImage
                    .resizable()
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(item.image, bundle: R.bundle)
                            .resizable()
                            .frame(width: 50, height: 50)
                    )
                    .cornerRadius(8)
            }
            
            Text("\(item.itype?.rawValue ?? "")")
                .foregroundColor(.white)
                .font(R.font.notoSansCJKkrRegular.swiftFontOfSize(14))
        }
    }
    
}
