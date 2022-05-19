//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/19/22.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var urlTextFieldOutlet: UITextField!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func urlTextFieldEditingDidEnd(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // dismiss keyboard when you press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func checkNowButtonTouchUpInside(_ sender: Any) {
        // register the new url (if there is one)
        let newURL = self.urlTextFieldOutlet.text
        if self.verifyUrl(newURL) {
            // the new URL is valid, should change
            // self.performSegue(withIdentifier: "mainVC", sender: self)
            // self.dismiss(animated: true, completion: nil)
            
            // creating the main view controller again
            
            let mvc = ViewController()
            mvc.urlAddress = newURL!
            self.dismiss(animated: true, completion: nil)
             //self.present(mvc, animated: true)
            
        } else if newURL == "" {
            self.dismiss(animated: true, completion: nil)
        } else {
            // show an alert that the URL entered was invalid
            let alert = UIAlertController(title: "Error", message: "Invalid URL. Please make sure your URL includes https://.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Exit Settings",
                                                  style: .default,
                                                  handler: { _ in NSLog("\"OK\" pressed.")
                        // dismiss this view
                            self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: {
                      NSLog("The completion handler fired")
                    })
        }
    }
    
    func verifyUrl(_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlTextFieldOutlet.delegate = self

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "InputVCToDisplayVC") {
            let mainVC = segue.destination as! ViewController
            mainVC.urlAddress = urlTextFieldOutlet.text!
        }
    }
    

}
