//
//  Convenience.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/15.
//

import SwiftUI


struct AlertProvider: Identifiable {
    let id = UUID()
    let alert: Alert
    static func make(title: String = "", msg: String = "") -> AlertProvider {
        .init(alert: .init(title: Text(title), message: Text(msg), dismissButton: .default(Text("확인"))))
    }
}
