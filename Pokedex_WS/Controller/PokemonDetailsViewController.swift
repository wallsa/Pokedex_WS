//
//  PokemonDetailsViewController.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 26/06/22.
//

import UIKit
import CoreData

class PokemonDetailsViewController: UIViewController {
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
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
                        self.idLabel.text = id
                    }
                    if let type = pokemon.element{
                        self.typeLabel.text = type.capitalized
                    }
                    if let imageString = pokemon.pokeImageString{
                        guard let decodedData = Data(base64Encoded: imageString) else {return}
                        guard let image = UIImage(data: decodedData) else {return}
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
        
        save()
        
        
        
        
        
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
    
//MARK: - Core Data
    
    func save(){
       
        do{
            try context.save()
            print("saving fav pokemon")
        }catch{
            print(error)
        }
    }
//    func loadList(with request:NSFetchRequest<PokemonListModel> = PokemonListModel.fetchRequest()){
//        do{
//            pokemons = try context.fetch(request)
//        }catch{
//            print(error)
//        }
//        tableView.reloadData()
//    }

//    func testForDuplicates(id:String){
//        let request:NSFetchRequest<PokemonDetailsModel> = PokemonDetailsModel.fetchRequest()
//        request.predicate = NSPredicate(format: "id CONTAINS[cd] %@", id)
//        do{
//            let fetchResult = try context.fetch(request)
//            if fetchResult.count > 0{
//                for doubleData in fetchResult{
//                    context.delete(doubleData)
//                }
//            } else {
//
//
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    func isEntityAttributeExist(id: NSManagedObjectID, entityName: String) -> Bool {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//        let res = try! managedContext.fetch(fetchRequest)
//        return res.count > 0 ? true : false
//    }
    
}
