//
//  FavoriteListController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 28/06/22.
//

import UIKit
import CoreData

class FavoriteCollectionController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var favoritePokemons = [PokemonDetailsModel]()

    override func viewDidLoad() {
        configureViewComponents()
        loadFavList()
    }
   
    // MARK: - Collection data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCardViewCell.identifier, for: indexPath) as! PokemonCardViewCell
        cell.nameLabel.text = favoritePokemons[indexPath.row].name?.capitalized
        if let imageString = favoritePokemons[indexPath.row].pokeImageString{
            if let imageData = Data(base64Encoded: imageString){
                if let image = UIImage(data: imageData){
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
}
//MARK: - Core Data

extension FavoriteCollectionController{
    
    func loadFavList(with request:NSFetchRequest<PokemonDetailsModel> = PokemonDetailsModel.fetchRequest()){
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do{
            favoritePokemons = try context.fetch(request)
        }catch{
            print(error)
        }
        collectionView.reloadData()
    }
}
//MARK: - Configure
extension FavoriteCollectionController{
        
        func configureViewComponents(){
            navigationController?.navigationBar.barStyle = .black
            navigationItem.title = "Favorites"
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = K.mainColor()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            collectionView.register(PokemonCardViewCell.self, forCellWithReuseIdentifier: PokemonCardViewCell.identifier)
        }
}
extension FavoriteCollectionController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
}
