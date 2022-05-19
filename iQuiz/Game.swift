//
//  Game.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/17/22.
//

import Foundation

class Game {
    var topic : String
    var questions : [String] = []
    var answer : [String] = []
    var answerChoices : [[String]] = []
    
    var currentQuestion : Int = 0 // the question that the player is currently on
    var score : Int = 0 // how many questions the player has gotten correct
    
    
    init(_ t : String, _ q : [String], _ a : [String], _ ac : [[String]]) {
        self.topic = t
        self.questions = q
        self.answer = a
        self.answerChoices = ac
    }
    
    func goToNextQuestion() {
        currentQuestion += 1
    }
    
    func getQuestions() -> [String] {        
//        switch topic {
//        case "math":
//            return ["What is 2 + 2?", "What is 4 * 4?", "What is 5 / 1?"]
//        case "marvel":
//            return ["What is the name of spidermans aunt?", "Who is Tony Stark?"]
//        case "science":
//            return ["What did Issac Newton discover?"]
//        default:
//            return []
//        }
        return self.questions
    }
    
    func getPossibleAnswers() -> [[String]] {
        return self.answerChoices
//        switch topic {
//        case "math":
//            return [["4", "13", "21", "2"], ["14", "4", "16", "44"], ["1", "5", "2", "51"]]
//        case "marvel":
//            return [["Aunt May", "Aunt Suzie", "Aunt Patunia", "Aunt Christina"], ["Spiderman", "Iron Man", "The Hulk", "Black Widow"]]
//        case "science":
//            return [["Electricity", "Gravity", "A cure for cancer", "All of the above"]]
//        default:
//            return []
//        }
    }
    
    func getCorrectAnswer() -> [String] {
        var correctAnswers : [String] = []
        
        for index in 0...self.questions.count - 1 {
            // print("ANSWER INDEX: \(self.answer[index])")
            let answerIndex = Int(self.answer[index])! - 1
            let answer = self.answerChoices[index][answerIndex]
            
            correctAnswers.append(answer)
        }
        
        return correctAnswers
        
//        switch topic {
//        case "math":
//            return ["4", "16", "5"]
//        case "marvel":
//            return ["Aunt May", "Iron Man"]
//        case "science":
//            return ["Gravity"]
//        default:
//            return []
//        }
    }
    
    func checkAnswer(_ userAnswer : String) -> Bool {
        print("user answer: \(userAnswer)")
        let ans = getCorrectAnswer()[currentQuestion]
        print("correct answer: \(ans)")
        
        if userAnswer == getCorrectAnswer()[currentQuestion] {
            self.score += 1
            print("score: \(self.score)")
            return true
        }
        return false
    }
}
