//
//  FeedVC.swift
//  MDB Social
//
//  Created by Michael Lin on 10/17/21.
//

import UIKit
import SwiftUI

class FeedVC: UIViewController {
    
    var events: [Event] = []
    private let signOutButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.backgroundColor = .primary
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30, weight: .medium))
        btn.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 50
        
        return btn
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.register(SFSCollectionCell.self, forCellWithReuseIdentifier: SFSCollectionCell.reuseIdentifier) //allows for multiple cell designs --> want to register the SFCollectionCelll --> without register, the UI collection view has no knowledge of the cell we are going to use --> register makes it so that we know what type of cell is in the collection view
        //reuseIdentifier allows you to reuse cells
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        view.addSubview(signOutButton)
        events = DatabaseRequest.shared.eventGet(vc: self)
//        signOutButton.center = view.center
//        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
        
        
    }
    
    @objc func didTapSignOut(_ sender: UIButton) {
        AuthManager.shared.signOut { [weak self] in
            guard let self = self else { return }
            guard let window = self.view.window else { return }
            
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
}

    
    

extension FeedVC: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = events[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.reuseIdentifier, for: indexPath) as! EventCollectionCell
        return cell
        
    }
    

    
}

extension FeedVC: UICollectionViewDelegateFlowLayout {
    

}

