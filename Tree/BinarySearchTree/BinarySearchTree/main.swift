//
//  main.swift
//  BinarySearchTree
//
//  Created by 전성규 on 11/20/24.
//

import Foundation

class Node<T: Comparable> {
    var value: T
    var leftChildNode: Node<T>?
    var rightChildNode: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}

class BinarySearchTree<T: Comparable> {
    var rootNode: Node<T>?
    
    func insert(_ value: T) {
        guard let rootNode = self.rootNode else { return self.rootNode = Node(value: value) }
        var crtSearchLocation = rootNode
        
        while true {
            if crtSearchLocation.value == value {
                return print("The binary search tree cannot have the same value.")
            } else if crtSearchLocation.value > value {
                guard let childNode = crtSearchLocation.leftChildNode else { return crtSearchLocation.leftChildNode = Node(value: value) }
                crtSearchLocation = childNode
            } else {
                guard let childNode = crtSearchLocation.rightChildNode else { return crtSearchLocation.rightChildNode = Node(value: value) }
                crtSearchLocation = childNode
            }
        }
    }
    
    func isContain(from value: T) -> Bool {
        if rootNode == nil { return false }
        var node = rootNode
        
        while let crtSearchLocation = node {
            if crtSearchLocation.value == value {
                return true
            } else if crtSearchLocation.value > value {
                node = crtSearchLocation.leftChildNode
            } else {
                node = crtSearchLocation.rightChildNode
            }
        }
        
        return false
    }
}

extension BinarySearchTree {
    func drawDiagram() {
        print(diagram(for: self.rootNode))
    }
     
    private func diagram(for node: Node<T>?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
       guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChildNode == nil && node.rightChildNode == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChildNode, top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChildNode, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

let BST = BinarySearchTree<Int>()
BST.insert(30)
BST.insert(20)
BST.insert(10)
BST.insert(50)

BST.drawDiagram()

print(BST.isContain(from: 50))
print(BST.isContain(from: 9))




