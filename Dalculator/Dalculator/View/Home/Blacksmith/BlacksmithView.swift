//
//  BlacksmithView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

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
                            itemImage(imageName: viewModel.selectedShoulder, itemType: .shoulder)
                            itemImage(imageName: viewModel.selectedCoat, itemType: .coat)
                            itemImage(imageName: viewModel.selectedPants, itemType: .pants)
                            itemImage(imageName: viewModel.selectedBelt, itemType: .belt)
                            itemImage(imageName: viewModel.selectedShoes, itemType: .shoes)
                        }
                        HStack(spacing: 5) {
                            itemImage(imageName: viewModel.selectedWeapon, itemType: .sword)
                            itemImage(imageName: viewModel.selectedNecklace, itemType: .necklace)
                            itemImage(imageName: viewModel.selectedBracelet, itemType: .bracelet)
                            itemImage(imageName: viewModel.selectedRing, itemType: .bracelet)
                            itemImage(imageName: viewModel.selectedSupEquip, itemType: .supequip)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
            }
        }
    }
    
    @ViewBuilder
    private func itemImage(imageName: String, itemType: ItemType) -> some View {
        Button {
            itemToggle.toggle()
        } label: {
            R.image.epicBackground.swiftImage
                .resizable()
                .frame(width: 60, height: 60)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                )
                .cornerRadius(8)
        }
    }
    
}
