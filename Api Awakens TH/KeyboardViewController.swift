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
        saveButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneButtonPressed() {
        do {
            try done()
        } catch ApiAwakensError.ExchangeError(let onExchangeValue) {
            let alert = UIAlertController(title: "Something went wrong!", message: "The exchange rate you entered for \(onExchangeValue) is unconvertible to a positive number. Please try again!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        } catch {
            fatalError("Something went wrong! Oh oh!")
        }
    }
    
    func done() throws {
        if let creditsToUSD = Double(creditsToUSDTextField.text!) {
            exchangeCreditsToDollars = creditsToUSD
        } else {
            throw ApiAwakensError.ExchangeError(onExchangeValue: "Creditst to USD")
        }
        if let USDToCredits = Double(USDToCreditsTextField.text!) {
            exchangeDollarsToCredits = USDToCredits
        } else {
            throw ApiAwakensError.ExchangeError(onExchangeValue: "USD to Credits")
        }
        self.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
