//
//  main.swift
//  BinarySearchTree
//
//  Created by 전성규 on 11/20/24.
//

import Foundation

class Node<T: Comparable> {
    let value: T
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
    
    func remove(from value: T) -> Bool {
        guard let rootNode = self.rootNode else { return false }
        var parentNode = rootNode
        var crtSearchLocation: Node? = rootNode
        
        while let node = crtSearchLocation {
            if node.value == value {
                break
            } else if node.value > value {
                crtSearchLocation = node.leftChildNode
            } else {
                crtSearchLocation = node.rightChildNode
            }
            parentNode = node
        }
        
        guard let removeNode = crtSearchLocation else { return false }
        
        if removeNode.leftChildNode == nil && removeNode.rightChildNode == nil {
            if parentNode.value > value {
                parentNode.leftChildNode = nil
            } else {
                parentNode.rightChildNode = nil
            }
            
            return true
        } else if removeNode.leftChildNode != nil && removeNode.rightChildNode == nil {
            if parentNode.value > value {
                parentNode.leftChildNode = removeNode.leftChildNode
            } else {
                parentNode.rightChildNode = removeNode.leftChildNode
            }
            
            return true
        } else if removeNode.leftChildNode == nil && removeNode.rightChildNode != nil {
            if parentNode.value > value {
                parentNode.leftChildNode = removeNode.rightChildNode
            } else {
                parentNode.rightChildNode = removeNode.rightChildNode
            }
            
            return true
        }
        
        // 3. Child Node가 두 개 존재하는 Node 삭제
        // 3-1. 삭제할 Node의 오른쪽 Child Node중, 가장 작은 값을 찾아 삭제할 Node의 Parent Node가 가리키게 한다.
        //   3-1-1. 오른쪽 Child Node중 가장 작은 값을 가진 Node에 오른쪽 Child Node가 존재할 경우
        //   3-1-2. 오른쪽 Child Node중 가장 작은 값을 가진 Node에 Child Node가 없을 경우
        //
        // 삭제할 Node의 오른쪽 Child Node 중에 가장 작은 값을 갖은 Node를 찾아 삭제할 Node의 Parent Node가 참조하게 한다.
        // 실제 코드에선 삭제할 Node의 Parent Node의 Edge를 가장 작은 값을 갖은 Node로 바꿔야 하며,
        // 때문에 삭제할 Node의 left, right를 다시 가장 작은 값을 갖은 Node의 left, right로 이식해야 한다.
        
        // 가장 작은 Node를 찾았는데 오른쪽 자식 노드를 갖고 있다??
        // 오른쪽 자식 노르를 change node의 부모 노드의 왼쪽 edge에 연결
        
        
        // 이진 탐색 트리는 삽입부터 이미 정렬되어 있는 구조이므로 오른쪽 Child Node의 가장 작은 값은 오른쪽 Child 노드 중 가장 왼쪽 끝에 위치한 Child Node이다.
        //
        // 3-2. 삭제할 Node의 왼쪽 Child Node중, 가장 큰 값을 찾아 삭제할 Node의 Parent Node가 가리키게 한다.
        
        guard let rightNode = removeNode.rightChildNode else { return false }
        var changeNode = rightNode
        var changeParentNode = rightNode
        
        while let nextNode = changeNode.leftChildNode {
            changeParentNode = changeNode
            changeNode = nextNode
        }
        
        if let changeChildNode = changeNode.rightChildNode {
            changeParentNode.leftChildNode = changeChildNode
        } else {
            changeParentNode.leftChildNode = nil
        }
        
        if parentNode.value > value {
            parentNode.leftChildNode = changeNode
        } else {
            parentNode.rightChildNode = changeNode
        }
        
        changeNode.leftChildNode = removeNode.leftChildNode
        changeNode.rightChildNode = removeNode.rightChildNode
        
        return true
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

//BST.remove(from: 30) ? print("Removed Terminal node") : print("Fail")

BST.drawDiagram()





