//
//  scoresListViewController.swift
//  JSON - UI Assignment Scoreboard App
//
//  Created by Student on 2016-05-17.
//  Copyright © 2016 Maxym Dubczak. All rights reserved.
//

import Foundation
import UIKit

//create variables and dictionaries that will be populated during parsing
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


//opening page view conntoller
class openingViewController : UIViewController {
    
    
    
    // Views that need to be accessible to all methods
    let jsonResult = UILabel()
    
    // ---------------If data is successfully retrieved from the server, we can parse it here----------------
    func parseMyJSON(theData : NSData) {
        
        
        // De-serializing JSON can throw errors, so should be inside a do-catch structure
        do {
            
            
            let data = try NSJSONSerialization.JSONObjectWithData(theData, options: NSJSONReadingOptions.AllowFragments)
            
            //parsing into first layer of data
            guard let scoreboardData = data as? [String : AnyObject] else {
                print("had a problem with first few levels of JSON parsing")
                return
                
            }
            
            //continuing parsing
            guard let firstLayer = scoreboardData["data"] as? [String : AnyObject] else {
                print ("problem with first layer parsing")
                return
            }
            
            //continuing parsing
            guard let games = firstLayer["games"] as? [String : AnyObject] else {
                print("had a problem with layer 3")
                return
            }
           
           //parsing into array of games
            guard let game : [AnyObject] = games["game"] as? [AnyObject] else {
                print("problem with layer 4")
                return
            }
           
            
            
            // Iterate over each game
            for i in game {
                
                // Cast this AnyObject into a dictionary of type [ String : AnyObject ]
                guard let gameData  = i as? [String : AnyObject] else {
                    print("could not parse data for a game")
                    return
                    
                }
                
                //finding home team name
                guard let homeTeamName = gameData["home_team_name"] else {
                    print("could not find location")
                    return
                }
                
                //finding away team name
                guard let awayTeamName = gameData["away_team_name"] else {
                    print("could not find location")
                    return
                }
                
                //finding how many wins the home team has
                guard let homeTeamWin = gameData["home_win"] else {
                    print("could not homw wins")
                    return
                }
                
                //finding how many wins the away team has
                guard let awayTeamWin = gameData["away_win"] else {
                    print("could not find away wins")
                    return
                }
                
                
                //finding how many losses the home team has
                guard let homeTeamLoss = gameData["home_loss"] else {
                    print("could not home wins")
                    return
                }
                
                //finding how many losses the away team has
                guard let awayTeamLoss = gameData["away_loss"] else {
                    print("could not find away wins")
                    return
                }
                
                //finding name of winning pitcher
                guard let winningPitcher = gameData["winning_pitcher"] as? [String : AnyObject] else {
                    print("could not find winning pitcher")
                    return
                }
                
                //finding last name of winning pitcher
                guard let winningPitcherName = winningPitcher["last"]  else {
                    print("could not find pitcher last name")
                    return
                }
                
                // finding losing pitcher name
                guard let losingPitcher = gameData["losing_pitcher"] as? [String : AnyObject] else {
                    print("could not find losing pitcher")
                    return
                }
                
                //finding losing pitcher last name
                guard let losingPitcherName = losingPitcher["last"] else {
                    print("could not find losing pitcher")
                    return
                }
                
                // parsing into the linescore to find runs, hits, etc.
                guard let linescore = gameData["linescore"] as? [String : AnyObject] else {
                    print("failed to parse linescore")
                    return
                }
                
                // finding both team home runs
                guard let bothHomeRuns = linescore["hr"] as? [String : AnyObject] else {
                    print("failed to find hr totals")
                    return
                }
                
                // finding home team home runs
                guard let homeTeamHR = bothHomeRuns["home"] else {
                    print("failed to get hr data 2")
                    return
                }
                
                //finding away team home runs
                guard let awayTeamHR = bothHomeRuns["away"] else {
                    print("failed to get hr data 3")
                    return
                }
                
                //finding both teams runs
                guard let bothRuns = linescore["r"] as? [String : AnyObject] else {
                    print("failed to find r totals")
                    return
                }
                
                // finding home teams runs
                guard let homeTeamR = bothRuns["home"] else {
                    print("failed to get r data 2")
                    return
                }
                
                // finding away teams runs
                guard let awayTeamR = bothRuns["away"] else {
                    print("failed to get r data 3")
                    return
                }
                
                //finding both teams errors
                guard let bothErrors = linescore["e"] as? [String : AnyObject] else {
                    print("failed to find e totals")
                    return
                }
                
                //finding home team errrors
                guard let homeTeamE = bothErrors["home"] else {
                    print("failed to get e data 2")
                    return
                }
                
                //finding away team errors
                guard let awayTeamE = bothErrors["away"] else {
                    print("failed to get e data 3")
                    return
                }
                
                //finding both team hits
                guard let bothHits = linescore["h"] as? [String : AnyObject] else {
                    print("failed to find e totals")
                    return
                }
                
                //finding home team hits
                guard let homeTeamH = bothHits["home"] else {
                    print("failed to get h data 2")
                    return
                }
                
                //finding away team hits
                guard let awayTeamH = bothHits["away"] else {
                    print("failed to get h data 3")
                    return
                }
                
                
                //use the dictionary
                print("Parsing successful!!!")
                
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
                
                //populating matchups dictionary
                matchup.append("\(homeTeam[count]) vs. \(awayTeam[count])")
                
                //counting the games
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

    //gets JSON before page loads
    override func viewDidLoad() {
        getMyJSON()
    }
}

//second page view controller with table
class scoresListViewController : UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    //creating variables to send values of dictionaries to next page
    var team1 = "Teams"
    var winningPitcher1 = "Winning Pitcher"
    var losingPitcher1 = "Losing Pitcher"
    var homeTeamRuns1 = "0"
    var awayTeamRuns1 = "0"
    var homeTeamWins1 = "0"
    var homeTeamLosses1 = "0"
    var awayTeamWins1 = "0"
    var awayTeamLosses1 = "0"
    var homeTeamHits1 = "0"
    var awayTeamHits1 = "0"
    var homeTeamHomeRuns1 = "0"
    var awayTeamHomeRuns1 = "0"
    var homeTeamErrors1 = "0"
    var awayTeamErrors1 = "0"
    
    //creating table in code
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {

        self.tableView.dataSource = self
        self.tableView.delegate = self

        
    }
    
    //home many rows will the table have
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return homeTeam.count
        
    }
    
    //what will be in each of the cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        

        cell.textLabel!.text = matchup[indexPath.row]
       // cell.backgroundColor = UIColor.lightGrayColor()
        
        
        return cell
    }
    
    //what happens when a row is pressed
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //sets variables to index at row pressed
        self.team1 = matchup[indexPath.row]
        self.winningPitcher1 = winningPitchers[indexPath.row] as! String
        self.losingPitcher1 = losingPitchers[indexPath.row] as! String
        self.homeTeamRuns1 = homeTeamRuns[indexPath.row] as! String
        self.awayTeamRuns1 = awayTeamRuns[indexPath.row] as! String
        self.homeTeamWins1 = homeTeamWins[indexPath.row] as! String
        self.homeTeamLosses1 = homeTeamLosses[indexPath.row] as! String
        self.awayTeamWins1 = awayTeamWins[indexPath.row] as! String
        self.awayTeamLosses1 = awayTeamLosses[indexPath.row] as! String
        self.homeTeamHits1 = homeTeamHits[indexPath.row] as! String
        self.awayTeamHits1 = awayTeamHits[indexPath.row] as! String
        self.homeTeamHomeRuns1 = homeTeamHomeRuns[indexPath.row] as! String
        self.awayTeamHomeRuns1 = awayTeamHomeRuns[indexPath.row] as! String
        self.homeTeamErrors1 = homeTeamErrors[indexPath.row] as! String
        self.awayTeamErrors1 = awayTeamErrors[indexPath.row] as! String
        
        //runs segue
        self.performSegueWithIdentifier("mainToOtherSegue", sender: self)
    }
    
    //sending the contents of my created variables at the right index to the next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let homeTeamSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamSending.team1 = self.team1
        
        let losingPitcherSending = segue.destinationViewController as! scoreSummaryViewController
        losingPitcherSending.losingPitcher1 = self.losingPitcher1
        
        let winningPitcherSending = segue.destinationViewController as! scoreSummaryViewController
        winningPitcherSending.winningPitcher1 = self.winningPitcher1
        
        let homeTeamRunsSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamRunsSending.homeTeamRuns1 = self.homeTeamRuns1
        
        let awayTeamRunsSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamRunsSending.awayTeamRuns1 = self.awayTeamRuns1
        
        let homeTeamWinsSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamWinsSending.homeTeamWins1 = self.homeTeamWins1
        
        let homeTeamLossesSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamLossesSending.homeTeamLosses1 = self.homeTeamLosses1
        
        let awayTeamWinsSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamWinsSending.awayTeamWins1 = self.awayTeamWins1
        
        let awayTeamLossesSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamLossesSending.awayTeamLosses1 = self.awayTeamLosses1
        
        let homeTeamHitsSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamHitsSending.homeTeamHits1 = self.homeTeamHits1
        
        let awayTeamHitsSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamHitsSending.awayTeamHits1 = self.awayTeamHits1
        
        let homeTeamHomeRunsSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamHomeRunsSending.homeTeamHomeRuns1 = self.homeTeamHomeRuns1
        
        let awayTeamHomeRunsSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamHomeRunsSending.awayTeamHomeRuns1 = self.awayTeamHomeRuns1
        
        let homeTeamErrorsSending = segue.destinationViewController as! scoreSummaryViewController
        homeTeamErrorsSending.homeTeamErrors1 = self.homeTeamErrors1
        
        let awayTeamErrorsSending = segue.destinationViewController as! scoreSummaryViewController
        awayTeamErrorsSending.awayTeamErrors1 = self.awayTeamErrors1

    }
    
}

//score summary view controller
class scoreSummaryViewController : UIViewController {
    
    //variables which recieved information about what to display from previous view controller
    var team1 = "Teams"
    var winningPitcher1 = "Winning Pitcher"
    var losingPitcher1 = "Losing Pitcher"
    var homeTeamRuns1 = "0"
    var awayTeamRuns1 = "0"
    var homeTeamWins1 = "0"
    var homeTeamLosses1 = "0"
    var awayTeamWins1 = "0"
    var awayTeamLosses1 = "0"
    var homeTeamHits1 = "0"
    var awayTeamHits1 = "0"
    var homeTeamHomeRuns1 = "0"
    var awayTeamHomeRuns1 = "0"
    var homeTeamErrors1 = "0"
    var awayTeamErrors1 = "0"


    //create all of the used labels in code
    @IBOutlet weak var bothTeams: UILabel!
    @IBOutlet weak var winningPitcherLabel: UILabel!
    @IBOutlet weak var homeTeamRunsLabel: UILabel!
    @IBOutlet weak var awayTeamRunsLabel: UILabel!
    @IBOutlet weak var losingPitcherLabel: UILabel!
    @IBOutlet weak var homeTeamRecord: UILabel!
    @IBOutlet weak var awayTeamRecord: UILabel!
    @IBOutlet weak var homeTeamHitsLabel: UILabel!
    @IBOutlet weak var awayTeamHitsLabel: UILabel!
    @IBOutlet weak var homeTeamErrorsLabel: UILabel!
    @IBOutlet weak var homeTeamHomeRunsLabel: UILabel!
    @IBOutlet weak var awayTeamHomeRunsLabel: UILabel!
    @IBOutlet weak var awayTeamErrorsLabel: UILabel!
    
    override func viewDidLoad() {
        
        //tells swift what to display in each label
        self.bothTeams.text = team1
        self.winningPitcherLabel.text = "WP: \(winningPitcher1)"
        self.losingPitcherLabel.text = "LP: \(losingPitcher1)"
        self.homeTeamRunsLabel.text = homeTeamRuns1
        self.awayTeamRunsLabel.text = awayTeamRuns1
        self.homeTeamRecord.text = "(\(homeTeamWins1) - \(homeTeamLosses1))"
        self.awayTeamRecord.text = "(\(awayTeamWins1) - \(awayTeamLosses1))"
        self.homeTeamHitsLabel.text = "Hits:\(homeTeamHits1)"
        self.awayTeamHitsLabel.text = "Hits:\(awayTeamHits1)"
        self.homeTeamHomeRunsLabel.text = "Home Runs:\(homeTeamHomeRuns1)"
        self.awayTeamHomeRunsLabel.text = "Home Runs:\(awayTeamHomeRuns1)"
        self.homeTeamErrorsLabel.text = "Errors:\(homeTeamErrors1)"
        self.awayTeamErrorsLabel.text = "Errors:\(awayTeamErrors1)"
        
        
    }
}