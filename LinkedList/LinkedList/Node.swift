//
//  Node.swift
//  LinkedList
//
//  Created by 전성규 on 11/18/24.
//

import Foundation

class Node<T> {
    var data: T
    var next: Node?
    
    init(data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else { return "\(data)" }
        
        return "\(data) -> " + String(describing: next) + " "
    }
}
