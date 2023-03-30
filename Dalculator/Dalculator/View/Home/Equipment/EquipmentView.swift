//
//  EquipmentView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

struct EquipmentView: View {
    
    @ObservedObject var viewModel:EquipmentViewModel
    
    @State private var jobToggle: Bool = false
    @State private var itemToggle: Bool = false
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                R.image.bg.swiftImage
                    .resizable()
                
                VStack(spacing: 20) {
                    if !(viewModel.selectedShoes.isEmpty) {
                        HStack {
                            itemImage(imageName: viewModel.selectedShoulder, itemType: .shoulder)
                            Spacer()
                            itemImage(imageName: viewModel.selectedWeapon, itemType: .sword)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedCoat, itemType: .coat)
                            Spacer()
                            itemImage(imageName: viewModel.selectedNecklace, itemType: .necklace)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedPants, itemType: .pants)
                            Spacer()
                            Button {
                                jobToggle.toggle()
                            } label: {
                                Image(viewModel.selectedJob.name)
                            }
                            .fullScreenCover(isPresented: $jobToggle) {
                                FullScreenContentView {
                                    VStack(alignment: .leading) {
                                        Text("직업 선택")
                                            .font(.system(size: 24, weight: .bold))
                                        Divider()
                                        ScrollView {
                                            LazyVGrid(columns: columns) {
                                                ForEach(viewModel.championList, id: \.self) { champion in
                                                    Button {
                                                        viewModel.selectedJob = champion
                                                        jobToggle.toggle()
                                                    } label: {
                                                        Image(champion.name)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                            itemImage(imageName: viewModel.selectedBracelet, itemType: .bracelet)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedBelt, itemType: .belt)
                            Spacer()
                            itemImage(imageName: viewModel.selectedRing, itemType: .ring)
                        }
                        HStack {
                            itemImage(imageName: viewModel.selectedShoes, itemType: .shoes)
                            Spacer()
                            itemImage(imageName: viewModel.selectedSupEquip, itemType: .supequip)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
                .background(Group {
                    NavigationLink(isActive: $itemToggle) {
                        ItemListView(viewModel: viewModel)
                            .navigationTitle("장비 선택")
                    } label: {
                        EmptyView()
                    }
                })
            }
        }
        .onAppear {
            viewModel.loadChampionList()
            viewModel.loadItemList()
            viewModel.loadItemSetList()
        }
    }
    
    @ViewBuilder
    private func itemImage(imageName: String, itemType: ItemType) -> some View {
        Button {
            viewModel.settingSetItemType(type: itemType)
            viewModel.settingItemType(type: itemType)
            itemToggle.toggle()
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
