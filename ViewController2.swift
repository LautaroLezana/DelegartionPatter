//
//  ViewController2.swift
//  UIkit13-DelegationPatter
//
//  Created by Lautaro matias Lezana luna on 23/11/2022.
//

import UIKit

class ViewController2: UIViewController {
    deinit {
        print("Deinit ViewController 2")
    }
    
    let apiClient = APIClient()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "placeholder"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var acceptButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Show me again Response Data Model"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
            self?.didTapOneAcceptButton()
        }))
        
        button.configuration =  configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(acceptButton)
        view.addSubview(nameLabel)
        
        view.backgroundColor = .systemPink
        
        apiClient.delegate = self
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: acceptButton.topAnchor, constant: -32),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            acceptButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func didTapOneAcceptButton() {
        apiClient.getPokemon()
    }

}

extension ViewController2: APIClientDelegate {
    func update(pokemons: PokemonResponseDataModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemons.pokemons.randomElement()?.name
        }
    }
    
    
}

