//
//  eventTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class EventsTableVC: UIBaseTableViewController {
    
    var character: Character?
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadData()
    }
    
    //MARK:- BaseTableView
    override func loadData() {
        guard let character = character else { return }
        startLoading()
        MarvelDao().getEvents(idCharacter: character.id) { events in
            self.stopLoading()
            guard let events = events else {
                self.show(message: Constants.ERROR_LOADING_INFO)
                return
            }
            
            if events.count > 0 {
                self.events = events
                self.tableView.reloadData()
            } else {
                self.show(message: Constants.EMPTY_LIST_EVENTS)
            }
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "eventCell")
        cell.selectionStyle = .none
        cell.textLabel?.text = event.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = event.description
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
}
