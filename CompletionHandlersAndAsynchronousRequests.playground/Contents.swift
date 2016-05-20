//: Playground - noun: a place where people can play

import UIKit
import XCPlayground



class ViewController : UIViewController {
    
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
        
        address
        
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
    
    // This is the method that will run as soon as the view controller is created
    override func viewDidLoad() {
        
        // Sub-classes of UIViewController must invoke the superclass method viewDidLoad in their
        // own version of viewDidLoad()
        super.viewDidLoad()
        
        // Make the view's background be gray
        view.backgroundColor = UIColor.lightGrayColor()
        
        /*
         * Further define label that will show JSON data
         */
        
        // Set the label text and appearance
        jsonResult.text = "..."
        jsonResult.font = UIFont.systemFontOfSize(12)
        jsonResult.numberOfLines = 0   // makes number of lines dynamic
        // e.g.: multiple lines will show up
        jsonResult.textAlignment = NSTextAlignment.Center
        
        // Required to autolayout this label
        jsonResult.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the label to the superview
        view.addSubview(jsonResult)
        
        /*
         * Add a button
         */
        let getData = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        
        // Make the button, when touched, run the calculate method
        getData.addTarget(self, action: #selector(ViewController.getMyJSON), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Set the button's title
        getData.setTitle("Get my JSON!", forState: UIControlState.Normal)
        
        // Required to auto layout this button
        getData.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the button into the super view
        view.addSubview(getData)
        
        /*
         * Layout all the interface elements
         */
        
        // This is required to lay out the interface elements
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Create an empty list of constraints
        var allConstraints = [NSLayoutConstraint]()
        
        // Create a dictionary of views that will be used in the layout constraints defined below
        let viewsDictionary : [String : AnyObject] = [
            "title": jsonResult,
            "getData": getData]
        
        // Define the vertical constraints
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-50-[getData]-[title]",
            options: [],
            metrics: nil,
            views: viewsDictionary)
        
        // Add the vertical constraints to the list of constraints
        allConstraints += verticalConstraints
        
        // Activate all defined constraints
        NSLayoutConstraint.activateConstraints(allConstraints)
        
    }
    
}

// Embed the view controller in the live view for the current playground page
XCPlaygroundPage.currentPage.liveView = ViewController()
// This playground page needs to continue executing until stopped, since network reqeusts are asynchronous
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
