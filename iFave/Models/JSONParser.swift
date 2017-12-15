//
//  JSONParser.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorial:
//https://developer.apple.com/swift/blog/?id=37

import Foundation

class JSONParser {
    static func parse (data: Data) -> [String: AnyObject]? {
        //Serialization om de JSON-gegevens te lezen -> returnt een string
        let options = JSONSerialization.ReadingOptions()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: options) as? [String: AnyObject]

            return json!
        } catch (let parseError){
            print("There was an error parsing the JSON: \"\(parseError.localizedDescription)\"")
        }
        return nil
    }
}

