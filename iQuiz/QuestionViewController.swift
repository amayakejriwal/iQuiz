//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/15/22.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
        
    @IBOutlet weak var answer1ButtonOutlet: UIButton!
    @IBOutlet weak var answer2ButtonOutlet: UIButton!
    @IBOutlet weak var answer3ButtonOutlet: UIButton!
    @IBOutlet weak var answer4ButtonOutlet: UIButton!
    
    @IBOutlet weak var answer1LabelOutlet: UILabel!
    @IBOutlet weak var answer2LabelOutlet: UILabel!
    @IBOutlet weak var answer3LabelOutlet: UILabel!
    @IBOutlet weak var answer4LabelOutlet: UILabel!
    
    @IBOutlet weak var submitButtonOutlet: UIButton!
        
    var selectedButton : UIButton? = nil
    
    let game : Game?
    
    init?(coder: NSCoder, game : Game) {
        self.game = game
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // user pressed answer #1
    @IBAction func answer1ButtonTouchUpInside(_ sender: Any) {
        chooseAnswer()
        selectedButton = answer1ButtonOutlet
        answer1ButtonOutlet.isSelected = true
        
        // deselect the rest of the buttons:
        answer2ButtonOutlet.isSelected = false
        answer3ButtonOutlet.isSelected = false
        answer4ButtonOutlet.isSelected = false
    }
    
    // user pressed answer #2
    @IBAction func answer2ButtonTouchUpInside(_ sender: Any) {
        chooseAnswer()
        selectedButton = answer2ButtonOutlet
        answer2ButtonOutlet.isSelected = true
        
        // deselect the rest of the buttons:
        answer1ButtonOutlet.isSelected = false
        answer3ButtonOutlet.isSelected = false
        answer4ButtonOutlet.isSelected = false
    }
    
    // user pressed answer #3
    @IBAction func answer3ButtonTouchUpInside(_ sender: Any) {
        chooseAnswer()
        selectedButton = answer3ButtonOutlet
        answer3ButtonOutlet.isSelected = true
        
        // deselect the rest of the buttons:
        answer1ButtonOutlet.isSelected = false
        answer2ButtonOutlet.isSelected = false
        answer4ButtonOutlet.isSelected = false
    }
    
    // user pressed answer #4
    @IBAction func answer4ButtonTouchUpInside(_ sender: Any) {
        chooseAnswer()
        selectedButton = answer4ButtonOutlet
        answer4ButtonOutlet.isSelected = true
        
        // deselect the rest of the buttons:
        answer1ButtonOutlet.isSelected = false
        answer2ButtonOutlet.isSelected = false
        answer3ButtonOutlet.isSelected = false
    }
    
    func chooseAnswer() {
        submitButtonOutlet.isEnabled = true
    }
    
    @IBAction func submitAnswerButtonTouchUpInside(_ sender: Any) {
        var userAnswer = ""
        switch selectedButton {
        case answer1ButtonOutlet:
            userAnswer = answer1LabelOutlet.text!
        case answer2ButtonOutlet:
            userAnswer = answer2LabelOutlet.text!
        case answer3ButtonOutlet:
            userAnswer = answer3LabelOutlet.text!
        case answer4ButtonOutlet:
            userAnswer = answer4LabelOutlet.text!
        default:
            userAnswer = ""
        }
        
        // show the answer view controller
        guard let avc = storyboard?.instantiateViewController(identifier: "AnswerVC", creator: { coder in
            return AnswerViewController(coder: coder, game: self.game!, userAnswer: userAnswer)
        }) else {
            fatalError("Failed to load AnswerViewController from storyboard.")
        }

        navigationController?.pushViewController(avc, animated: true)
    }
    
    func setUp() {
        let questions = game!.getQuestions()
        let possibleAnswers = game!.getPossibleAnswers()[game!.currentQuestion]
        print("\(possibleAnswers)")
        // print("\(questions)")
        
        questionLabel.text = questions[game!.currentQuestion]
        
        answer1LabelOutlet.text = possibleAnswers[0]
        answer2LabelOutlet.text = possibleAnswers[1]
        answer3LabelOutlet.text = possibleAnswers[2]
        answer4LabelOutlet.text = possibleAnswers[3]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButtonOutlet.isEnabled = false
        // Do any additional setup after loading the view.
        
        setUp()
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
