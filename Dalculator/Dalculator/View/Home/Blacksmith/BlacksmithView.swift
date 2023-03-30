//
//  BlacksmithView.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

struct BlacksmithView: View {
    
    @ObservedObject var viewModel: EquipmentViewModel
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                R.image.bg.swiftImage
                    .resizable()
                
                VStack(spacing: 20) {
                    HStack(spacing: 5) {
                        
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func itemImage(imageName: String, itemType: ItemType) -> some View {
        Button {
            
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
