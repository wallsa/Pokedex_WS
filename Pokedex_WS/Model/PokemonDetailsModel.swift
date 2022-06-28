//
//  PokemonDetailsModel.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 26/06/22.
//

import UIKit

struct PokemonDetailsModel {
    var name:String?
    var id:Int? = 0
    var imgURL:String?
    var pokeImg:UIImage?
    var element:String?
    var favorite:Bool = false
    
    init(name:String, id:Int, imgURL:String, element:String){
        self.name = name
        self.id = id
        self.imgURL = imgURL
        self.element = element
    }
    init(){
    
    }
    
    
}
