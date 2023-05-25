//
//  MainRootView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

struct MainRootView: View {
    
    typealias TabItemType = Constants.HomeTabItem
    @StateObject private var coordinator = UserCoordinator()
    @State private var tabSelection: TabItemType = .equipment
    
    var body: some View {
        TabView(selection: $tabSelection) {
            EquipmentView()
                .tag(TabItemType.equipment)
                .tabItem {
                    Label("장비", systemImage: "house.fill")
                }
            
            BlacksmithView()
                .tag(TabItemType.blacksmith)
                .tabItem {
                    Label("대장간", systemImage: "person")
                }
                
            
            SettingView()
                .tag(TabItemType.setting)
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }
        .accentColor(.black)
        .environmentObject(coordinator)
    }
    
}

