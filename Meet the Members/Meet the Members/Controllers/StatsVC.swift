//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
    let dataExample: String
    let correctScore: Int
    let incorrectScore: Int
    let longestStreak: Int
    
    //let dictionary: Dictionary
    
    init(data: String, correct: Int, incorrect: Int, longestStreak: Int) {
        self.dataExample = data
        self.correctScore = correct
        self.incorrectScore = incorrect
        self.longestStreak = longestStreak
        // Delegate rest of the initialization to super class
        // designated initializer.
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints
    
    let resultsLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.textColor = UIColor.blue
        resultLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    let streakLabel: UILabel = {
        let streakLabel = UILabel()
        streakLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        streakLabel.textColor = UIColor.blue
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        return streakLabel
    }()
    
    let backsButton: UIButton = {
        let backButton = UIButton()
        backButton.backgroundColor = .clear 

        backButton.backgroundColor = .clear
        backButton.setTitle("Back to Game", for: .normal)
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.blue.cgColor
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
        
    }()
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // MARK: >> Your Code Here <<
        
        view.backgroundColor = .white
        view.addSubview(resultsLabel)
        
        resultsLabel.text = "Correct: \(correctScore)" + "                 Incorrect: \(incorrectScore)"
        NSLayoutConstraint.activate([
            resultsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            resultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            resultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        view.addSubview(streakLabel)
        streakLabel.text = "Longest Streak: \(longestStreak)"
        NSLayoutConstraint.activate([
            streakLabel.topAnchor.constraint(equalTo: resultsLabel.topAnchor, constant: 150),
            streakLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            streakLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        view.addSubview(backsButton)
        NSLayoutConstraint.activate([
            backsButton.topAnchor.constraint(equalTo: streakLabel.topAnchor, constant: 150),
            backsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            backsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        backsButton.addAction(UIAction(handler: {action in self.tapBackHandler(action)}), for: .touchUpInside)

    
    }
    
    
    @objc func tapBackHandler(_ action: UIAction) {
        let vc = MainVC()
        vc.modalPresentationStyle = .fullScreen
//        vc.viewDidLoad()
//        vc.viewWillAppear(true)
        present(vc, animated: true, completion: nil)
    }
}
