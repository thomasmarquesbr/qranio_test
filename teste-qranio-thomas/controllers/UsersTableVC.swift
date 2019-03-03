//
//  UsersTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class UsersTableVC: UITableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListUsers()
    }
    
    func loadListUsers() {
        UsersDao().getUsers { (users) in
            guard let users = users else { return }
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UITableViewCell
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
}
