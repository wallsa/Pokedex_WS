//
//  PokemonListData.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import Foundation

struct PokemonListData:Codable {
    let results:[PokemonAdress]
}
struct PokemonAdress:Codable {
    let name:String
    let url:String
}
