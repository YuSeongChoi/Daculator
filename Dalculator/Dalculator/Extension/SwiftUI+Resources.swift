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
