//
//  QuestionsContainer.swift
//  TrueFalseStarter
//
//  Created by Duc Vu on 8/18/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//
class Question {
    let question: String
    let options: [String]
    let correctAnswer: String
    
    init(question: String, options: [String], correctAnswer: Int) {
        self.question = question
        self.options = options
        self.correctAnswer = options[correctAnswer - 1]
    }
    
}

let trivia: [Question] = [
    Question(question:"This was the only US President to serve more than two consecutive terms.",
     options:["George Washingon", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
     correctAnswer: 2),
    Question(question:"Which of the following countries has the most residents?",
     options:["Nigeria", "Russia", "Iran", "Vietnam"],
     correctAnswer: 1),
    Question(question:"In what year was the United Nations founded?",
     options:["1918", "1919", "1945", "1954"],
     correctAnswer: 3),
    Question(question:"The Titanic departed from the United Kingdom, where was it supposed to arrive?",
     options:["Paris", "Washington D.C.", "New York City", "Boston"],
     correctAnswer: 3),
    Question(question:"Which nation produces the most oil?",
     options:["Iran", "Iraq", "Brazil", "Canada"],
     correctAnswer: 4),
    Question(question:"Which country has most recently won consecutive World Cups in Soccer?",
     options:["Italy", "Brazil", "Argentina", "Spain"],
     correctAnswer: 2),
    Question(question:"Which of the following rivers is longest?",
     options:["Yangtze", "Mississippi", "Congo", "Mekong"],
     correctAnswer: 2),
    Question(question:"Which city is the oldest?",
     options:["Mexico City", "Cape Town", "San Juan", "Sydney"],
     correctAnswer: 1),
    Question(question:"Which country was the first to allow women to vote in national elections?",
     options:["Poland", "United Stateds", "Sweden", "Senegal"],
     correctAnswer: 1),
    Question(question:"Which of these countries won the most medals in the 2012 Summer Games?",
     options:["France", "Germany", "Japan", "Great Britian"],
     correctAnswer: 4),
]


  



