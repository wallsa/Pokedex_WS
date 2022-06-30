//
//  PokemonCell.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 25/06/22.
//

import UIKit

class PokemonCell: UITableViewCell {
    static let identifier = "PokemonCell"
    
    lazy var nameContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureComponents()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureComponents(){
        self.clipsToBounds = true
        addSubview(nameContainerView)
        nameContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    
    }
    
    

}
