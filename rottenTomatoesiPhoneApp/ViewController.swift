//
//  ViewController.swift
//  rottenTomatoesiPhoneApp
//
//  Created by Bhagchandani, Deepak on 9/23/14.
//  Copyright (c) 2014 Bhagchandani, Deepak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!

    var movies : NSMutableArray = []
    var allmovies : NSMutableArray = []
    var apikey = "ybgwt67rjvjfrsuz5b4wx789"
    var RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey="

    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.searchBar.delegate = self;
        self.navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        self.loadMovies()
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        self.refreshControl.addTarget(self, action: "loadMovies", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    
    }

    
    
    
    func loadMovies() -> Void {
    
        let request = NSMutableURLRequest(URL: NSURL(string : self.formUrl())!)
                
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            
            if(error == nil) {
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            self.allmovies = dictionary.valueForKeyPath("movies") as NSMutableArray
            self.movies = self.allmovies
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            } else {
                println("ERROR")
                var myError = error as NSError
             println(myError)
                println("ERROR DONE")
            }
            
        })

    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText != ""){
        self.movies = self.allmovies
       let resultPredicate = NSPredicate(format: "title contains[c] %@", searchText)
        var filteredMovies = self.allmovies.filteredArrayUsingPredicate(resultPredicate!)
        self.movies = NSMutableArray(array: filteredMovies)
        self.tableView.reloadData()
        } else {
            self.movies = self.allmovies
            self.tableView.reloadData()
        }
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func formUrl() -> String {
        
        return self.RottenTomatoesURLString + self.apikey
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "ShowMovieDetail")
        {
            var destinationViewController = segue.destinationViewController as MovieDetailViewController
            var sendingObject = sender as customCellTableViewCell
            
            var row = tableView.indexPathForCell(sendingObject)!.row
            
            destinationViewController.movie = movies[row] as? NSDictionary
            
            
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieListItem", forIndexPath: indexPath) as customCellTableViewCell
        
        cell.customTitle?.text = self.movies[indexPath.row].valueForKeyPath("title") as? String
        cell.customDescription?.text = self.movies[indexPath.row].valueForKeyPath("synopsis") as? String
        var urlString : String = self.movies[indexPath.row].valueForKeyPath("posters.original") as String
        urlString = urlString.stringByReplacingOccurrencesOfString("tmb", withString: "det")

     
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
           
           
            
           
            dispatch_async(dispatch_get_main_queue(), {
                let image = UIImage(data:data)
                cell.customImageView?.image = image
                cell.customImageView.alpha = 0
                UIImageView.animateWithDuration(0.8, animations: { () -> Void in
                    cell.customImageView.alpha = 1
                })
               
            })
            
        })
        
        return cell;
    }


}

