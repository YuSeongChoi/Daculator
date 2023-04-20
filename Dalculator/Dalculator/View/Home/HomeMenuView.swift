//
//  HomeMenuView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import DalculatorResources

struct HomeMenuView: View {
    
    typealias TabItemType = Constants.MainTabItem
    @Namespace private var nameSpace
    @StateObject private var viewModel = EquipmentViewModel()
    
    @State private var selection = TabItemType.equipment
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(TabItemType.allCases, id: \.self) { tab in
                    Button {
                        withAnimation {
                            selection = tab
                        }
                    } label: {
                        if selection == tab {
                            Color.brown.overlay(
                                Text(tab.title)
                            )
                        } else {
                            Color.clear.overlay(
                                Text(tab.title)
                            )
                        }
                    }
                    .foregroundColor(selection == tab ? .white : .black)
                    .font(selection == tab ? Font.system(size: 16, weight: .bold) : Font.system(size: 16))
                }
            }
            .background(Divider(), alignment: .bottom)
            .background(Divider(), alignment: .top)
            .frame(height: 52)
            .animation(.linear, value: selection)
            TabView(selection: $selection) {
                EquipmentView(viewModel: viewModel)
                    .tag(TabItemType.equipment)
                BlacksmithView(viewModel: viewModel)
                    .tag(TabItemType.blacksmith)
                AvatarView()
                    .tag(TabItemType.avatar)
                SealView()
                    .tag(TabItemType.seal)
                EtcView()
                    .tag(TabItemType.etc)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
}
