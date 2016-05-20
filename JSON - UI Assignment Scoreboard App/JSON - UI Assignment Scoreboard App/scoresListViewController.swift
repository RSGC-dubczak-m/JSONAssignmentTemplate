//
//  scoresListViewController.swift
//  JSON - UI Assignment Scoreboard App
//
//  Created by Student on 2016-05-17.
//  Copyright © 2016 Maxym Dubczak. All rights reserved.
//

import Foundation
import UIKit


class scoresListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //how many games were there
    var gameCount = 0
    
    // Views that need to be accessible to all methods
    let jsonResult = UILabel()
    
    // ---------------If data is successfully retrieved from the server, we can parse it here----------------
    func parseMyJSON(theData : NSData) {
        
        
        // De-serializing JSON can throw errors, so should be inside a do-catch structure
        do {
            
            
            let data = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments) as! AnyObject
            
            guard let scoreboardData = data as? [String : AnyObject] else {
                print("had a problem with first few levels of JSON parsing")
                return
                
            }
            
            scoreboardData
            guard let firstLayer = scoreboardData["data"] as? [String : AnyObject] else {
                print ("problem with first layer parsing")
                return
            }
            
            firstLayer
            guard let games = firstLayer["games"] as? [String : AnyObject] else {
                print("had a problem with layer 3")
                return
            }
            games
            
            guard let game : [AnyObject] = games["game"] as? [AnyObject] else {
                print("problem with layer 4")
                return
            }
            game
            
            
            // Iterate over each game
            for i in game {
                
                gameCount += 1
                
                // print("inside game loop")
                
                // Cast this AnyObject into a dictionary of type [ String : AnyObject ]
                guard let gameData  = i as? [String : AnyObject] else {
                    print("could not parse data for a game")
                    return
                    
                }
                gameData
                
                guard let homeTeamName = gameData["home_team_name"] else {
                    print("could not find location")
                    return
                }
                guard let awayTeamName = gameData["away_team_name"] else {
                    print("could not find location")
                    return
                }
                
                //use the dictionary
                print("Home team is: \(homeTeamName) and the away team is: \(awayTeamName)")
                
            }
            
            
            
            
            // Now we can update the UI
            // (must be done asynchronously)
            dispatch_async(dispatch_get_main_queue()) {
                self.jsonResult.text = "parsed JSON should go here"
            }
            
        } catch let error as NSError {
            print ("Failed to load: \(error.localizedDescription)")
        }
        
        
    }
    //------------------------------------------------------------------------------------------------------
    
    // Set up and begin an asynchronous request for JSON data
    func getMyJSON() {
        
        // Define a completion handler
        // The completion handler is what gets called when this **asynchronous** network request is completed.
        // This is where we'd process the JSON retrieved
        let myCompletionHandler : (NSData?, NSURLResponse?, NSError?) -> Void = {
            
            (data, response, error) in
            
            // This is the code run when the network request completes
            // When the request completes:
            //
            // data - contains the data from the request
            // response - contains the HTTP response code(s)
            // error - contains any error messages, if applicable
            
            // Cast the NSURLResponse object into an NSHTTPURLResponse objecct
            if let r = response as? NSHTTPURLResponse {
                
                // If the request was successful, parse the given data
                if r.statusCode == 200 {
                    
                    if let d = data {
                        
                        // Parse the retrieved data
                        self.parseMyJSON(d)
                        
                    }
                    
                }
                
            }
            
        }
        //============ String Builder =========
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: NSDate())
        
        let year =  components.year
        let month = components.month
        let day = components.day - 1
        
        print(year)
        print(month)
        print(day)
        
        
        // Define a URL to retrieve a JSON file from
        var address : String = "http://gd2.mlb.com/components/game/mlb/"
        address += "year_"
        address += String(year)
        address += "/month_"
        if month < 10 {
            address += "0"
        }
        address += String(month)
        address += "/day_"
        if day < 10 {
            address += "0"
        }
        address += String(day)
        address +=  "/master_scoreboard.json"
        
        //============= End of String Builder ===============
        // Try to make a URL request object
        if let url = NSURL(string: address) {
            
            // We have an valid URL to work with
            // print(url)
            
            // Now we create a URL request object
            let urlRequest = NSURLRequest(URL: url)
            
            // Now we need to create an NSURLSession object to send the request to the server
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            // Now we create the data task and specify the completion handler
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: myCompletionHandler)
            
            // Finally, we tell the task to start (despite the fact that the method is named "resume")
            task.resume()
            
        } else {
            
            // The NSURL object could not be created
            print("Error: Cannot create the NSURL object.")
            
        }
        
    }


    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        getMyJSON()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gameCount)
        return gameCount
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        cell.textLabel!.text = "Table To Be Filled"
        cell.backgroundColor = UIColor.cyanColor()
        
        return cell
    }
}