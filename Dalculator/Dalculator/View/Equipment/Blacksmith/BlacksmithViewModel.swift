//
//  BlacksmithViewModel.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/05/25.
//

import Foundation

import DalculatorResources

@MainActor
final class BlacksmithViewModel: ObservableObject, Identifiable {
    
    @Published var alertItem: AlertProvider?
    
    var taskStorage: Set<Task<Void,Never>> = []
    
}
