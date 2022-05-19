//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Amaya Kejriwal on 5/19/22.
//

import UIKit

protocol newURLDelegate {
    func newURL(url: String)
    func getData()
}

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var delegate: newURLDelegate?
    
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
            delegate?.newURL(url: newURL!)
            // self.dismiss(animated: true, completion: {})
            
        } else if newURL == "" { // nothing has been entered in the box
            delegate?.getData()
            //self.dismiss(animated: true, completion: nil)
        } else {
            // show an alert that the URL entered was invalid
            let alert = UIAlertController(title: "Error", message: "Invalid URL. Please make sure your URL includes https://.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: .default,
                                                  handler: { _ in NSLog("\"OK\" pressed.")

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
        self.urlTextFieldOutlet.placeholder = "URL"

        // Do any additional setup after loading the view.
    }
}
