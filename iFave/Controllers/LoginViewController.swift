//
//  LoginViewController.swift
//  iFave
//
//  Created by Andrea Pineda on 10/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorial:
//https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //Constant
    let loginToList = "LoginToList"
    
    //Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    
    //Deze code authenticeert de gebruiker wanneer ze proberen in te loggen door op de knop Login te tikken.
    
    //Functie voor het inloggen
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        Auth.auth().signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!)
    }
    
    //Functie voor de nieuwe gebruikers: registreren
    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        //De registreergegevens opslaan
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        
                                        //Haal de email en wachtwoord gegeves opgegeven door gebruiker
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        //Roep createUser(withEmail:password:) van Firebase
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    //Als er geen errors zijn, is de user gecreerd.
                                                                    if error == nil {
                                                                    //Authenticeer deze nieuwe gebruiker
                                                                        Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
                                                                                               password: self.textFieldLoginPassword.text!)
                                                                    }
                                        } }
        
        //Cancel van het creeren nieuwe gebruiker
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        //Textfield voor je nieuwe email account
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        //Textfield voor je nieuwe wachtwoord
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        //Voeg de save en cancel actie toe
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Maak een verificatieobject aan met addStateDidChangeListener
        Auth.auth().addStateDidChangeListener() { auth, user in
            // Test de value van de gebruiker
            if user != nil {
                //Bij succesvol verificatie, voer de segue uit
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    //Beheer van de bewerking en validatie van de email en password bij inloggen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
