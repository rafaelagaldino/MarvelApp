//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Rafaela Torres Alves Ribeiro Galdino on 24/05/25.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"

    private let thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.label // dinâmico
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.secondaryLabel // dinâmico
//        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()

    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground // dinâmico

        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(descriptionLabel)

        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 60),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 60),

            verticalStack.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            verticalStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with character: MarvelCharacter) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description.isEmpty ? "Sem descrição" : character.description
        
        if let url = character.thumbnail.url {
            if url.scheme == "http" {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.scheme = "https"
                if let httpsURL = components?.url {
                    loadImage(from: httpsURL)
                }
            } else {
                loadImage(from: url)
            }
        }
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data else { return }
            DispatchQueue.main.async {
                self.thumbnailImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
