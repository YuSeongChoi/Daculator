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
    @StateObject private var viewModel = BlacksmithViewModel()
    
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
                itemInfoView(item: userCoordinator.userShoulder.item, forceLevel: userCoordinator.userShoulder.itemForce)
                itemInfoView(item: userCoordinator.userCoat.item, forceLevel: userCoordinator.userCoat.itemForce)
                itemInfoView(item: userCoordinator.userPants.item, forceLevel: userCoordinator.userPants.itemForce)
                itemInfoView(item: userCoordinator.userBelt.item, forceLevel: userCoordinator.userBelt.itemForce)
                itemInfoView(item: userCoordinator.userShoes.item, forceLevel: userCoordinator.userShoes.itemForce)
                itemInfoView(item: userCoordinator.userWeapon.item, forceLevel: userCoordinator.userWeapon.itemForce)
                itemInfoView(item: userCoordinator.userBracelet.item, forceLevel: userCoordinator.userBracelet.itemForce)
                itemInfoView(item: userCoordinator.userNecklace.item, forceLevel: userCoordinator.userNecklace.itemForce)
                itemInfoView(item: userCoordinator.userRing.item, forceLevel: userCoordinator.userRing.itemForce)
                itemInfoView(item: userCoordinator.userSupEquip.item, forceLevel: userCoordinator.userSupEquip.itemForce)
            }
            .padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.vertical, 1)
        .background(R.image.bg.swiftImage.resizable())
        .background(EmptyView().alert(item: $viewModel.alertItem, content: \.alert))
        .onDisappear {
            viewModel.taskStorage.forEach{ $0.cancel() }
            viewModel.taskStorage = []
        }
    }
    
    @ViewBuilder
    private func itemInfoView(item: ItemVOElement, forceLevel: Int) -> some View {
        HStack {
            ZStack {
                R.image.epicBackground.swiftImage
                    .resizable()
                    .frame(width: 90, height: 90)
                    .overlay(
                        Image(item.image, bundle: R.bundle)
                            .resizable()
                            .frame(width: 80, height: 80)
                    )
                    .cornerRadius(8)
                
                Text("\(forceLevel)")
                    .foregroundColor(.white)
                    .font(R.font.notoSansCJKkrBold.swiftFontOfSize(14))
            }
            
            Text("\(item.itype?.rawValue ?? "")")
                .foregroundColor(.white)
                .font(R.font.notoSansCJKkrRegular.swiftFontOfSize(14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}
