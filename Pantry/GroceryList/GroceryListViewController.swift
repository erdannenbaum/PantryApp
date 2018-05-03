//
//  SecondViewController.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 6/19/17
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var groceryTableView: UITableView!
    var groceryList = [GroceryItem]()
    var editMode = false
    
    //setup functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview setup
        groceryTableView.delegate = self
        groceryTableView.dataSource = self
        groceryTableView.isUserInteractionEnabled = true
        
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        load()
    }
    
    private func load() {
        
        let grocery = ApplicationState.loadGroceries()
        
        if (grocery != nil) {
            groceryList = grocery!
        } else {
            groceryList = [GroceryItem]()
        }
        
        groceryTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Action func for delete button, changes into editing mode
    //so that items can be deleted from the list
    @IBAction func deleteButtonPressed(_ sender: Any) {
        editMode = !editMode
        
        if (editMode) {
            deleteButton.setTitle("Done", for: UIControlState.normal)
        } else {
            deleteButton.setTitle("Edit", for: UIControlState.normal)
        }
    }
    
    //function to create a new grocery item
    //IBAction for Add button in top right corner
    @IBAction func addGroceryItem(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New grocery item", message: "Enter name and amount needed", preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "Add", style: .default) { (action:UIAlertAction!) in
            let textField = alertController.textFields![0] as UITextField
            let textField2 = alertController.textFields![1] as UITextField
            ApplicationState.addGroceryItem(item: GroceryItem(name: textField.text!, amount: textField2.text!))
            self.load()
            
        }
        alertController.addAction(OKAction)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter item name"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter amount needed"
        }
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    //Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = groceryTableView.dequeueReusableCell(withIdentifier: "groceryItemCell") as! GroceryItemCell
        let groceryItem = groceryList[indexPath.row]
        cell.nameLabel.text = groceryItem.Name
        cell.amountLabel.text = groceryItem.Amount
        cell.boughtButton.tag = indexPath.row
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let groceryItem = groceryList[indexPath.row]
        
        if (editMode) {
            //create alert controller to confirm deleting item
            
            let alertController = UIAlertController(title: "Delete Item : " + groceryItem.Name, message: "Do you wish to proceed?", preferredStyle: .alert)
            
            
            
            // Create yes button
            let OKAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
                
                let index = self.groceryList.index(of: groceryItem)
                self.groceryList.remove(at: index!)
                ApplicationState.saveGroceries(groceryList: self.groceryList)
                self.groceryTableView.reloadData()
                
            }
            alertController.addAction(OKAction)
            
            // Create no button
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction!) in
                print("Cancel button tapped");
            }
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion:nil)
        } else {
            //let next:PantryItemViewController = PantryItemViewController()
            //self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    //send information to CreatePantryViewController
    //to make the process easier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let s = sender as! UIButton
        let item = groceryList[s.tag]
        
        self.groceryList.remove(at: s.tag)
        ApplicationState.saveGroceries(groceryList: self.groceryList)
        let destinationVC = segue.destination as! CreatePantryItemViewController
        destinationVC.groceryItem = item
    }
}

