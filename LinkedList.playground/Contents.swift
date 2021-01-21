///链表节点

public class LinkedListNode<T>{
    
    var vaule:T
    
    weak var previous:LinkedListNode?
    
    var next:LinkedListNode?
    
    public init(value:T){
        
        self.vaule = value
        
    }
    
    
}

///链表

public class LinkedList<T> {

    public typealias Node = LinkedListNode<T>
    
    public var isEmpty:Bool{
        
        return head == nil
    }
    
    public var count:Int{
        
        guard var node = head else {
            
            return 0
        }
        
        var count = 1
        
        while let next = node.next {
            
            node = next
            count += 1
        }
        
        
        return count
        
    }
    
    private var head:Node?
    
    public var first:Node?{
        return head
    }
    
    public var last:Node?{
        
        guard var node = head else {
            
            return nil
        }
        
        while let next = node.next {
            
            node = next
        }
        
        return node
        
    }
    
    ///获取index上的node
    public func node(atIndex index:Int) -> Node?{
        
        if index == 0 {
            
            return head!
            
        }else{
            
            var node = head!.next
            
            guard  index < count else {
                
                return nil
            }
            
            for _ in 1..<index {
                
                node = node?.next
                
                if node == nil {
                    break
                }
                
            }
            
            
            return node!
            
        }
        
        
    }
    
    ///插入节点
    public func appendToTail(value:T){
        
        let newNode = Node(value: value)
        
        if let lastNode = last {
            
            newNode.previous = lastNode
            lastNode.next = newNode
            
        }else{
            
            head = newNode
        }
        
        
    }
    
    public func insertToHead(value:T){
        
        let newHead = Node(value: value)
        if head == nil{
            head = newHead
        }else{
            
            newHead.next = head
            head?.previous = newHead
            head = newHead
            
        }
        
    }
    
    public func insert(_ node:Node, atIndex index:Int){
        
        if index < 0 {
            print("invalid input index")
            return
        }
        
        let newNode = node
        
        if count == 0 {
            head = newNode
            
        }else{
            
            if index == 0 {
                
                newNode.next = head
                head?.previous = newNode
                head = newNode
                
            }else{
                
                if index>count {
                    
                    print("out of range")
                    return
                }
                
                let prev = self.node(atIndex: index)
                let next = prev?.next
                
                newNode.previous = prev
                newNode.next = prev?.next
                prev?.next = newNode
                next?.previous = newNode
                
            }
            
        }
        
    }
    
    ///移除节点
    public func removeAll() {
        head = nil
        
    }
    
    public func removeLast()->T?{
        
        guard !isEmpty else {
            
            return nil
        }
        
        return remove(node:last!)
        
    }
    
    
    public func remove(node:Node)->T?{
        
        guard head != nil else {
            print("linked list is empty")
            return nil
        }
        
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            
            prev.next = next
            
        }else{
            
            head = next
        }
        
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        
        return node.vaule
        
    }
    
    public func removeAt(_ index:Int) ->T?{
    
        guard head != nil else {
            
            return nil
        }
        
        let node = self.node(atIndex: index)
        
        guard node != nil else {
            
            return nil
        }
        
        return remove(node: node!)
        
    }
    
    ///打印所有节点
    public func printAllNode(){
        
        guard  head != nil else {
            
            print("linked list is empty")
            return
        }
        
        var node = head
        
        print("\n start printing all nodes")
        
        for index in 0..<count{
            
            
            if node == nil{
                break
            }
            
            print("[\(index)] \(node!.vaule)")
            
            node = node!.next
            
        }
        
        
    }
    
    
    
}




let list = LinkedList<String>()
list.isEmpty   // true
list.first     // nil
list.count     // 0

list.appendToTail(value: "Swift")
list.isEmpty         // false
list.first!.vaule    // "Swift"
list.last!.vaule     // "Swift"
list.count           //1

list.appendToTail(value:"is")
list.first!.vaule    // "Swift"
list.last!.vaule     // "is"
list.count           // 2

list.appendToTail(value:"great")
list.first!.vaule    // "Swift"
list.last!.vaule     // "great"
list.count           // 3


list.printAllNode()
//[0]Swift
//[1]is
//[2]Great

list.node(atIndex: 0)?.vaule // Swift
list.node(atIndex: 1)?.vaule // is
list.node(atIndex: 2)?.vaule // great
list.node(atIndex: 3)?.vaule // nil


list.insert(LinkedListNode.init(value: "language"), atIndex: 1)
list.printAllNode()
//[0]Swift
//[1]language
//[2]is
//[3]great


list.remove(node: list.first!)
list.printAllNode()
//[0]language
//[1]is
//[2]great


list.removeAt(1)
list.printAllNode()
//[0]language
//[1]great

list.removeLast()
list.printAllNode()
//[0]language

list.insertToHead(value: "study")
list.count             // 2
list.printAllNode()
//[0]study
//[1]language


list.removeAll()
list.printAllNode()//linked list is empty

list.insert(LinkedListNode.init(value: "new"), atIndex: 3)
list.printAllNode()
//[0]new

list.insert(LinkedListNode.init(value: "new"), atIndex: 3) //out of range
list.printAllNode()
//[0]new

list.insert(LinkedListNode.init(value: "new"), atIndex: 1)
list.printAllNode()

