//
//  CharacterTableViewController.swift.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import UIKit

// MARK: - CharacterTableViewController: exibe os personagens

class CharacterTableViewController: UITableViewController {
    var characters: [MarvelCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personagens Marvel"
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.rowHeight = 80
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
         cell.configure(with: character)
         return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        print("🦸‍♂️ Selecionado: \(character.name)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
