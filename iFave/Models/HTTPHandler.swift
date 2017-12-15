//
//  HTTPHandler.swift
//  iFave
//
//  Created by Andrea Pineda on 12/12/2017.
//  Copyright © 2017 Andrea Pineda. All rights reserved.
//

//Hulp van tutorials:
//https://stackoverflow.com/questions/24016142/how-to-make-an-http-request-in-swift
//https://grokswift.com/completion-handlers-in-swift/

import Foundation

class HTTPHandler {
    //Get de URL die we doorgeven
    //Static zodat het niet "geinitialized" moet worden
    static func getJson(urlString: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        print(urlString!)
        print("URL die gebruikt wordt is: \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            //Zorg ervoor dat er data is
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("Verzoek ingevuld met de code: \(statusCode)")
                if (statusCode == 200) {
                    print("return to completion handler with the data")
                    completionHandler(data as Data)
            
                }
                //Return error als er een error is
            } else if let error = error {
                print("Er was een error met de HTTP request verzoek...")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
}

