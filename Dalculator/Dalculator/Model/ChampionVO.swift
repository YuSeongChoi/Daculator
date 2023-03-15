//
//  ChampionVO.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

//   let championVO = try? JSONDecoder().decode(ChampionVO.self, from: jsonData)

typealias ChampionVO = [ChampionVOElement]
// MARK: - ChampionVOElement
struct ChampionVOElement: Codable, Hashable {    
    let name: String
    let atype: Atype
    let weapons: [String]
    let attrs: Attrs?
    
    enum Atype: String, Codable {
        case magic = "Magic"
        case physc = "Physc"
    }
}

// MARK: - Attrs
struct Attrs: Codable, Hashable {
    let eltype: Element?
    let dualTrigger: Bool?

    enum CodingKeys: String, CodingKey {
        case eltype
        case dualTrigger = "DualTrigger"
    }
    
    enum Element: Codable, Hashable {
        case string(String)
        case stringArray([String])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .stringArray(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            throw DecodingError.typeMismatch(Element.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Element"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let x):
                try container.encode(x)
            case .stringArray(let x):
                try container.encode(x)
            }
        }
    }
}
