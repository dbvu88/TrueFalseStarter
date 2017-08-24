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
    // number of given questions per round
    let questionsPerRound = 4
    
    // number of questions had been asked
    var questionsAsked = 0
    
    // number of questions answered correctly also known as score
    var correctQuestions = 0
    
    // collection of questions had been selected randomly
    var indexOfSelectedQuestion: Int = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
    
    // current question ask
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

    
    @IBOutlet weak var nextAction: UIButton!

    @IBAction func getAction(_ sender: UIButton) {
        
        let action : String = sender.currentTitle!
        switch action
        {
        case "Next Question" : displayQuestion()
        case "See My Score" : displayScore()
        case "Play Again" : playAgain()
        default : displayQuestion()
        }
    }
    
    // hide status bar
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
    
    // display the current question
    func displayQuestion() {
        // show all options buttons
        firstOptionButton.isHidden = false
        secondOptionButton.isHidden = false
        thirdOptionButton.isHidden = false
        forthOptionButton.isHidden = false
        
        // enable all option buttons
        firstOptionButton.isEnabled = true
        secondOptionButton.isEnabled = true
        thirdOptionButton.isEnabled = true
        forthOptionButton.isEnabled = true
        
        // validate new question to avoid repeating question
        while selectedQuestions.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
        }
        
        // keep track of all asked questions
        selectedQuestions.append(indexOfSelectedQuestion)
        let quiz = trivia[indexOfSelectedQuestion]
        questionField.text = quiz.question
        
        //display option buttons
        firstOptionButton.setTitle(quiz.options[0], for: UIControlState.normal)
        secondOptionButton.setTitle(quiz.options[1], for: UIControlState.normal)
        thirdOptionButton.setTitle(quiz.options[2], for: UIControlState.normal)
        forthOptionButton.setTitle(quiz.options[3], for: UIControlState.normal)
        
        nextAction.isHidden = true
        responser.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstOptionButton.isHidden = true
        secondOptionButton.isHidden = true
        thirdOptionButton.isHidden = true
        forthOptionButton.isHidden = true
        
        // Hide the responser
        responser.isHidden = true
        
        // Display play again button
        nextAction.isHidden = false
        
        // Display score
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
        // Change next action button text to play again
        nextAction.setTitle("Play Again", for: UIControlState.normal)
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        firstOptionButton.isEnabled = false
        secondOptionButton.isEnabled = false
        thirdOptionButton.isEnabled = false
        forthOptionButton.isEnabled = false
        
        sender.isEnabled = true
        
        // Increment the questions asked counter
        questionsAsked += 1
        // Get the current question asked
        let selectedQuestion = trivia[indexOfSelectedQuestion]
        // Get the correct answer of last question asked
        let correctAnswer = selectedQuestion.correctAnswer
        
        // Check if selected option match the correct answer
        if (sender.currentTitle == correctAnswer) {
            // Correct Answer
            responser.isHidden = false
            correctQuestions += 1
            responser.text = "Correct!"
            responser.textColor =  UIColor.cyan
        } else {
            // Wrong Answer
            responser.isHidden = false
            responser.text = "Sorry, wrong answer!"
            responser.textColor = UIColor.orange
        }

        if questionsAsked == questionsPerRound {
            // Game is over
            nextAction.isHidden = false
            nextAction.setTitle("See My Score", for: UIControlState.normal)
        } else {
            // Continue game
            nextAction.isHidden = false
            nextAction.setTitle("Next Question", for: UIControlState.normal)
        }
        
    }
    
    /* To start the quiz over:
     * reset the number of questions asked to 0
     * reset the number of correct Questions to 0
     * reset selected questions collection to empty
     * display next random question
     */
    @IBAction func playAgain() {
        questionsAsked = 0
        correctQuestions = 0
        selectedQuestions = []
        displayQuestion()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.displayQuestion()
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



