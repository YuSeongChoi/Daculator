//
//  EquipmentViewModel.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

import RswiftResources

@MainActor
final class EquipmentViewModel: ObservableObject, Identifiable {
    
    @Published var championList: ChampionVO = []
    
    func loadChampionName(fileName: String) {
        guard let data = FileLoader.load(file: fileName) else { return }
        let result = FileLoader.decode(ChampionVO.self, data: data)
        switch result {
        case .success(let result):
            championList = result
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    
    
}
