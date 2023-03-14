//
//  HomeMenuView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

struct HomeMenuView: View {
    
    typealias TabItemType = Constants.MainTabItem
    @Namespace private var nameSpace
    
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
                        Color.clear.overlay(
                            Text(tab.title)
                        )
                    }
                    .foregroundColor(selection == tab ? .black : .gray)
                    .font(selection == tab ? Font.system(size: 16, weight: .bold) : Font.system(size: 16))
                    .overlay(
                        HorizontalUnderLineShape(height: 2)
                            .padding(.bottom, 1)
                            .matchedGeometryEffect(id: "underLine", in: nameSpace, properties: .position, anchor: .bottom, isSource: selection == tab)
                            .animation(.default, value: selection)
                    )
                }
            }
            .background(Divider(), alignment: .bottom)
            .background(Divider(), alignment: .top)
            .frame(height: 52)
            .animation(.linear, value: selection)
            TabView(selection: $selection) {
                EquipmentView()
                    .tag(TabItemType.equipment)
                BlacksmithView()
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
