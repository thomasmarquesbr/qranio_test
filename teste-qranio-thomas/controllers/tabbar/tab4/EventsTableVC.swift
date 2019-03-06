//
//  eventTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class EventsTableVC: UITableViewController {
    
    var character: Character?
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListEvents()
    }
    
    func loadListEvents() {
        guard let character = character else { return }
        MarvelDao().getEvents(idCharacter: character.id) { events in
            guard let events = events else { return }
            self.events = events
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.text = event.title
        cell.detailTextLabel?.text = event.description
        return cell
    }
    
}
