//
//  PokemonDetailsViewController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 26/06/22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var pokemon = PokemonDetailsModel()
    
    var selectedPokemon:String?{
        didSet{
            guard let choosenPokemon = selectedPokemon else {return}
            Service.shared.fetchPokemonDetails(urlString: choosenPokemon) { pokemon in
                self.pokemon = pokemon
                DispatchQueue.main.async {
                    if let nome = pokemon.name {
                        self.nameLabel.text = nome.capitalized
                    }
                    if let id = pokemon.id{
                        let idString = String(format: "%d", id)
                        self.idLabel.text = idString
                    }
                    if let type = pokemon.element{
                        self.typeLabel.text = type.capitalized
                    }
                    if let image = pokemon.pokeImg{
                        self.pokemonImage.image = image
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
    }
    
    
    @IBAction func favoritePressed(_ sender: UIButton) {
        pokemon.favorite = true
        favoriteButton.isSelected.toggle()
        
    }
    
}








//MARK: - Configure

extension PokemonDetailsViewController{
    func configureViewComponents(){
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Pokedex"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = K.mainColor()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem?.customView?.isHidden = true
        viewBackground.layer.cornerRadius = 10
        let image = UIImage(systemName: "star")
        let imageFilled = UIImage(systemName: "star.fill")
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.setImage(imageFilled, for: .selected)
        
    }
    
}
