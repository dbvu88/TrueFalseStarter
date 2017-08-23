//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
    var selectedQuestions: [Int] = []
    
    var gameSound: SystemSoundID = 0
    
    /*
     let trivia: [[String : String]] = [
        ["Question": "Only female koalas can whistle", "Answer": "False"],
        ["Question": "Blue whales are technically whales", "Answer": "True"],
        ["Question": "Camels are cannibalistic", "Answer": "False"],
        ["Question": "All ducks are birds", "Answer": "True"]
    ]
    */
    
    @IBOutlet weak var responser: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstOptionButton: UIButton!
    @IBOutlet weak var secondOptionButton: UIButton!
    @IBOutlet weak var thirdOptionButton: UIButton!
    @IBOutlet weak var forthOptionButton: UIButton!

    
    @IBOutlet weak var playAgainButton: UIButton!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        
        while selectedQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        }
        selectedQuestions.append(indexOfSelectedQuestion)
        let quiz = trivia[indexOfSelectedQuestion]
        questionField.text = quiz.question
        
        //display option buttons
        firstOptionButton.setTitle(quiz.options[0], for: UIControlState.normal)
        secondOptionButton.setTitle(quiz.options[1], for: UIControlState.normal)
        thirdOptionButton.setTitle(quiz.options[2], for: UIControlState.normal)
        forthOptionButton.setTitle(quiz.options[3], for: UIControlState.normal)
        
        playAgainButton.isHidden = true
        responser.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstOptionButton.isHidden = true
        secondOptionButton.isHidden = true
        thirdOptionButton.isHidden = true
        forthOptionButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
//        firstOptionButton.titleLabel?.alpha = 0.5
//        secondOptionButton.titleLabel?.alpha = 0.5
//        thirdOptionButton.titleLabel?.alpha = 0.5
//        forthOptionButton.titleLabel?.alpha = 0.5
        firstOptionButton.isEnabled = false
        secondOptionButton.isEnabled = false
        thirdOptionButton.isEnabled = false
        forthOptionButton.isEnabled = false
        
        sender.isEnabled = true
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestion = trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestion.correctAnswer
        
        
        if (sender.currentTitle == correctAnswer) {
            responser.isHidden = false
            correctQuestions += 1
            responser.text = "Correct!"
            responser.textColor =  UIColor.cyan
        } else {
            responser.isHidden = false
            responser.text = "Sorry, wrong answer!"
            responser.textColor = UIColor.orange
        }
        
        
//        loadNextRoundWithDelay(seconds: 1)
    }
    
    func nextRound() {
        firstOptionButton.isHidden = false
        secondOptionButton.isHidden = false
        thirdOptionButton.isHidden = false
        forthOptionButton.isHidden = false
        
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
//        // Show the answer buttons
//        trueButton.isHidden = false
//        falseButton.isHidden = false
//        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}



