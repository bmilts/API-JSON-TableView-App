//
//  ViewController.swift
//  JSONTableView
//
//  Created by Brendan Milton on 03/08/2019.
//  Copyright © 2019 Brendan Milton. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit
import Alamofire

class ViewController: UITableViewController {
    
    // JSON variables
    let url = "https://api.nytimes.com/svc/topstories/v2/business.json?api-key=lC2xyS5VqTK4ud8mhkt2309EI7KXglMn"
    var headlines = [String]()
    var abstracts = [String]()
    var images = [String]()
    var urls = [URL]()
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        webView = WKWebView()
        getJSON()
        
        var titleView : UIImageView
        let frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        titleView = UIImageView(frame: frame)
        titleView.contentMode = .scaleAspectFit
        titleView.image = UIImage(named: "nytImage")
        
        self.navigationItem.titleView = titleView
    }

    func getJSON() {
        
        Alamofire.request(url).responseJSON { (response) in
            
            if response.result.value != nil {
                
                // Convert the responseJSON to SwiftyJson
                let json = JSON(response.result.value!)
                
                // Get JSON results as an array
                let results = json["results"].arrayValue
                
                // loop through results for required data
                for result in results {
                    
                    let headlines = result["title"].stringValue
                    let abstracts = result["abstract"].stringValue
                    let images = result["multimedia"][0]["url"].stringValue
                    let urls = result["url"].url

                    // Add each value to the empty arrays set up
                    self.headlines.append(headlines)
                    self.abstracts.append(abstracts)
                    self.images.append(images)
                    self.urls.append(urls!)
                }
                
                // Reload the data on the main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return headlines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JSONCell", for: indexPath) as! JSONTableViewCell
        
        cell.cellLabel.text = self.headlines[indexPath.row]
        cell.cellDetailText.text = self.abstracts[indexPath.row]
        cell.cellImageView.loadCachedImageURLString(self.images[indexPath.row])

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        webView.load(URLRequest(url: self.urls[indexPath.row]))
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
        // Back button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goBack))
//        self.navigationItem.hidesBackButton = true
//        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.bordered, target: self, action: "back:")
//        self.navigationItem.leftBarButtonItem = newBackButton;
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
}

