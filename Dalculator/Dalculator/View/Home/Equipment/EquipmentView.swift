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
                                jobToggle.toggle()
                            } label: {
                                Image(viewModel.selectedJob)
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
                                                        viewModel.selectedJob = champion.name
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
    private func itemImage(imageName: String) -> some View {
        Button {
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
