//
//  MainVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    //var numCorrectDict: Dictionary<String, Int>?
    
    // MARK: STEP 7: UI Customization
    // Action Items:
    // - Customize your imageView and buttons.
    
    let imageView: UIImageView = {
        let view = UIImageView()
        // MARK: >> Your Code Here <<
        //view.layer.cornerRadius
        //view.layer.borderWidth = 1
        view.contentMode = .scaleAspectFit
        view.layer.borderColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let buttons: [UIButton] = {
        return (0..<4).map { index in
            let button = UIButton()
            //set all properteis of buttons in this closure
            //create global var -- keeps track of current question

            // Tag the button its index
            button.tag = index
            
            // MARK: >> Your Code Here <<
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            button.setTitleColor(.systemBlue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }
        
    }()
    
    // MARK: STEP 10: Stats Button
    // Action Items:
    // - Follow the examples you've seen so far, create and
    // configure a UIButton for presenting the StatsVC. Only the
    // callback function `didTapStats(_:)` was written for you.
    
    // MARK: >> Your Code Here <<
    
    let statsButton: UIButton = {
        let statButton = UIButton()
        statButton.setTitle("Stats", for: .normal)
        //statButton.addTarget(self, action: #selector(tapStatsHandler(_:)), for: .touchUpInside)
        statButton.backgroundColor = .clear
        //statButton.layer.cornerRadius = 1
        //statButton.layer.borderWidth = 0.5
        //statButton.layer.borderColor = UIColor.blue.cgColor
        statButton.setTitleColor(.systemBlue, for: .normal)
        statButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        statButton.translatesAutoresizingMaskIntoConstraints = false
        return statButton
    }()
    
    let pauseButtons: UIButton = {
        let pauseButton = UIButton()
       pauseButton.backgroundColor = .clear
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.setTitleColor(.systemBlue, for: .normal)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        return pauseButton
    }()
    
    let scoresLabel: UILabel = {
        let scoreLabel = UILabel()
    
        // == UIFont.systemFont(ofSize: 27, UIFont.weight.medium)
        scoreLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        scoreLabel.backgroundColor = .clear
        scoreLabel.text = "Score: 0" //  Incorrect: 0"
        scoreLabel.textColor = .systemBlue
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        return scoreLabel
        
    }()
    let resumeButtons: UIButton = {
        let resumeButton = UIButton()
       resumeButton.backgroundColor = .clear
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.setTitleColor(.systemBlue, for: .normal)
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        return resumeButton
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        // MARK: STEP 6: Adding Subviews and Constraints
        // Action Items:
        // - Add imageViews and buttons to the root view.
        // - Create and activate the layout constraints.
        // - Run the App
        // Additional Information:
        // If you don't like the default presentation style,
        // you can change it to full screen too! However, in this
        // case you will have to find a way to manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: >> Your Code Here <<
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            //imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 50),
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            //imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            //imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 30),
            // For your understanding, here's what it's saying:
            //     welcomeLabel.leadingAnchor = view.leadingAnchor + 50
            //imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            //imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 30),
            //     welcomeLabel.trailingAnchor = view.trailingAnchor - 50
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
        
        
        view.addSubview(buttons[0])
        
        NSLayoutConstraint.activate([
            buttons[0].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            buttons[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttons[0].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        view.addSubview(buttons[1])
        
        NSLayoutConstraint.activate([
            buttons[1].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 550),
            buttons[1].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttons[1].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        view.addSubview(buttons[2])
        
        NSLayoutConstraint.activate([

            buttons[2].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600),
            buttons[2].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttons[2].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
        view.addSubview(buttons[3])
        NSLayoutConstraint.activate([
        buttons[3].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 650),
        
        buttons[3].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        buttons[3].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
    ])
        
        view.addSubview(statsButton)
        
        NSLayoutConstraint.activate([
            statsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            statsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            statsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
        
        view.addSubview(pauseButtons)
        
        NSLayoutConstraint.activate([
            pauseButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pauseButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pauseButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
        ])
        view.addSubview(scoresLabel)
        NSLayoutConstraint.activate([
            scoresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scoresLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        ])
        view.addSubview(resumeButtons)
        NSLayoutConstraint.activate([
        resumeButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        resumeButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        resumeButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
        ])
        
        pauseButtons.isHidden = false
        pauseButtons.isEnabled = true
        resumeButtons.isEnabled = false
        resumeButtons.isHidden = true
    
        getNextQuestion()
        startTimer()
        
        // MARK: STEP 9: Bind Callbacks to the Buttons
        // Action Items:
        // - Bind the `didTapAnswer(_:)` function to the buttons.
        //startButton.addTarget(self, action: #selector(didTapStart(_:)), for: .touchUpInside)
        //Additional Information:
        // - The `addTarget` method will bind a function selector to the
        //   touchUpInside event. In English that means this function will
        //   be called when we tap the button.
        // - Notice the @objc decorator before the `didTapStart` function. We
        //   need this when we want to expose a method or property to objective-c
        //   runtime. Since selector is an objective-c only feature, we will
        //   need it here.
        //startButton.addTarget(self, action: #selector(didTapStart(_:)), for: .touchUpInside)
        for i in 0..<4 {
            buttons[i].addAction(UIAction(handler: {action in self.tapAnswerHandler(action)}), for: .touchUpInside)
        }
        statsButton.addAction(UIAction(handler: {action in self.tapStatsHandler(action)}), for: .touchUpInside)
        pauseButtons.addAction(UIAction(handler: {action in self.tapPauseHandler(action)}), for: .touchUpInside)
        resumeButtons.addAction(UIAction(handler: {action in self.tapResumeHandler(action)}), for: .touchUpInside)
    
        
        //viewWillAppear(true)

        // MARK: >> Your Code Here <<
        
        
        
        // MARK: STEP 10: Stats Button
        // See instructions above.
        
        // MARK: >> Your Code Here <<
            
        }

    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 13: Resume Game
        super.viewWillAppear(animated)
        //nameLabel.text = Roster.main.getNextName()
        // MARK: >> Your Code Here <<
    }
    

    var answerButton = UIButton()
    func getNextQuestion() {
        // MARK: STEP 5: Data Model
        // Action Items:
        // - Get a question instance from `QuestionProvider`
        // - Configure the imageView and buttons with information from
        //   the question instance
        
        // MARK: >> Your Code Here <<
        //var image: UIImage = UIImage()
        //var answer: String = ""
        //var choices: String
        let questionClass = QuestionProvider()
        let currentQuestion = questionClass.nextQuestion()
        if currentQuestion?.image != nil  {
            imageView.image = currentQuestion?.image
        }
        for x in 0..<4 {
            if currentQuestion?.choices[x] != nil {
                buttons[x].setTitle(currentQuestion!.choices[x], for: .normal)
                if buttons[x].currentTitle == currentQuestion?.answer {  //this code is here to isolate answer button
                answerButton = buttons[x]
                }
            }
        }
    }
//            if currentQuestion?.answer != nil {
//                currentQuestion?.answer = currentQuestion!.answer
//                buttons[x].setTitle(currentQuestion?.answer, for: .normal)
//


    


    
    
    
    // MARK: STEP 8: Buttons and Timer Callback
    // You don't have to
    // Action Items:
    // - Complete the callback function for the 4 buttons.
    // - Complete the callback function for the timer instance
    // - Call `startTimer()` where appropriate
    //
    // Additional Information:
    // Take some time to plan what should be in here.
    // The 4 buttons should share the same callback.
    //
    // Add instance properties and/or methods
    // to the class if necessary. You may need to come back
    // to this step later on.
    //
    // Hint:
    // - Checkout `UIControl.addAction(_:for:)`
    //      (`UIButton` subclasses `UIControl`)
    // - You can use `sender.tag` to identify which button is pressed.
    // - The timer will invoke the callback every one second.
    
    func startTimer() {
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }

//    let x : Int = 45
//    var stringValue = "\(x)"
//    print(stringValue)

    var scoreCorrect = 0
    var scoreIncorrect = 0
    var longestStreak = 0
    var scoreString = "Correct: 0" //Incorrect: 0"
    func CorrectScore() {
        longestStreak+=1
        return scoreCorrect+=1
    }
    func IncorrectScore() {
        longestStreak = 0
        return scoreIncorrect+=1
    }
    func changeScoreLabel() {
        //scoreString = "Correct: x  Incorrect: x"
        scoreString = "Score: \(scoreCorrect)" //+ " Incorrect: \(scoreIncorrect)"
        scoresLabel.text = scoreString
        //scoreString.replacingOccurrences(of: "x", with: scoreCorrect, options: .literal, range: nil)
    }
    
//    var numCorrectDict: [String: Int] = ["Correct": 0, "Incorrect": 0]
//
//    func scoreCorrect() {
//        numCorrectDict["Correct"]? =  numCorrectDict["Correct"]! + 1
//    }
//    func scoreIncorrect() {
//        numCorrectDict["Incorrect"]? = numCorrectDict["Incorrect"]! + 1
//    }
//
//    func changeScoreLabel() {
//        for (_, int) in numCorrectDict {
//            scoresLabel.text = "Correct: \(int)  Incorrect: \(int)"
//        }
//    }
    var seconds = 0
    var buttonWasTapped = false
    //var fiveSecPassed = false
    @objc func timerCallback() {
        seconds += 1
        if buttonWasTapped == true {
            //handle case where its been two seconds and need to get next question
            if seconds == 3 {
                // need to move onto next question after 2 sec
                getNextQuestion()
                hideAnswer()
                seconds = 0
                buttonWasTapped = false
            }
            else {
                //Thread.sleep(forTimeInterval: 3)
                displayAnswer()
                }

            }
        if seconds == 6 && buttonWasTapped == false {
            //timer?.invalidate() //terminate timer once 5 sec passes
            displayAnswer()
            //scoreIncorrect()
            IncorrectScore()
            changeScoreLabel()
            //seconds = 0 //reset timer
            //getNextQuestion()
            //question is marked as incorrect
        }
        if seconds == 10 && buttonWasTapped == false {
            getNextQuestion()
            hideAnswer()
            seconds = 0
        }
}
    func displayAnswer()  {
        for i in 0..<4 {
            buttons[i].layer.borderColor = UIColor.red.cgColor //display answer
            answerButton.layer.borderColor = UIColor.green.cgColor
        }
    }
    func hideAnswer() {
        for i in 0..<4 {
            buttons[i].layer.borderColor = UIColor.blue.cgColor
        }
    }
    // need an example of how UIAction works
    //the action holds the information of who pressed the button, when it was pressed, etc)
    //this is passed in, and my job here is to correctly bind what button is used
    //when user presses a button, this function gets called
    //if user presses button, then start 2 sec timer

    var correct = false
    func tapAnswerHandler(_ action: UIAction) {
        // MARK: >> Your Code Here <<
        buttonWasTapped = true
//        for i in 0..<4 {
        let button = action.sender as! UIButton //gets the button that was pressed by user and casts it as UI button so we can compare the button ID and see if it matches the correct answer
        if button.tag == answerButton.tag {
            displayAnswer()
            //correct = true
            //break
            //scoreCorrect()
            CorrectScore()
            changeScoreLabel()
            
//            if buttons[i].tag == button.tag {
//                //window that shows the answer is correct (green outline)
//                displayAnswer()
//                correct = true
//                //break
//                //scoreCorrect()
//                //changeScoreLabel()
            }
            else {
                displayAnswer()
                //correct = false
                //scoreIncorrect()
                IncorrectScore()
                changeScoreLabel()
                //window that shows answer is wrong (red outline)
            }
//        if correct == true {
//
//            scoreCorrect()
//            changeScoreLabel()
//        }
//        if correct == false {
//
//
//        }
        seconds = 0
    }
            //seconds = 0
        

    

    
    @objc func tapStatsHandler(_ action: UIAction) {
        
        let vc = StatsVC(data: "Hello", correct:scoreCorrect, incorrect: scoreIncorrect, longestStreak: longestStreak) //add more parameters in order to transwer info from one
        
        vc.modalPresentationStyle = .fullScreen
        timer?.invalidate()
        // MARK: STEP 11: Going to StatsVC
        // When we are navigating between VCs (e.g MainVC -> StatsVC),
        // we often need a mechanism for transferring data
        // between view controllers. There are many ways to achieve
        // this (initializer, delegate, notification center,
        // combined, etc.). We will start with the easiest one today,
        // which is custom initializer.
        //
        // Action Items:
        // - Pause the game when stats button is tapped i.e. stop the timer
        // - Read the example in StatsVC.swift, and replace it with
        //   your custom init for `StatsVC`
        // - Update the call site here on line 139
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func tapPauseHandler(_ action: UIAction) {
        //let vc = PauseVC()
        //vc.modalPresentationStyle = .fullScreen
        //pauseButtons.delete(self)
        pauseButtons.isHidden = true
        pauseButtons.isEnabled = false
        resumeButtons.isEnabled = true
        resumeButtons.isHidden = false
//        view.addSubview(resumeButtons)
//        NSLayoutConstraint.activate([
//        resumeButtons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//        resumeButtons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//        resumeButtons.topAnchor.constraint(equalTo: view.topAnchor, constant: 700),
//    ])

        seconds = 0
        timer?.invalidate()
        
        
    }
    
    @objc func tapResumeHandler(_ action: UIAction) {
        pauseButtons.isHidden = false
        pauseButtons.isEnabled = true
        resumeButtons.isEnabled = false
        resumeButtons.isHidden = true
        seconds = 0
        scoreCorrect = 0
        scoreIncorrect = 0
        changeScoreLabel()
        startTimer()
        
        
    }
}
