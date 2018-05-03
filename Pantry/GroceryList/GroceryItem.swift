//
//  GroceryItem.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 5/2/18.
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import Foundation

class GroceryItem : NSObject, NSCoding {
    
    //Static variables for storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("grocery")
    
    //Encoding and decoding functions
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: PropertyKey.name)
        aCoder.encode(Amount, forKey: PropertyKey.amount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Name = (aDecoder.decodeObject(forKey: PropertyKey.name) as? String)!
        self.Amount = (aDecoder.decodeObject(forKey: PropertyKey.amount) as? String)!
    }
    
    //properties for encoding
    struct PropertyKey {
        static let name = "name"
        static let amount = "amount"
    }
    
    
    //variables and initialization
    var Name: String
    var Amount: String
    
    init(name: String?, amount : String) {
        self.Name = name ?? ""
        self.Amount = amount
    }
}
