//
//  AsteroidsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class AsteroidsTableVC: UIBaseTableViewController {
    
    var days = [String]()
    var asteroids = [String: [Asteroid]]()
    var startDate: String?
    var endDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadData()
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
    
    //MARK:- BaseTableView
    override func loadData() {
        guard let startDate = startDate else { return }
        guard let endDate = endDate else { return }
        startLoading()
        AsteroidsDao().getAsteroids(startDate, endDate) { days, asteroids in
            self.stopLoading()
            guard let daysList = days else { return }
            guard let asteroidList = asteroids else { return }
            
            self.days = daysList
            self.asteroids = asteroidList
            self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0) : UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
    
}
