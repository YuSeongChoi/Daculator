//
//  EquipmentView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

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
                    if !(viewModel.selectedShoes.image.isEmpty) {
                        HStack {
                            itemImage(item: viewModel.selectedShoulder)
                            Spacer()
                            itemImage(item: viewModel.selectedWeapon)
                        }
                        HStack {
                            itemImage(item: viewModel.selectedCoat)
                            Spacer()
                            itemImage(item: viewModel.selectedBracelet)
                        }
                        HStack {
                            itemImage(item: viewModel.selectedPants)
                            Spacer()
                            Button {
                                jobToggle.toggle()
                            } label: {
                                Image(viewModel.selectedJob.name, bundle: R.bundle)
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
                                                        Image(champion.name, bundle: R.bundle)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                            itemImage(item: viewModel.selectedNecklace)
                        }
                        HStack {
                            itemImage(item: viewModel.selectedBelt)
                            Spacer()
                            itemImage(item: viewModel.selectedRing)
                        }
                        HStack {
                            itemImage(item: viewModel.selectedShoes)
                            Spacer()
                            itemImage(item: viewModel.selectedSupEquip)
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
    private func itemImage(item: ItemVOElement) -> some View {
        Button {
            guard let itype = item.itype else { return }
            viewModel.settingSetItemType(type: itype)
            viewModel.settingItemType(type: itype)
            itemToggle.toggle()
        } label: {
            R.image.epicBackground.swiftImage
                .resizable()
                .frame(width: 80, height: 80)
                .overlay(
                    Image(item.image, bundle: R.bundle)
                        .resizable()
                        .frame(width: 70, height: 70)
                )
                .cornerRadius(8)
        }
    }
    
}
