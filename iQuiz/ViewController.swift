//
//  ViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func ViewQuizCategoriesButtonTouchUpInside(_ sender: Any) {
        let vc = TableViewController()
        vc.models = [
            ("Mathematics", { self.showQuizQuestions("math") }),
            ("Marvel Super Heroes", { self.showQuizQuestions("marvel")  }),
            ("Science", { self.showQuizQuestions("science")  })
        ]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func showQuizQuestions(_ quizTopic : String) {
        print("quiz name: \(quizTopic)")
        
        // create a new game!!
        
        let game = Game("\(quizTopic)")
        
        guard let qvc = storyboard?.instantiateViewController(identifier: "QuestionVC", creator: { coder in
            return QuestionViewController(coder: coder, game: game)
        }) else {
            fatalError("Failed to load EditUserViewController from storyboard.")
        }

        navigationController?.pushViewController(qvc, animated: true)
            
    }
    
    
    
    @IBAction func settingsTouchUpInside(_ sender: Any) {
        // V1: Show the user an alert
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in NSLog("\"OK\" pressed.")
        }))
        self.present(alert, animated: true, completion: {
          NSLog("The completion handler fired")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

