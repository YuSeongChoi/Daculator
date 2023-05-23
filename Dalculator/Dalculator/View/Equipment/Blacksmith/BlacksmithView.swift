//
//  BlacksmithView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

struct BlacksmithView: View {
    
    @StateObject private var viewModel = EquipmentViewModel()
    
    @State private var itemToggle: Bool = false
    @State private var shoulderForce: String = ""
    @State private var coatForce: String = ""
    @State private var pantsForce: String = ""
    @State private var beltForce: String = ""
    @State private var shoesForce: String = ""
    @State private var weaponForce: String = ""
    @State private var necklaceForce: String = ""
    @State private var braceletForce: String = ""
    @State private var ringForce: String = ""
    @State private var supequipForce: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                itemInfoView(item: viewModel.selectedShoulder, forceLevel: $shoulderForce)
                itemInfoView(item: viewModel.selectedCoat, forceLevel: $coatForce)
                itemInfoView(item: viewModel.selectedPants, forceLevel: $pantsForce)
                itemInfoView(item: viewModel.selectedBelt, forceLevel: $beltForce)
                itemInfoView(item: viewModel.selectedShoes, forceLevel: $shoesForce)
                itemInfoView(item: viewModel.selectedWeapon, forceLevel: $weaponForce)
                itemInfoView(item: viewModel.selectedNecklace, forceLevel: $necklaceForce)
                itemInfoView(item: viewModel.selectedBracelet, forceLevel: $braceletForce)
                itemInfoView(item: viewModel.selectedRing, forceLevel: $ringForce)
                itemInfoView(item: viewModel.selectedSupEquip, forceLevel: $supequipForce)
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
        .padding(.vertical, 1)
        .background(R.image.bg.swiftImage.resizable())
    }
    
    @ViewBuilder
    private func itemInfoView(item: ItemVOElement, forceLevel: Binding<String>) -> some View {
        HStack(spacing: 5) {
            VStack {
                Button {
                    guard let itype = item.itype else { return }
                    viewModel.settingSetItemType(type: itype)
                    viewModel.settingItemType(type: itype)
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
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    .font(R.font.notoSansCJKkrRegular.swiftFontOfSize(14))
            }
            VStack {
                TextField("강화수치", text: forceLevel)
                    .frame(width: 60)
                    .font(R.font.notoSansCJKkrRegular.swiftFontOfSize(11))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}
