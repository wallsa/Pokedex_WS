//
//  Service.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import UIKit
import CoreData


class Service{
    let base_URL = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0"
    //Singleton
    static let shared = Service()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: - Fetch Pokemon List
    
    
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
                let pokemonModel = PokemonListModel(context: self.context)
                pokemonModel.name = pokemon.name
                pokemonModel.url = pokemon.url
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

//MARK: - Fetch Details of Pokemon
extension Service{
    
    func fetchPokemonDetails(urlString:String, completion: @escaping (PokemonDetailsModel) -> ()){
        var pokemon = PokemonDetailsModel(name: "", id: 0, imgURL: "", element: "")
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch data \(error.localizedDescription)")
            }
            guard let data = data else {return}
            guard let pokemonDetails = self.parseJSONDetails(data) else {return}
            pokemon = pokemonDetails
            guard let url = pokemon.imgURL else {return}
            self.fetchImage(with: url) { image in
                pokemon.pokeImg = image
                completion(pokemon)
            }
        
        }
        task.resume()
    }
    func parseJSONDetails(_ pokemonDetails:Data) -> PokemonDetailsModel?{
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(PokemonDetailsData.self, from: pokemonDetails)
            let pokemonDetails = PokemonDetailsModel(name: decoderData.name, id: decoderData.id, imgURL: decoderData.sprites.front_default, element: decoderData.types[0].type.name)
            return pokemonDetails
        }catch{
            print(error)
            return nil
        }
    }
    
    
//MARK: - Getting Image
    private func fetchImage(with url:String, completion: @escaping(UIImage) ->()){
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch pokemon Image\(error)")
            }
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            completion(image)
        }.resume()
    }
    
    func save(){
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}
