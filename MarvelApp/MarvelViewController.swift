//
//  MarvelViewController.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import UIKit

// MARK: - MarvelViewController: controla a tela principal
// Command (⌘) + Shift (⇧) + A -> Alterna entre modo claro e escuro
//🌕 Modo Claro: fundo branco, texto preto
//
//🌑 Modo Escuro: fundo preto, texto branco
//
//Tudo feito com .systemBackground, .label, .secondaryLabel que se adaptam automaticamente

class MarvelViewController: UIViewController {
    
    private let viewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Carregando..."
        
        getMarvel()
    }
    
    func getMarvel() {
        Task {
            await viewModel.fetchCharacters()
                        
            if let error = viewModel.errorMessage {
                print("❌ \(error)")
                showAlert(message: error)

            } else {
                showCharactersTable()
//                for character in viewModel.characters {
//                    print("🦸‍♀️ \(character.name)")
//                }
            }
        }
        
    }
    
    private func showCharactersTable() {
        let tableVC = CharacterTableViewController(style: .plain)
        tableVC.characters = viewModel.characters
        addChild(tableVC)
        tableVC.view.frame = view.bounds
        view.addSubview(tableVC.view)
        tableVC.didMove(toParent: self)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
