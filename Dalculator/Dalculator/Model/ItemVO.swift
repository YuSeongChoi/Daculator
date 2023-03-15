//
//  ItemVO.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

typealias ItemVO = [ItemVOElement]

// MARK: - ChampionVOElement
struct ItemVOElement: Codable, Hashable {
    let name: String
    let level: Int?
    let rarity: Rarity?
    let itype: String
    let setOf: SetOfUnion?
    let attrs: ChampionVOAttrs
    let id: Int
    let image: String
    let branch: [Branch]?
    let gives: [Give]?
    let exclusive: [Exclusive]?
    let content: Content?
    let who: [Who]?
    let material: String?
    let part: [Part]?
    let artiColor: String?

    enum CodingKeys: String, CodingKey {
        case name, level, rarity, itype, setOf, attrs, id, image, branch, gives, exclusive, content, who, material, part
        case artiColor = "ArtiColor"
    }
    
    enum Rarity: String, Codable {
        case epic = "Epic"
        case rare = "Rare"
        case uncommon = "Uncommon"
        case unique = "Unique"
    }
    
    enum Content: String, Codable {
        case 솔라리스 = "솔라리스"
        case 오즈마 = "오즈마"
        case 환영극단2막 = "환영극단 2막"
    }
    
    enum Who: String, Codable {
        case 윈드시어 = "윈드시어"
    }
    
    enum Part: String, Codable {
        case 머리어깨 = "머리어깨"
        case 목걸이 = "목걸이"
        case 무기 = "무기"
        case 반지 = "반지"
        case 벨트 = "벨트"
        case 보조장비 = "보조장비"
        case 상의 = "상의"
        case 신발 = "신발"
        case 칭호 = "칭호"
        case 팔찌 = "팔찌"
        case 하의 = "하의"
    }
    
    enum SetOfUnion: Codable, Hashable {
        case enumeration(SetOfEnum)
        case stringArray([String])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode([String].self) {
                self = .stringArray(x)
                return
            }
            if let x = try? container.decode(SetOfEnum.self) {
                self = .enumeration(x)
                return
            }
            throw DecodingError.typeMismatch(SetOfUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SetOfUnion"))
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .enumeration(let x):
                try container.encode(x)
            case .stringArray(let x):
                try container.encode(x)
            }
        }
        
        enum SetOfEnum: String, Codable {
            case all = "all"
        }
    }
}

// MARK: - ChampionVOAttrs
struct ChampionVOAttrs: Codable, Hashable {
    let atkPh, atkMg, strInc, intInc: Int?
    let strn, intl: Int?
    let speedCast: Double?
    let critMgPct, accu: Int?
    let misc: [String]?
    let dmgInc, dmgAdd, defPh, defMg: Int?
    let accuPct, critPhPct, vit: Int?
    let speedAtk: Double?
    let eltype: Elementtype?
    let elLght, elFire, elIce, elDark: Int?
    let resFire, atkPhInc, atkMgInc, psi: Int?
    let skLV, skbAdd: [String: Int]?
    let critPh, cdmgInc, critMg, hpmax: Int?
    let mpmax: Int?
    let speedMove: Double?
    let resIce, defPhPct, defMgPct, eldmgFire: Int?
    let eldmgIce, skInc: Int?
    let skHit: [String: Int]?
    let skCool: SkCool?
    let skVal: [String: Int]?
    let resLght, resDark, eldmgLght, targetDef: Int?
    let eldmgDark: Int?

    enum CodingKeys: String, CodingKey {
        case atkPh = "atk_ph"
        case atkMg = "atk_mg"
        case strInc = "str_inc"
        case intInc = "int_inc"
        case strn, intl
        case speedCast = "speed_cast"
        case critMgPct = "crit_mg_pct"
        case accu = "Accu"
        case misc
        case dmgInc = "dmg_inc"
        case dmgAdd = "dmg_add"
        case defPh = "def_ph"
        case defMg = "def_mg"
        case accuPct = "AccuPct"
        case critPhPct = "crit_ph_pct"
        case vit
        case speedAtk = "speed_atk"
        case eltype
        case elLght = "el_lght"
        case elFire = "el_fire"
        case elIce = "el_ice"
        case elDark = "el_dark"
        case resFire = "res_fire"
        case atkPhInc = "atk_ph_inc"
        case atkMgInc = "atk_mg_inc"
        case psi
        case skLV = "sk_lv"
        case skbAdd = "skb_add"
        case critPh = "crit_ph"
        case cdmgInc = "cdmg_inc"
        case critMg = "crit_mg"
        case hpmax, mpmax
        case speedMove = "speed_move"
        case resIce = "res_ice"
        case defPhPct = "def_ph_pct"
        case defMgPct = "def_mg_pct"
        case eldmgFire = "eldmg_fire"
        case eldmgIce = "eldmg_ice"
        case skInc = "sk_inc"
        case skHit = "sk_hit"
        case skCool = "sk_cool"
        case skVal = "sk_val"
        case resLght = "res_lght"
        case resDark = "res_dark"
        case eldmgLght = "eldmg_lght"
        case targetDef = "target_def"
        case eldmgDark = "eldmg_dark"
    }
    
    enum Elementtype: String, Codable {
        case dark = "Dark"
        case fire = "Fire"
        case ice = "Ice"
        case light = "Light"
    }
}

// MARK: - SkCool
struct SkCool: Codable, Hashable {
    let all: Int
}

// MARK: - Branch
struct Branch: Codable, Hashable {
    let when: String
    let attrs: [String: Double]
    let maxRepeat: Int?
}

// MARK: - Exclusive
struct Exclusive: Codable, Hashable {
    let name: ExclusiveName
    let label: Label
    let children: [Child]
    
    enum ExclusiveName: String, Codable {
        case hp = "HP"
        case solaris = "Solaris"
    }
    
    enum Label: String, Codable {
        case the30초마다 = "30초마다"
        case 내HP가 = "내 HP가"
    }
}

// MARK: - Child
struct Child: Codable, Hashable {
    let name: ChildName
    let attrs: ChildAttrs
    
    enum ChildName: String, Codable {
        case the80미만 = "80% 미만"
        case the80이상 = "80% 이상"
        case 공격력15 = "공격력 +15%"
        case 모속강32 = "모속강 +32"
    }
}

// MARK: - ChildAttrs
struct ChildAttrs: Codable, Hashable {
    let dmgAdd, atkPhInc, atkMgInc, elFire: Int?
    let elIce, elLght, elDark: Int?

    enum CodingKeys: String, CodingKey {
        case dmgAdd = "dmg_add"
        case atkPhInc = "atk_ph_inc"
        case atkMgInc = "atk_mg_inc"
        case elFire = "el_fire"
        case elIce = "el_ice"
        case elLght = "el_lght"
        case elDark = "el_dark"
    }
}

// MARK: - Give
struct Give: Codable, Hashable {
    let attrs: [String: Int]
    let when: String?
}
