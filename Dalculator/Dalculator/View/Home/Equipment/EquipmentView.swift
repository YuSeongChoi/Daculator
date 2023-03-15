//
//  EquipmentView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

struct EquipmentView: View {
    
    @StateObject private var viewModel = EquipmentViewModel()
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                R.image.bg.swiftImage
                    .resizable()
                
                VStack(spacing: 20) {
                    if !(viewModel.selectedShoes.isEmpty) {
                        HStack {
                            itemImage(imageName: viewModel.selectedShoulder)
                            Spacer()
                            itemImage(imageName: viewModel.selectedWeapon)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedCoat)
                            Spacer()
                            itemImage(imageName: viewModel.selectedNecklace)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedPants)
                            Spacer()
                            Button {
                                // TODO: 직업 선택
                            } label: {
                                Image(viewModel.selectedJob)
                            }
                            Spacer()
                            itemImage(imageName: viewModel.selectedBracelet)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedBelt)
                            Spacer()
                            itemImage(imageName: viewModel.selectedRing)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedShoes)
                            Spacer()
                            itemImage(imageName: viewModel.selectedSupEquip)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
            }
        }
        .onAppear {
            viewModel.loadChampionList()
            viewModel.loadItemList()
        }
    }
    
    @ViewBuilder
    private func itemImage(imageName: String) -> some View {
        Button {
            // TODO: 아이템 선택
        } label: {
            R.image.epicBackground.swiftImage
                .resizable()
                .frame(width: 80, height: 80)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .frame(width: 70, height: 70)
                )
                .cornerRadius(8)
        }
    }
    
}
