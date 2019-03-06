//
//  UsersTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class UsersTableVC: UIBaseTableViewController {
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadData()
    }
    
    //MARK:- BaseTableView
    override func loadData() {
        startLoading()
        UsersDao().getUsers { users in
            self.stopLoading()
            guard let users = users else {
                self.show(message: Constants.ERROR_LOADING_INFO)
                return
            }
            if users.count > 0 {
                self.users = users
                self.tableView.reloadData()
            } else {
                self.show(message: Constants.EMPTY_LIST_USERS)
            }
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
//        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UITableViewCell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "userCell")
        cell.selectionStyle = .none
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
}
