//
//  MovieDetailViewController.swift
//  rottenTomatoesiPhoneApp
//
//  Created by Bhagchandani, Deepak on 9/25/14.
//  Copyright (c) 2014 Bhagchandani, Deepak. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    var movie : NSDictionary?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadingIndicator.startAnimating()
        // Do any additional setup after loading the view.
        self.title = movie?.valueForKey("title") as? NSString
        
        movieDescription.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        movieDescription.text = movie?.valueForKey("synopsis") as? NSString
        
        var syn = movie?.valueForKey("synopsis") as? NSString
        
        var newsyn = NSAttributedString(string: syn!)

        var urlString : String = movie?.valueForKeyPath("posters.original") as NSString
        urlString = urlString.stringByReplacingOccurrencesOfString("tmb", withString:"ori")
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            var myImage = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.movieImage.image = myImage
                self.movieImage.alpha = 0
                self.loadingIndicator.stopAnimating()
                UIImageView.animateWithDuration(0.8, animations: { () -> Void in
                    self.movieImage.alpha = 1
                    
                })
                
            })
        }
        
      movieDescription.sizeToFit()
        scrollView.contentSize.height = movieDescription.frame.height + movieDescription.frame.origin.y
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
