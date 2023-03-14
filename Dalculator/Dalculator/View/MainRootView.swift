//
//  MainRootView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

struct MainRootView: View {
    
    typealias TabItemType = Constants.HomeTabItem
    
    @State private var tabSelection: TabItemType = .home
    
    var body: some View {
        TabView(selection: $tabSelection) {
            HomeMenuView()
                .tag(TabItemType.home)
                .tabItem {
                    Label("홈", systemImage: "house.fill")
                }
            
            SettingView()
                .tag(TabItemType.setting)
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }.accentColor(.black)
    }
    
}

