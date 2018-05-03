//
//  CreatePantryItemViewController.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 5/2/18.
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import UIKit

class CreatePantryItemViewController: UIViewController {
    var groceryItem : GroceryItem?
    
    @IBOutlet weak var foodNameText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var foodAmountText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = UIDatePickerMode.date
        
        //pre-fill fields if the information to do so
        //is available
        //(this happens if we come from the grocery list)
        if (groceryItem != nil) {
            foodNameText.text = groceryItem!.Name
            foodAmountText.text = groceryItem!.Amount
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //cancel button IB Action
    @IBAction func cancelCreate(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Finish button IB Action
    //Save and dismiss
    @IBAction func createPantryItem(_ sender: UIButton) {
        if (foodNameText.text != nil && foodAmountText.text != nil) {
            ApplicationState.addPantryItem(item: PantryItem(
                name: foodNameText.text!, bought: Date(), exp: datePicker.date, amount: foodAmountText.text!))
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
