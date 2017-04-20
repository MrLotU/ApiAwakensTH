//
//  KeyboardViewController.swift
//  Api Awakens TH
//
//  Created by Jari Koopman on 20/04/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

    @IBOutlet weak var creditsToUSDTextField: UITextField!
    @IBOutlet weak var USDToCreditsTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(done), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
        if let creditsToUSD = Double(creditsToUSDTextField.text!) {
            exchangeCreditsToDollars = creditsToUSD
        } else {
            //TODO: Make a fancy popup
        }
        if let USDToCredits = Double(USDToCreditsTextField.text!) {
            exchangeDollarsToCredits = USDToCredits
        } else {
            //TODO: Make a fancy popup
        }
        self.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
