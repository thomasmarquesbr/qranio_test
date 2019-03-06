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
    
    func parseResults(_ response: DataResponse<Any>) -> [Any]? {
        guard let data = response.value as? [String: Any] else { return nil }
        guard let dt = data[Constants.DATA] as? [String: Any] else { return nil }
        guard let results = dt[Constants.RESULTS] as? [Any] else { return nil }
        return results
    }
    
    func getCharacters(limit: Int, offset: Int, completion: @escaping([Character]?)-> Void) {
        let timestamp = NSDate().timeIntervalSince1970
        let md5 = Hash.md5Hex("\(timestamp)\(Constants.PRIV_KEY_MARVEL)\(Constants.PUB_KEY_MARVEL)")
        let url = "\(MarvelDao.BASE_URL_API)characters?limit=\(limit)&offset=\(offset)&ts=\(timestamp)&apikey=\(Constants.PUB_KEY_MARVEL)&hash=\(md5)"
        AF.request(url).responseJSON { response in
            guard let results = self.parseResults(response) else {
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
            guard let results = self.parseResults(response) else {
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
    
    func getEvents(idCharacter: Int, completion: @escaping([Event]?)-> Void) {
        let timestamp = NSDate().timeIntervalSince1970
        let md5 = Hash.md5Hex("\(timestamp)\(Constants.PRIV_KEY_MARVEL)\(Constants.PUB_KEY_MARVEL)")
        let url = "\(MarvelDao.BASE_URL_API)characters/\(idCharacter)/events?ts=\(timestamp)&apikey=\(Constants.PUB_KEY_MARVEL)&hash=\(md5)"
        AF.request(url).responseJSON { response in
            guard let results = self.parseResults(response) else {
                completion(nil)
                return
            }
            
            var events = [Event]()
            for result in results {
                if let event = Event(result as? [String: Any] ?? [:]) {
                    events.append(event)
                }
            }
            completion(events)
        }
    }
    
}
