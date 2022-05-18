//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/15/22.
//

import UIKit

class AnswerViewController: UIViewController {
    @IBOutlet weak var resultLabelOutlet: UILabel!
    @IBOutlet weak var questionLabelOutlet: UILabel!
    @IBOutlet weak var answerLabelOutlet: UILabel!
    
    let game : Game?
    let userAnswer : String
    
    init?(coder: NSCoder, game : Game, userAnswer : String) {
        self.game = game
        self.userAnswer = userAnswer
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        // if the current question is the last question
        if game?.currentQuestion == (game?.getQuestions().count)! - 1 {
            // switch to the finished view controller
            guard let qvc = storyboard?.instantiateViewController(identifier: "FinishedVC", creator: { coder in
                return FinishedViewController(coder: coder, game: self.game!)
            }) else {
                fatalError("Failed to load question vc from storyboard.")
            }

            navigationController?.pushViewController(qvc, animated: true)
        } else {
            // proceed to the next question
            game?.goToNextQuestion()
            // open the question vc
            guard let qvc = storyboard?.instantiateViewController(identifier: "QuestionVC", creator: { coder in
                return QuestionViewController(coder: coder, game: self.game!)
            }) else {
                fatalError("Failed to load question vc from storyboard.")
            }

            navigationController?.pushViewController(qvc, animated: true)
        }
    }
    
    func setUp() {
        let questions = game!.getQuestions()
        let answer = game!.getCorrectAnswer()[game!.currentQuestion]
        
        questionLabelOutlet.text = questions[game!.currentQuestion]
        answerLabelOutlet.text = answer
        
        if game?.checkAnswer(userAnswer) == true {
            resultLabelOutlet.text = "Correct! Yay!"
        } else {
            resultLabelOutlet.text = "Incorrect, Oops."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
