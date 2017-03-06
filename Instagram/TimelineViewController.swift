//
//  TimelineViewController.swift
//  Instagram
//
//  Created by Julian Test on 3/1/17.
//  Copyright © 2017 Julian Bossiere. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import ParseUI

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var posts: [PFObject]?
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 416
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        //LOAD DATA FROM PARSE
        displayPosts()
        
        //PULL TO REFRESH
//        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(displayPosts), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        //ADD OBSERVER FOR OTHER VIEW CONTROLLER TO RELOAD DATA
        NotificationCenter.default.addObserver(self, selector: #selector(displayPosts), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    /*
     - Construct PFQuery
     - fetch data asynchronously
     */
    func displayPosts() {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
            } else {
                print("error: \(error?.localizedDescription)")
            }
            MBProgressHUD.hide(for: self.view, animated: true)
            self.refreshControl.endRefreshing()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts != nil {
            return (posts?.count)!
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaPostCell", for: indexPath) as! InstaPostCell
        cell.selectionStyle = .none
        cell.post = posts?[indexPath.row]
        
        return cell
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func onLogout(_ sender: Any) {
//        PFUser.logOutInBackground { (error: Error?) in
//            // PFUser.currentUser() will now be nil
//            self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
