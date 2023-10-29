//
//  ViewController.swift
//  UIkit13-DelegationPatter
//
//  Created by Lautaro matias Lezana luna on 22/11/2022.
//

import UIKit

class ViewController: UIViewController {
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
        configuration.title = "Response Data Model"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
            self?.didTapOneAcceptButton()
        }))
        
        button.configuration =  configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var presentViewController2: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Present ViewController 2!"
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in
            self?.didTapOnPresentViewController2Button()
        }))
        
        button.configuration =  configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(acceptButton)
        view.addSubview(nameLabel)
        view.addSubview(presentViewController2)
        
        apiClient.delegate = self
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: acceptButton.topAnchor, constant: -32),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            acceptButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            presentViewController2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentViewController2.centerYAnchor.constraint(equalTo: acceptButton.bottomAnchor, constant: 32),
        ])
    }
    
    func didTapOneAcceptButton() {
        apiClient.getPokemon()
    }
    
    func didTapOnPresentViewController2Button() {
        present(ViewController2(),
                animated: true)
    }

}

extension ViewController: APIClientDelegate {
    func update(pokemons: PokemonResponseDataModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemons.pokemons.randomElement()?.name
        }
    }
    
    
}

