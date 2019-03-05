//
//  MarvelDao.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 04/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import Foundation
import Alamofire

class MarvelDao {
    
    static let BASE_URL_API = "http://gateway.marvel.com/v1/public/"
    
    func getCharacters(limit: Int, offset: Int, completion: @escaping([Character]?)-> Void) {
        let timestamp = NSDate().timeIntervalSince1970
        let md5 = Hash.md5Hex("\(timestamp)\(Constants.PRIV_KEY_MARVEL)\(Constants.PUB_KEY_MARVEL)")
        let url = "\(MarvelDao.BASE_URL_API)characters?limit=\(limit)&offset=\(offset)&ts=\(timestamp)&apikey=\(Constants.PUB_KEY_MARVEL)&hash=\(md5)"
        AF.request(url).responseJSON { response in
            guard let data = response.value as? [String: Any] else {
                completion(nil)
                return
            }
            guard let dt = data[Constants.DATA] as? [String: Any] else {
                completion(nil)
                return
            }
            guard let results = dt[Constants.RESULTS] as? [Any] else {
                completion(nil)
                return
            }
            
            var characters = [Character]()
            for result in results {
                if let character = Character(result as? [String: Any] ?? [:]) {
                    characters.append(character)
                }
            }
            completion(characters)
        }
    }
    
    func getComics(idCharacter: Int, completion: @escaping([Comic]?)-> Void) {
        let timestamp = NSDate().timeIntervalSince1970
        let md5 = Hash.md5Hex("\(timestamp)\(Constants.PRIV_KEY_MARVEL)\(Constants.PUB_KEY_MARVEL)")
        let url = "\(MarvelDao.BASE_URL_API)characters/\(idCharacter)/comics?ts=\(timestamp)&apikey=\(Constants.PUB_KEY_MARVEL)&hash=\(md5)"
        AF.request(url).responseJSON { response in
            guard let data = response.value as? [String: Any] else {
                completion(nil)
                return
            }
            guard let dt = data[Constants.DATA] as? [String: Any] else {
                completion(nil)
                return
            }
            guard let results = dt[Constants.RESULTS] as? [Any] else {
                completion(nil)
                return
            }
            
            var comics = [Comic]()
            for result in results {
                if let comic = Comic(result as? [String: Any] ?? [:]) {
                    comics.append(comic)
                }
            }
            completion(comics)
        }
    }
    
}
