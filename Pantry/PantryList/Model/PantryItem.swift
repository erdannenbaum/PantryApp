//
//  PantryItem.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 5/2/18.
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import Foundation
import os.log

class PantryItem : NSObject, NSCoding {
    
    //Static variables for storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("pantry")
    
    //Encoding and decoding functions
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: PropertyKey.name)
        aCoder.encode(Bought, forKey: PropertyKey.bought)
        aCoder.encode(Exp, forKey: PropertyKey.exp)
        aCoder.encode(Amount, forKey: PropertyKey.amount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Name = (aDecoder.decodeObject(forKey: PropertyKey.name) as? String)!
        self.Bought = (aDecoder.decodeObject(forKey: PropertyKey.bought) as? Date)!
        self.Exp = (aDecoder.decodeObject(forKey: PropertyKey.exp) as? Date)!
        self.Amount = (aDecoder.decodeObject(forKey: PropertyKey.amount) as? String)!
    }
    
    //variables and initialization
    var Name: String
    var Bought: Date
    var Exp: Date
    var Amount : String
    
    init(name: String?, bought: Date, exp: Date, amount : String) {
        self.Name = name ?? ""
        self.Bought = bought
        self.Exp = exp
        self.Amount = amount
    }
    
    //PROPERTIES
    struct PropertyKey {
        static let name = "name"
        static let bought = "bought"
        static let exp = "exp"
        static let amount = "amount"
    }
}
