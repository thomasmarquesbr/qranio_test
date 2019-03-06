//
//  ComicsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 05/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class ComicsTableVC: UIBaseTableViewController {
    
    var character: Character?
    var comics = [Comic]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadData()
    }
    
    //MARK:- BaseTableView
    override func loadData() {
        guard let character = character else { return }
        startLoading()
        MarvelDao().getComics(idCharacter: character.id) { comics in
            self.stopLoading()
            guard let comics = comics else {
                self.show(message: Constants.ERROR_LOADING_INFO)
                return
            }
            
            if comics.count > 0 {
                self.comics = comics
                self.tableView.reloadData()
            } else {
                self.show(message: Constants.EMPTY_LIST_COMICS)
            }
        }
    }
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = comics[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "comicCell")
        cell.selectionStyle = .none
        cell.textLabel?.text = comic.title
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = comic.description
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
}
