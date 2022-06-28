//
//  ViewController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import UIKit
import CoreData

class PokemonListViewController: UITableViewController {
    
    var pokemons = [PokemonListModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        //Se há conexão, solicitamos a API, se nao, carregamos o CoreData
        if Reachability.isConnectedToNetwork(){
            fetchPokemon()
        }else{
            loadList()
        }
        
        
    }
    
//MARK: - API
    func fetchPokemon(){
        Service.shared.fetchPokemonList { pokemon in
            self.pokemons = pokemon
            self.save()
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
        performSegue(withIdentifier: K.pokeDetailsSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PokemonDetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        guard let urlSelected = pokemons[indexPath.row].url else {return}
        destinationVC.selectedPokemon = urlSelected
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
    
//MARK: - Core Data
    
        func save(){
            
            do{
                try context.save()
                print("saving")
            }catch{
                print(error)
            }
        }
    func loadList(with request:NSFetchRequest<PokemonListModel> = PokemonListModel.fetchRequest()){
        do{
            pokemons = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    
        
}

