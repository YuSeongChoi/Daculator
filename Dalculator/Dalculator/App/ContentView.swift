//
//  ContentView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            MainRootView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
    }
    
}
