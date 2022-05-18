//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/17/22.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var resultLablelOutlet: UILabel!
    @IBOutlet weak var scoreLabelOutlet: UILabel!
    let game : Game?
    
    init?(coder: NSCoder, game : Game) {
        self.game = game
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func homeButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setUp() {
        let finalScore = Int(game!.score)
        let totalQuestions = game!.getQuestions().count
        
        scoreLabelOutlet.text = "You got \(finalScore) / \(String(describing: totalQuestions)) correct."
        
        if finalScore / totalQuestions >= 1 {
            resultLablelOutlet.text = "100% - Amazing Work!"
        } else {
            resultLablelOutlet.text = "Great try!"
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
