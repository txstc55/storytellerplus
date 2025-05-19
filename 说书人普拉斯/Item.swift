//
//  Item.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/18/25.
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
