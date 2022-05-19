//
//  ViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/5/22.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    var jsonText : Subject = []
    var titles: [(String, (() -> Void))] = []
    var questions : [String] = []
    var answer : [String] = []
    var answerChoices : [[String]] = []
    var urlAddress : String = "http://tednewardsandbox.site44.com/questions.json"
    
    // MARK: - WelcomeElement
    struct SubjectElement: Codable {
        let title, desc: String
        let questions: [Question]
    }

    // MARK: - Question
    struct Question: Codable {
        let text, answer: String
        let answers: [String]
    }
    
    typealias Subject = [SubjectElement]

    @IBAction func ViewQuizCategoriesButtonTouchUpInside(_ sender: Any) {
        print("URL: \(urlAddress)")
        // getting all of the questions from the json
        titles = []
        for subject in self.jsonText {
            titles.append(("\(subject.title)", { self.showQuizQuestions("\(subject.title)") } ))
        }
        
        // creating the table view controller
        let tvc = TableViewController()
        tvc.models = titles
        
        print(tvc.models)
        
//        vc.models = [
//            ("Mathematics", { self.showQuizQuestions("math") }),
//            ("Marvel Super Heroes", { self.showQuizQuestions("marvel")  }),
//            ("Science", { self.showQuizQuestions("science")  })
//        ]
        navigationController?.pushViewController(tvc, animated: true)
    }
    
    func getQuizData() {
        // let urlAddress = "http://tednewardsandbox.site44.com/questions.json"
        let url = URL(string: self.urlAddress)
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in guard let data = data else {
                print("Data is nil :(")
                return
            }
            if response != nil {
                if (response! as! HTTPURLResponse).statusCode % 100 == 5 {
                    print("Server Error")
                }
                if (response! as! HTTPURLResponse).statusCode != 200 {
                    print("Something went wrong: \(String(describing: error))")
                    
                    // reset the url to what we know will work:
                    // self.urlAddress = "http://tednewardsandbox.site44.com/questions.json"
                    // print("trying to reset url to: \(self.urlAddress)")
                    // call the function again with a working link
                    self.viewDidLoad()
                    return
                    
                }
            }
            do {
                let info = try JSONDecoder().decode(Subject.self, from: data)
                // print(info)
                self.jsonText = info
            } catch {
                print("Something went wrong: \(error)")
            }
            
            DispatchQueue.main.async {
                //self.parseJson(json!)
                //self.jsonText = json
                print("url used: \(self.urlAddress)")
                print("JSON: \(self.jsonText)")
            }
        }
        task.resume()
    }
    
    @objc func showQuizQuestions(_ quizTopic : String) {
        print("quiz name: \(quizTopic)")
        
        // get information about the specific quiz!
        self.questions = []
        self.answer = []
        self.answerChoices = []
        // getting the array of quiz questions
        for subject in self.jsonText {
            if subject.title == quizTopic {
                // go though each question
                for question in subject.questions {
                    self.questions.append(question.text)
                    self.answer.append(question.answer)
                    self.answerChoices.append(question.answers)
                }
            }
        }
        
        // create a new game!!
        
        let game = Game("\(quizTopic)", self.questions, self.answer, self.answerChoices)
        
        guard let qvc = storyboard?.instantiateViewController(identifier: "QuestionVC", creator: { coder in
            return QuestionViewController(coder: coder, game: game)
        }) else {
            fatalError("Failed to load QuestionViewController from storyboard.")
        }

        navigationController?.pushViewController(qvc, animated: true)
    }
    
    
    
    @IBAction func settingsTouchUpInside(_ sender: Any) {
        // V1: Show the user an alert
//        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK",
//                                      style: .default,
//                                      handler: { _ in NSLog("\"OK\" pressed.")
//        }))
//        self.present(alert, animated: true, completion: {
//          NSLog("The completion handler fired")
//        })
        
        // V2: present the settings VC modally
        guard let svc = storyboard?.instantiateViewController(identifier: "SettingsVC", creator: { coder in
            return SettingsViewController(coder: coder)
        }) else {
            fatalError("Failed to load SettingsViewController from storyboard.")
        }
        //navigationController?.pushViewController(svc, animated: true)
        present(svc, animated: true)
        
    }
    
    func updateUserInterface() {
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
        
        if !Network.reachability.isReachable {
            let alert = UIAlertController(title: "Network Issue", message: "Could not connect to the network. Game will continue with stored data until it is back online.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: { _ in NSLog("\"OK\" pressed.")
            }))
            self.present(alert, animated: true, completion: {
              NSLog("The completion handler fired")
            })
        }
    }
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CALLED VIEW DID LOAD")
        self.urlAddress = "http://tednewardsandbox.site44.com/questions.json"
        // print("URL: \(urlAddress)")
        // Do any additional setup after loading the view.
        
        // settings defaults
        // let defaults = UserDefaults.standard

        // checking network
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
        
        // getting quiz data
        getQuizData()
    }

}

