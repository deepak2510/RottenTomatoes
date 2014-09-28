//
//  MovieListFetcher.swift
//  rottenTomatoesApp
//
//  Created by Bhagchandani, Deepak on 9/22/14.
//  Copyright (c) 2014 Bhagchandani, Deepak. All rights reserved.
//

import UIKit

class MovieListFetcher: NSObject {
 
    var movies : [NSDictionary] = []
    var apikey = "ybgwt67rjvjfrsuz5b4wx789"
    var RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey="
    
    func formUrl() -> String {
    
        return self.RottenTomatoesURLString + self.apikey
    }
    
    func getMovies() -> NSDictionary {
    
      
        let request = NSMutableURLRequest(URL: NSURL(string : self.formUrl())!)
        var mydic : NSDictionary = NSDictionary()
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            mydic = dictionary
        
        })
     return mydic
    }
    
    func getMovieDetail(withID : Int) -> String{
        
        //Look up the array of movies and get a particular movie with the id passed. 
        //Return the movie.
        return "HARIBOL"
    }
    
}

