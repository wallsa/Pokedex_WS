//
//  PokemonDetailsData.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 26/06/22.
//

import Foundation

struct PokemonDetailsData:Codable {
    let id:Int
    let name:String
    let sprites:Sprites
    let types:[Types]
    
}

struct Sprites:Codable {
    let front_default:String
}

struct Types:Codable {
    let type:type
}

struct type:Codable{
    let name:String
}
