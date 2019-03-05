//
//  CharactersMarvelTableVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 04/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class CharactersMarvelTableVC: UITableViewController {
    
    var characters = [Character]()
    var willLoadMore = false
    var countCells = 0
    
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count - 1 {
            loadListCharacters(from: countCells+1, to: countCells + 20)
        }
    }
    
}
