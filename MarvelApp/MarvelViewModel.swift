//
//  ViewModel.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import Foundation

// MARK: - CharacterViewModel: busca os dados da API

@MainActor
class CharacterViewModel {
    private var offset = 0
    private let limit = 10
    private(set) var characters: [MarvelCharacter] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let apiClient = MarvelAPIClient()

    func fetchCharacters() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: MarvelAPIResponse = try await apiClient.request(
                endpoint: "characters",
                queryItems: [URLQueryItem(name: "limit", value: "10")],
                responseType: MarvelAPIResponse.self
            )
            
            characters = response.data.results

            let characters = response.data.results
            for character in characters {
                print("🦸‍♂️ \(character.name) - \(character.description)")
            }
        } catch {
            errorMessage = "Erro ao carregar personagens: \(error.localizedDescription)"
            print("Erro ao buscar personagens: \(error)")
        }
        
        isLoading = false
    }
}
