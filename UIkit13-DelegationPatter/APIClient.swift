//
//  APIClient.swift
//  UIkit13-DelegationPatter
//
//  Created by Lautaro matias Lezana luna on 22/11/2022.
//

import Foundation

struct PokemonDataModel: Decodable {
    let name: String
    let url: String
}

struct PokemonResponseDataModel: Decodable {
    let pokemons: [PokemonDataModel]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pokemons = try container.decode([PokemonDataModel].self, forKey: .results)
    }
}

protocol APIClientDelegate: AnyObject {
    func update(pokemons: PokemonResponseDataModel)
}

class APIClient {
    weak var delegate: APIClientDelegate?
    
    func getPokemon() {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let dataModel = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data!)
            print("DataModel \(dataModel)")
            self.delegate?.update(pokemons: dataModel)
        }
        task.resume()
    }
}
