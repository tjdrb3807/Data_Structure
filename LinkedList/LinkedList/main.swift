//
//  main.swift
//  LinkedList
//
//  Created by 전성규 on 11/18/24.
//

import Foundation

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    var isEmpty: Bool { head == nil }
    
    mutating func push(_ data: T) {
        head = Node(data: data, next: head)
        if tail == nil { tail = head }
    }
}

var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print(list)
