//
//  CharactersMarvelTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 04/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class CharactersTableVC: UITableViewController {
    
    var characters = [Character]()
    var willLoadMore = false
    var countCells = 0
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListCharacters(from: 0, to: 20)
    }
    
    func loadListCharacters(from: Int, to: Int) {
        MarvelDao().getCharacters(limit: to, offset: from, completion: { characters in
            guard let list = characters else { return }
            self.characters.append(contentsOf: list)
            self.countCells += list.count
            self.tableView.reloadData()
        })
    }
    
    func createActionsForSelectedRow() {
        guard let character = selectedCharacter else { return }
        let alert = UIAlertController(title: "Choose an action:", message: nil, preferredStyle: .actionSheet)
        let actionDescription = UIAlertAction(title: Constants.DESCRIPTION, style: .default) { action in
            Alert(self).show(title: character.name, message: character.description, buttonTitle: Constants.OK)
        }
        alert.addAction(actionDescription)
        let actionComics = UIAlertAction(title: Constants.COMICS, style: .default) { action in
            self.performSegue(withIdentifier: "goToComics", sender: self)
        }
        alert.addAction(actionComics)
        let eventsComics = UIAlertAction(title: Constants.EVENTS, style: .default) { action in
            self.performSegue(withIdentifier: "goToEvents", sender: self)
        }
        alert.addAction(eventsComics)
        let actionCancel = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let character = selectedCharacter else { return }
        if segue.identifier == "goToComics" {
            let comicsTableVC = segue.destination as! ComicsTableVC
            comicsTableVC.character = character
            comicsTableVC.title = Constants.COMICS
        } else { //goToEvents
            let eventsTableVC = segue.destination as! EventsTableVC
            eventsTableVC.character = character
            eventsTableVC.title = Constants.EVENTS
        }
    }
    
    
    //MARK:- Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = characters[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") as! UITableViewCell
        cell.textLabel?.text = character.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacter = characters[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        createActionsForSelectedRow()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            loadListCharacters(from: countCells+1, to: countCells + 20)
        }
    }
    
}
