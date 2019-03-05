//
//  ComicsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class ComicsTableVC: UITableViewController {
    
    var character: Character?
    var comics = [Comic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadListComics()
    }
    
    func loadListComics() {
        guard let character = character else { return }
        MarvelDao().getComics(idCharacter: character.id) { comics in
            guard let comics = comics else { return }
            self.comics = comics
            self.tableView.reloadData()
        }
    }
    
    
    //MARK:- Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = comics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell") as! UITableViewCell
        cell.selectionStyle = .none
        cell.textLabel?.text = comic.title
        cell.detailTextLabel?.text = comic.description
        return cell
    }
    
}
