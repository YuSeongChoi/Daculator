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
    @Published var itemList: ItemVO = []
    
    func loadChampionList() {
        guard let data = FileLoader.load(file: R.file.dfclassJson.name) else { return }
        let result = FileLoader.decode(ChampionVO.self, data: data)
        switch result {
        case .success(let result):
            championList = result
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func loadItemList() {
        guard let data = FileLoader.load(file: R.file.itemsJson.name) else { return }
        let result = FileLoader.decode(ItemVO.self, data: data)
        switch result {
        case .success(let result):
            itemList = result
            print(itemList.map(\.setOf))
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
}
