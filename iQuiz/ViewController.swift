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
            ("Mathematics", { print("Mathematics") }),
            ("Marvel Super Heroes", { print("Marvel Super Heroes") }),
            ("Science", { print("Science") })
        ]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func settingsTouchUpInside(_ sender: Any) {
        // V1: Show the user an alert
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in
          NSLog("\"OK\" pressed.")
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

