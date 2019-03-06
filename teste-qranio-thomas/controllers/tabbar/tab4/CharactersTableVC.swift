//
//  CharactersMarvelTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 04/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class CharactersTableVC: UIBaseTableViewController {
    
    var characters = [Character]()
    var willLoadMore = false
    var countCells = 0
    var selectedCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListCharacters(more: 50)
    }
    
    func loadListCharacters(more: Int) {
        if characters.count == 0 {
            startLoading()
        }
        MarvelDao().getCharacters(limit: more, offset: countCells + 1, completion: { characters in
            self.stopLoading()
            guard let list = characters else {
                self.show(message: Constants.ERROR_LOADING_INFO)
                return
            }
            
            self.characters.append(contentsOf: list)
            self.countCells += list.count
            if self.characters.count > 0 {
                self.tableView.reloadData()
            } else {
                self.show(message: Constants.EMPTY_LIST_CHARACTERS)
            }
        })
    }
    
    func createActionsForSelectedRow() {
        guard let character = selectedCharacter else { return }
        let alert = UIAlertController(title: "Choose an action:", message: nil, preferredStyle: .actionSheet)
        
        let actionDescription = UIAlertAction(title: Constants.DESCRIPTION.capitalizingFirstLetter(), style: .default) { action in
            Alert(self).show(title: character.name, message: character.description, buttonTitle: Constants.OK)
        }
        let actionComics = UIAlertAction(title: Constants.COMICS.capitalizingFirstLetter(), style: .default) { action in
            self.performSegue(withIdentifier: "goToComics", sender: self)
        }
        let actionEvents = UIAlertAction(title: Constants.EVENTS.capitalizingFirstLetter(), style: .default) { action in
            self.performSegue(withIdentifier: "goToEvents", sender: self)
        }
        let actionCancel = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
        
        actionDescription.setValue(UIColor.black, forKey: "titleTextColor")
        actionComics.setValue(UIColor.black, forKey: "titleTextColor")
        actionEvents.setValue(UIColor.black, forKey: "titleTextColor")
        actionCancel.setValue(UIColor.black, forKey: "titleTextColor")
        
        alert.addAction(actionDescription)
        alert.addAction(actionComics)
        alert.addAction(actionEvents)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let character = selectedCharacter else { return }
        if segue.identifier == "goToComics" {
            let comicsTableVC = segue.destination as! ComicsTableVC
            comicsTableVC.character = character
            comicsTableVC.title = Constants.COMICS.capitalizingFirstLetter()
        } else { //goToEvents
            let eventsTableVC = segue.destination as! EventsTableVC
            eventsTableVC.character = character
            eventsTableVC.title = Constants.EVENTS.capitalizingFirstLetter()
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "characterCell")
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
            loadListCharacters(more: 50)
        }
    }
    
}
