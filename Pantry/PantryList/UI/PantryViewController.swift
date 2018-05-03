
//
//  FirstViewController.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 6/19/17
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import UIKit
import os.log

class PantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var pantryTableView: UITableView!
    var pantryList = [PantryItem]()
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set table view delegate and datasource
        pantryTableView.delegate = self
        pantryTableView.dataSource = self
        pantryTableView.isUserInteractionEnabled = true
        
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
    }
    
    //takes care of setup-- retrieves persisted data
    //and loads tableview
    private func load() {
        let pantry = ApplicationState.loadPantry()
        
        if (pantry != nil) {
            pantryList = pantry!
        } else {
            pantryList = [PantryItem]()
        }
        pantryTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TABLE VIEW functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pantryList.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = pantryTableView.dequeueReusableCell(withIdentifier: "pantryItemCell") as! PantryItemCell
        let pantryItem = pantryList[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        cell.foodText?.text = pantryItem.Name
        cell.boughtLabel?.text = "Bought " + pantryItem.Bought.description.split(separator: " ")[0]
        cell.expireLabel?.text = "Exp " + pantryItem.Exp.description.split(separator: " ")[0]
        cell.finishedButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    //IBAction Function
    //Finished button- gives option to move item to grocery list
    //or just delete it from the pantry
    @IBAction func finishedItem(_ sender: UIButton) {
        let pantryItem = pantryList[sender.tag]
        
        //Create alertcontroller
        let alertController = UIAlertController(title: "Finished item : " + pantryItem.Name, message: "Do you wish to move to groceries " + "or just remove it?", preferredStyle: .alert)
        
        // Create Remove button
        let OKAction = UIAlertAction(title: "Remove", style: .default) { (action:UIAlertAction!) in
            
            let index = self.pantryList.index(of: pantryItem)
            self.pantryList.remove(at: index!)
            ApplicationState.savePantry(pantryList: self.pantryList)
            self.pantryTableView.reloadData()
            
        }
        alertController.addAction(OKAction)
        
        // Create Move to groceries button
        let MoveAction = UIAlertAction(title: "Move to Groceries", style: .default) { (action:UIAlertAction!) in
            
            let index = self.pantryList.index(of: pantryItem)
            self.pantryList.remove(at: index!)
            ApplicationState.savePantry(pantryList: self.pantryList)
            self.pantryTableView.reloadData()
            ApplicationState.addGroceryItem(item: GroceryItem(name: pantryItem.Name, amount: pantryItem.Amount))
            
        }
        alertController.addAction(MoveAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
    }

}

