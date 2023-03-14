//
//  ShapeStyle.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import SwiftUI

struct HorizontalUnderLineShape: Shape, Sendable {
    var height: CGFloat = 2
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addRect(.init(x: rect.origin.x, y: rect.maxY - (height / 2), width: rect.width, height: height))
        }
    }
}

