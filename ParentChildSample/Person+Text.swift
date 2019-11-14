//
//  Person+Text.swift
//  ParentChildSample
//
//  Created by K Y on 10/22/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

extension Person {
    
    override public var description: String {
        let t =
        """
        Name: \(name!)
        Age: \(age)
        Occupation: \(occupation!)
        """
        return t
    }
    /*
    var name: String? {
        get {
            return firstName
        }
        set {
            firstName = newValue
        }
    }
 */
}
