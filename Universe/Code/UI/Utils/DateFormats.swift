//
//  DateFormats.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//
import Foundation

extension Date {
    
    func stringFromDate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d.MM"
            return dateFormatter.string(from:self)
    }
}
