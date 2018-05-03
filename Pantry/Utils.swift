//
//  Utils.swift
//  Pantry
//
//  Created by Eric Dannenbaum on 5/1/18.
//  Copyright © 2018 Eric Dannenbaum. All rights reserved.
//

import Foundation

class Utils {
    //Utility function
    static func from(_ year: Int, _ month: Int, _ day: Int) -> Date?
    {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: gregorianCalendar, year: year, month: month, day: day)
        return gregorianCalendar.date(from: dateComponents)
    }
}
