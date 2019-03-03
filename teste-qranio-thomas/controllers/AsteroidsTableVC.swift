//
//  AsteroidsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class AsteroidsTableVC: UITableViewController {
    
    var asteroids = [Asteroid]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let asteroid = asteroids[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidCell") as! UITableViewCell
        
        return cell
    }
    
}
