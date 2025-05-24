//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import Foundation
import CryptoKit

// MARK: - MarvelAPIClient: comunica com a Marvel API

class MarvelAPIClient {
    private let publicKey = "dd6521ba5f4561c240ace0c262b8c59a"
    private let privateKey = "a647e9214db3b4626746b40d941c88236bb91ad6"
    private let baseURL = "https://gateway.marvel.com/v1/public"

    func request<T: Decodable>(
        endpoint: String,
        queryItems: [URLQueryItem] = [],
        responseType: T.Type
    ) async throws -> T {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = generateHash(ts: ts)

        var components = URLComponents(string: "\(baseURL)/\(endpoint)")!
        components.queryItems = queryItems + [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)// Exemplo: pega 10 personagens
        ]
        
        guard let url = components.url else {
             throw URLError(.badURL)
         }

        print("🔗 URL Final: \(url)")

         var request = URLRequest(url: url)
         request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8) ?? "Resposta vazia")
        return try JSONDecoder().decode(responseType, from: data)
    }

    private func generateHash(ts: String) -> String {
        let toHash = ts + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: Data(toHash.utf8))
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

