//
//  Houses.swift
//  GoT-Houses
//
//  Created by John Gallaugher on 4/1/20.
//  Copyright © 2020 John Gallaugher. All rights reserved.
//

import Foundation

class Houses {
    
    var houseArray: [HouseInfo] = []
    var url = "https://www.anapioficeandfire.com/api/houses?page=1&pageSize=50"
    var pageNumber = 1
    var continueLoading = true
    
    func getData(completed: @escaping ()->()) {
        let urlString = "https://www.anapioficeandfire.com/api/houses?page=\(pageNumber)&pageSize=50"
        print("🕸 We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            completed()
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // note: there are some additional things that could go wrong when using URL session, but we shouldn't experience them, so we'll ignore testing for these for now...
            
            // deal with the data
            do {
                let results = try JSONDecoder().decode([HouseInfo].self, from: data!)
                // If there is data in the array, increment pageNumber by one and update the houseArray to equal houseArray + our new array
                if results.count > 0 {
                    self.pageNumber = self.pageNumber + 1
                    self.houseArray = self.houseArray + results
                } else {
                    self.continueLoading = false
                }
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            completed()
        }
        
        task.resume()
    }
}
