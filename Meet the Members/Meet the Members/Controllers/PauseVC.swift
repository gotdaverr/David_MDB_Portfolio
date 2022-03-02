//
//  PauseVC.swift
//  Meet the Members
//
//  Created by David Ko on 2/27/22.
//

import UIKit


class PauseVC: UIViewController {
    
    let resumeButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Resume", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.blue.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white // == UIColor(expected type).white
    
        view.addSubview(resumeButton)
        
        NSLayoutConstraint.activate([
            resumeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),

            // For your understanding, here's what it's saying:
            //     welcomeLabel.leadingAnchor = view.leadingAnchor + 50
            resumeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            //     welcomeLabel.trailingAnchor = view.trailingAnchor - 50
            resumeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}
    
