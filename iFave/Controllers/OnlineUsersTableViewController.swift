//
//  OnlineUsersTableViewController.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorials:
//https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2
//https://www.appcoda.com/firebase-login-signup/

import UIKit
import Firebase

class OnlineUsersTableViewController: UITableViewController {

    //User cell
    let userCell = "UserCell"

    //Curren Users
    var currentUsers: [String] = []

    //Lokale referentie naar het online gebruikersrecord van Firebase
    let usersRef = Database.database().reference(withPath: "online")

    override func viewDidLoad() {
        super.viewDidLoad()
        //Toon lijst van online gebruikers
        usersRef.observe(.childAdded, with: { snap in
            guard let email = snap.value as? String else { return }
            self.currentUsers.append(email)
            let row = self.currentUsers.count - 1
            let indexPath = IndexPath(row: row, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .top)
        })
        
        //"Observer" voor de children van de usersRef
        usersRef.observe(.childRemoved, with: { snap in
            guard let emailToFind = snap.value as? String else { return }
            for (index, email) in self.currentUsers.enumerated() {
                if email == emailToFind {
                    let indexPath = IndexPath(row: index, section: 0)
                    self.currentUsers.remove(at: index)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
    }

    //Functie die het aantal online gebruikers telt
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    //TableView voor de online users
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
        let onlineUserEmail = currentUsers[indexPath.row]
        cell.textLabel?.text = onlineUserEmail
        return cell
    }

    //Functie voor het uitlog button
    @IBAction func signoutButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

}

