//
//  RecipeViewController.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 6/19/17
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import UIKit
import Foundation

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var recipeTableView: UITableView!
    var titles = [String]()
    var links = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getJsonFromUrl()
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: "https://www.reddit.com/r/recipes/new.json?sort=top")
        
        //fetching the data from the url
        let task = URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    let dataDic = jsonSerialized!["data"] as? [String:Any]
                    let children = dataDic!["children"] as? [[String:Any]]
                    
                    for child in children! {
                        let dataDic2 = child["data"] as? [String:Any]
                        
                        if let name = dataDic2!["title"] as? String {
                            self.titles.append(name)
                        }
                        if let link = dataDic2!["permalink"] as? String {
                            self.links.append(link)
                        }
                    }
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        })
            
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "recipeCell") as! RecipeCell
        cell.titleLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let s = "http://reddit.com" + links[indexPath.row]
        UIApplication.shared.open(URL(string : s)!, options: [:], completionHandler: { (status) in
            
        })
    }
    
}

