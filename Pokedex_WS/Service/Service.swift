//
//  Service.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import Foundation


class Service{
    let base_URL = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0"
    //Singleton
    static let shared = Service()
    
    func fetchPokemonList(completion: @escaping ([PokemonListModel]) ->()){
        var pokemonArray = [PokemonListModel]()
        guard let url = URL(string: base_URL) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data \(error.localizedDescription)")
            }
            guard let data = data else {return}
            guard let pokemon = self.parseJSON(data) else{return}
            for pokemon in pokemon.results {
                let pokemonModel = PokemonListModel(name: pokemon.name, url: pokemon.url)
                pokemonArray.append(pokemonModel)
            }
            completion(pokemonArray)
        }
        task.resume()
    }
    
    
    func parseJSON(_ pokemonData:Data) -> PokemonListData?{
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(PokemonListData.self, from: pokemonData)
            return decoderData
        }catch{
            print(error)
            return nil
        }
        
    }
}
