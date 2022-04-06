//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(imageAndTitleCell.self, forCellWithReuseIdentifier: imageAndTitleCell.imageIdentifier)
        
    
        return collectionView
        
    }()
    
    let pokeSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "Search Pokemon"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = .blue
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        searchBarConstraints()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    func searchBarConstraints() {
        view.addSubview(pokeSearchBar)
        NSLayoutConstraint.activate(
            [pokeSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100), pokeSearchBar.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor, constant: 50), pokeSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)])
        
    }
}
            

extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count // number of cells trying to display in collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemon = pokemons[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:imageAndTitleCell.imageIdentifier, for: indexPath) as! imageAndTitleCell
        //cell.imageView = pokemon.
        return cell
    }

}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let symbol = pokemons[indexPath.item] //item is the index of the flow layout array

        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return imageAndTitleCell()
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let pokemonGen = PokemonGenerator()
        let arrayPokemon = pokemons[indexPath.item]
        //code below makes it so that runtime for the items that are in the collection is easy to run -->
        //let cell = collectionView.dequeueConfiguredReusableCell(using: withRes, for: <#T##IndexPath#>, item: <#T##Item?#>)
        print("Selected \(arrayPokemon.name)")
    }
}

class imageAndTitleCell: UICollectionViewCell {
    static let imageIdentifier = "ImageCell"
    
     var imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    var titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        imageView.frame = contentView.bounds
        titleView.frame = contentView.bounds
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


        
        
        

