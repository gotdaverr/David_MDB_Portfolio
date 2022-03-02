//
//  SFSCollectionVC.swift
//  SFSCollectionVC
//
//  Created by Michael Lin on 9/26/21.
//

import UIKit

class SFSCollectionVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SFSCollectionCell.self, forCellWithReuseIdentifier: SFSCollectionCell.reuseIdentifier) //allows for multiple cell designs --> want to register the SFCollectionCelll --> without register, the UI collection view has no knowledge of the cell we are going to use --> register makes it so that we know what type of cell is in the collection view
        //reuseIdentifier allows you to reuse cells
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1B 1D 1F
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 88, left: 30, bottom: 0, right: 30))
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        //assigning self to be the data source (line below)
        collectionView.dataSource = self
        collectionView.delegate = self
        //to implement datasource delegate, use protocall conformance
    }
}

extension SFSCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SymbolProvider.symbols.count // number of cells trying to displayin collection view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let symbol = SymbolProvider.symbols[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SFSCollectionCell.reuseIdentifier, for: indexPath) as! SFSCollectionCell
        cell.symbol = symbol
        return cell
    }
}
//need to have the data source for the collection view --this is what this function below is for. protocal performance --> how many cells are there; how many views for each cell 
extension SFSCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let symbol = SymbolProvider.symbols[indexPath.item] //item is the index of the flow layout array
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return SFSPreviewVC(symbol: symbol)
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let symbol = SymbolProvider.symbols[indexPath.item]
        //code below makes it so that runtime for the items that are in the collection is easy to run -->
        //let cell = collectionView.dequeueConfiguredReusableCell(using: withRes, for: <#T##IndexPath#>, item: <#T##Item?#>)
        print("Selected \(symbol.name)")
    }
}
