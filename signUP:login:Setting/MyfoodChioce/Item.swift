//
//  Item.swift
//  MyfoodChioce
//
//  Created by 刘超 on 16/12/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
