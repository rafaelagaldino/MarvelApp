//
//  MarvelModel.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import Foundation

struct MarvelAPIResponse: Codable {
    let data: MarvelData
}

struct MarvelData: Codable {
    let results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: MarvelThumbnail
}

struct MarvelThumbnail: Codable {
    let path: String
    let `extension`: String

    var url: URL? {
        return URL(string: "\(path).\(self.extension)")
    }
}
