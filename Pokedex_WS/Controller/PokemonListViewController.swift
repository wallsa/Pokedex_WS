//
//  ViewController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import UIKit

class PokemonListViewController: UITableViewController {
    
    var pokemons = [PokemonListModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        fetchPokemon()
    }
    
//MARK: - API
    func fetchPokemon(){
        Service.shared.fetchPokemonList { pokemon in
            self.pokemons = pokemon
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - TableView Data Source


extension PokemonListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.pokeCell, for: indexPath) as! PokemonCell
        cell.nameLabel.text = pokemons[indexPath.row].name?.capitalized
        return cell
    }
}

//MARK: - TableView Delegate
extension PokemonListViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(pokemons[indexPath.row].name)
    }
}











//MARK: - Configure
extension PokemonListViewController{
        
        func configureViewComponents(){
            navigationController?.navigationBar.barStyle = .black
            navigationItem.title = "Pokedex"
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = K.mainColor()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
           
            
        }
}

