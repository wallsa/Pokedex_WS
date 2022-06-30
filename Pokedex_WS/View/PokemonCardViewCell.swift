//
//  PokemonCardViewCell.swift
//  Pokedex_WS
//
//  Created by Wallace Santos on 29/06/22.
//

import UIKit

class PokemonCardViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCardCell"
    
    //MARK: - Cell Properties
        
        let imageView : UIImageView = {
          let imgV = UIImageView()
            imgV.backgroundColor = .systemGroupedBackground
            imgV.contentMode = .scaleAspectFit
            return imgV
        }()
        
        lazy var nameContainerView : UIView = {
            let view = UIView()
            view.backgroundColor = K.mainColor()
            view.addSubview(nameLabel)
            nameLabel.center(inView: view)
            return view
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        
        
        
        
        
        
        override init(frame: CGRect){
            super.init(frame: frame)
            configureComponents()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureComponents(){
            self.layer.cornerRadius = 10
            self.clipsToBounds = true
            addSubview(imageView)
            imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 32)
            addSubview(nameContainerView)
            nameContainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
            
        
        }
        
    }

