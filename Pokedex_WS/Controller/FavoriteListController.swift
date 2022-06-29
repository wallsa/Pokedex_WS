//
//  FavoriteListController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 28/06/22.
//

import UIKit
import CoreData

class FavoriteListController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoritePokemons = [PokemonDetailsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.favCellIdentifier)
        loadFavList()
    }
   

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePokemons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.favCellIdentifier, for: indexPath) as! FavoriteCell
        cell.nameLabel.text = favoritePokemons[indexPath.row].name?.capitalized
        return cell
    }
    
}



//MARK: - Core Data

extension FavoriteListController{
    func loadFavList(with request:NSFetchRequest<PokemonDetailsModel> = PokemonDetailsModel.fetchRequest()){
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            favoritePokemons = try context.fetch(request)
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
}

//MARK: - Configure
extension FavoriteListController{
        
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
