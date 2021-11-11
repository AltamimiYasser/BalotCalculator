//
//  StringExt.swift
//  BalotCal
//
//  Created by Yasser Tamimi on 11/11/2021.
//

import Foundation

extension String {
    
    /// check if the string is a number
    var isInt: Bool {
        return Int(self) != nil
    }
}
