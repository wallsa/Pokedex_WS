//
//  FavoriteCell.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 29/06/22.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    
    @IBOutlet weak var favCellView: UIView!
    
    @IBOutlet weak var favPokemonImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favCellView.backgroundColor = K.mainColor()
        favCellView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
