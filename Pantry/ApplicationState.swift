//
//  ApplicationState.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 5/2/18.
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import Foundation
import os.log

class ApplicationState {
    
    /// Pantry Functions
    ///
    ///
    ///
    static func savePantry(pantryList: [PantryItem]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(pantryList, toFile: PantryItem.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Pantry successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save pantry...", log: OSLog.default, type: .error)
        }
    }
    
    static func addPantryItem(item: PantryItem) {
        var pantryList:[PantryItem]
        let pantry = loadPantry()
        
        if (pantry != nil) {
            pantryList = pantry!
        } else {
            pantryList = [PantryItem]()
        }
        
        pantryList.append(item)
        savePantry(pantryList: pantryList)
    }
    
    static func loadPantry() -> [PantryItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: PantryItem.ArchiveURL.path) as? [PantryItem]
    }
    
    
    
    ///Grocery functions
    ///
    ///
    ///
    static func saveGroceries(groceryList: [GroceryItem]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(groceryList, toFile: GroceryItem.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Groceries successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save groceries...", log: OSLog.default, type: .error)
        }
    }
    
    static func addGroceryItem(item: GroceryItem) {
        var groceryList:[GroceryItem]
        let grocery = loadGroceries()
        
        if (grocery != nil) {
            groceryList = grocery!
        } else {
            groceryList = [GroceryItem]()
        }
        
        groceryList.append(item)
        saveGroceries(groceryList: groceryList)
    }
    
    static func loadGroceries() -> [GroceryItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GroceryItem.ArchiveURL.path) as? [GroceryItem]
    }
}
