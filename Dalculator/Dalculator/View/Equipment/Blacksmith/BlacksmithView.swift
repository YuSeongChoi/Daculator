//
//  BlacksmithView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

struct BlacksmithView: View {
    
    @EnvironmentObject private var userCoordinator: UserCoordinator
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
                itemInfoView(item: userCoordinator.userShoulder.item, forceLevel: $shoulderForce)
                itemInfoView(item: userCoordinator.userCoat.item, forceLevel: $coatForce)
                itemInfoView(item: userCoordinator.userPants.item, forceLevel: $pantsForce)
                itemInfoView(item: userCoordinator.userBelt.item, forceLevel: $beltForce)
                itemInfoView(item: userCoordinator.userShoes.item, forceLevel: $shoesForce)
                itemInfoView(item: userCoordinator.userWeapon.item, forceLevel: $weaponForce)
                itemInfoView(item: userCoordinator.userNecklace.item, forceLevel: $necklaceForce)
                itemInfoView(item: userCoordinator.userNecklace.item, forceLevel: $braceletForce)
                itemInfoView(item: userCoordinator.userRing.item, forceLevel: $ringForce)
                itemInfoView(item: userCoordinator.userSupEquip.item, forceLevel: $supequipForce)
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
        }
        .padding(.vertical, 1)
        .background(R.image.bg.swiftImage.resizable())
    }
    
    @ViewBuilder
    private func itemInfoView(item: ItemVOElement, forceLevel: Binding<String>) -> some View {
        HStack(spacing: 5) {
            VStack {
                R.image.epicBackground.swiftImage
                    .resizable()
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(item.image, bundle: R.bundle)
                            .resizable()
                            .frame(width: 50, height: 50)
                    )
                    .cornerRadius(8)
                
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
