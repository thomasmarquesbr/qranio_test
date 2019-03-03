//
//  AsteroidsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class AsteroidsTableVC: UITableViewController {
    
    var days = [String]()
    var asteroids = [String: [Asteroid]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListAsteroids()
    }
    
    func loadListAsteroids() {
        AsteroidsDao().getAsteroids { days, asteroids in
            guard let daysList = days else { return }
            guard let asteroidList = asteroids else { return }
            
            self.days = daysList
            self.asteroids = asteroidList
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAsteroidDetail" {
            guard let asteroidDetailVC = segue.destination as? AsteroidDetailVC else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let asteroid = asteroids[days[indexPath.section]]![indexPath.row]
            asteroidDetailVC.idAsteroid = asteroid.id
            asteroidDetailVC.title = asteroid.name
        }
    }
    
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids[days[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let asteroids = self.asteroids[days[section]]!
        return (asteroids.count > 0) ? days[section] : nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let asteroid = asteroids[days[indexPath.section]]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidCell") as! UITableViewCell
        cell.textLabel?.text = asteroid.name
        cell.detailTextLabel?.text = "\(asteroid.absoluteMagnitude) \(Constants.ABSOLUTE_MAGNITUDE_LABEL)"
        return cell
    }
    
}
