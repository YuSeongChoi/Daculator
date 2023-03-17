//
//  SwiftUI+Resources.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

import RswiftResources

public extension ImageResource {
    var swiftImage: SwiftUI.Image {
        .init(self)
    }
}

public extension ColorResource {
    var swiftColor: SwiftUI.Color {
        .init(self)
    }
}

extension View {
    func clearModalBackground() -> some View {
        modifier(ClearBackgroundViewModifier())
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(SimpleViewRepresenter(view: { _ in
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
            }
            return view
        }))
    }
}

struct SimpleViewRepresenter<SimpleView: UIView>: UIViewRepresentable {
    typealias UIViewType = SimpleView
    
    let view: @MainActor (Context) -> SimpleView
    var update: @MainActor (SimpleView, Context) -> () = {_, _ in }
    
    func makeUIView(context: Context) -> SimpleView {
        view(context)
    }
    
    func updateUIView(_ uiView: SimpleView, context: Context) {
        update(uiView, context)
    }
}
