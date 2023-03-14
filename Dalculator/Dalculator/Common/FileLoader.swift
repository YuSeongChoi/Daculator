//
//  FileLoader.swift
//  Dalculator
//
//  Created by YuSeongChoi on 2023/03/14.
//

import Foundation

import RswiftResources

final class FileLoader {
    
    static func load(file fileName: String) -> Data? {
        do {
            guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
            return try Data(contentsOf: fileLocation)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func decode<T: Decodable>(_ type: T.Type, data: Data) -> Result<T, Error> {
        return Result { try JSONDecoder().decode(T.self, from: data) }
    }
    
}
