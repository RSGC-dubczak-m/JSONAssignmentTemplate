//
//  scoresListViewController.swift
//  JSON - UI Assignment Scoreboard App
//
//  Created by Student on 2016-05-17.
//  Copyright © 2016 Maxym Dubczak. All rights reserved.
//

import Foundation
import UIKit


var matchup = [String]()

var count = 0

var homeTeam = [AnyObject]()

var awayTeam = [AnyObject]()

var awayTeamWins = [AnyObject]()

var awayTeamLosses = [AnyObject]()

var homeTeamWins = [AnyObject]()

var homeTeamLosses = [AnyObject]()

var winningPitchers = [AnyObject]()

var losingPitchers = [AnyObject]()

var savePitchers = [AnyObject]()

var homeTeamRuns = [AnyObject]()

var awayTeamRuns = [AnyObject]()

var homeTeamHomeRuns = [AnyObject]()

var awayTeamHomeRuns = [AnyObject]()

var bothTeamHomeRuns = [AnyObject]()

var homeTeamHits = [AnyObject]()

var awayTeamHits = [AnyObject]()

var homeTeamErrors = [AnyObject]()

var awayTeamErrors = [AnyObject]()



class openingViewController : UIViewController {
    
    
    
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
                
                guard let homeTeamWin = gameData["home_win"] else {
                    print("could not homw wins")
                    return
                }
                guard let awayTeamWin = gameData["away_win"] else {
                    print("could not find away wins")
                    return
                }
                
                guard let homeTeamLoss = gameData["home_loss"] else {
                    print("could not home wins")
                    return
                }
                guard let awayTeamLoss = gameData["away_loss"] else {
                    print("could not find away wins")
                    return
                }
                
                guard let winningPitcher = gameData["winning_pitcher"] as? [String : AnyObject] else {
                    print("could not find winning pitcher")
                    return
                }
                guard let winningPitcherName = winningPitcher["last"]  else {
                    print("could not find pitcher last name")
                    return
                }
                // winningPitcherName
                guard let losingPitcher = gameData["losing_pitcher"] as? [String : AnyObject] else {
                    print("could not find losing pitcher")
                    return
                }
                guard let losingPitcherName = losingPitcher["last"] else {
                    print("could not find losing pitcher")
                    return
                }
                // losingPitcherName
                
                guard let linescore = gameData["linescore"] as? [String : AnyObject] else {
                    print("failed to parse linescore")
                    return
                }
                // linescore
                
                guard let bothHomeRuns = linescore["hr"] as? [String : AnyObject] else {
                    print("failed to find hr totals")
                    return
                }
                // bothHomeRuns
                guard let homeTeamHR = bothHomeRuns["home"] else {
                    print("failed to get hr data 2")
                    return
                }
                //homeTeamHR
                guard let awayTeamHR = bothHomeRuns["away"] else {
                    print("failed to get hr data 3")
                    return
                }
                // awayTeamHR
                
                guard let bothRuns = linescore["r"] as? [String : AnyObject] else {
                    print("failed to find r totals")
                    return
                }
                // bothRuns
                guard let homeTeamR = bothRuns["home"] else {
                    print("failed to get r data 2")
                    return
                }
                // homeTeamR
                guard let awayTeamR = bothRuns["away"] else {
                    print("failed to get r data 3")
                    return
                }
                //awayTeamR
                
                guard let bothErrors = linescore["e"] as? [String : AnyObject] else {
                    print("failed to find e totals")
                    return
                }
                //bothErrors
                guard let homeTeamE = bothErrors["home"] else {
                    print("failed to get e data 2")
                    return
                }
                //homeTeamE
                guard let awayTeamE = bothErrors["away"] else {
                    print("failed to get e data 3")
                    return
                }
                //awayTeamE
                
                guard let bothHits = linescore["h"] as? [String : AnyObject] else {
                    print("failed to find e totals")
                    return
                }
                //bothHits
                guard let homeTeamH = bothHits["home"] else {
                    print("failed to get h data 2")
                    return
                }
                //homeTeamH
                guard let awayTeamH = bothHits["away"] else {
                    print("failed to get h data 3")
                    return
                }
                // awayTeamH
                
                
                
                
                //use the dictionary
                print("Home team is: \(homeTeamName) and the away team is: \(awayTeamName)")
                
                //adding elements to wins dictionaries
                homeTeamWins.append(homeTeamWin)
                awayTeamWins.append(awayTeamWin)
                
                //adding elements to team names dictionaries
                homeTeam.append(homeTeamName)
                awayTeam.append(awayTeamName)
                
                //adding elements to losses dictionaries
                homeTeamLosses.append(homeTeamLoss)
                awayTeamLosses.append(awayTeamLoss)
                
                //adding elements to winning pitcher dictionary
                winningPitchers.append(winningPitcherName)
                
                //losing pitcher
                losingPitchers.append(losingPitcherName)
                
                //homerun counts for each team
                homeTeamHomeRuns.append(homeTeamHR)
                awayTeamHomeRuns.append(awayTeamHR)
                
                //run counts for each team
                homeTeamRuns.append(homeTeamR)
                awayTeamRuns.append(awayTeamR)
                
                //error counts for each team
                homeTeamErrors.append(homeTeamE)
                awayTeamErrors.append(awayTeamE)
                
                //hit counts for each team
                homeTeamHits.append(homeTeamH)
                awayTeamHits.append(awayTeamH)
                
                
                matchup.append("\(homeTeam[count]) vs. \(awayTeam[count])")
                
                count += 1
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
    //------------------------------------------------------------------------------------------------------------
    
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
        
        //print(year)
        //print(month)
        // print(day)
        
        
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
        
        //address
        
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

    
    override func viewDidLoad() {
        getMyJSON()
    }
}

class scoresListViewController : UIViewController , UITableViewDataSource, UITableViewDelegate {

    var team1 = "Teams"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        self.tableView.dataSource = self
        self.tableView.delegate = self

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return homeTeam.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        

        cell.textLabel!.text = matchup[indexPath.row]
        cell.backgroundColor = UIColor.lightGrayColor()
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.team1 = matchup[indexPath.row]
        self.performSegueWithIdentifier("mainToOtherSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var homeTeamSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamSending.team1 = self.team1
    }
    
}

class scoreSummaryViewController : UIViewController {
    
    var team1 = "Teams"

    
    @IBOutlet weak var bothTeams: UILabel!
 
    override func viewDidLoad() {
        
        self.bothTeams.text = team1
        
        //view.backgroundColor = UIColor.blueColor()
    }
}