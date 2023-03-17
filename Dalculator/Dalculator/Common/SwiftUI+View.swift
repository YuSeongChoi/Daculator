//
//  SwiftUI+View.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/17.
//

import SwiftUI

import RswiftResources

struct FullScreenContentView<Content:View>: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var content: Content
    private let borderColor = R.color.veryLightPink.swiftColor
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Color.black.opacity(0.65)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    VStack {
                        content
                    }
                    .padding(EdgeInsets(top: 30, leading: 22, bottom: 30, trailing: 22))
                    .frame(width: geometry.size.width * (5/6), height: geometry.size.height * (2/3))
                    .background(Color.white)
                    .cornerRadius(12)
                }
            }
        }
        .background(Color.clear)
        .clearModalBackground()
        .ignoresSafeArea()
    }
    
}
