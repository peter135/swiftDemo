
public struct Queue<T> {
    
    fileprivate var queueArray = [T]()
    
    public var count:Int{
        
        return queueArray.count
    }
    
    public var isEmpty:Bool{
        return queueArray.isEmpty
    }
    
    public var front:T?{
        
        if isEmpty {
            
            return nil
            
        }else{
            
            return queueArray.first
        }
        
    }
    
    public mutating func enqueue(_ element:T){
        
        queueArray.append(element)
    }
    
    public mutating func dequeue() ->T?{
        
        if isEmpty {
            
            return nil
            
        }else{
            
            return queueArray.removeFirst()
            
        }
    }
    
    public mutating func printAllElements() {
        
        guard count>0 else {
            print("queue is empty")
            return
        }
        
        print("\n print all queue elements")
        
        for (index,value) in queueArray.enumerated() {
            
            print("[\(index)] \(value)")
            
        }
        
    }
    
    
}


var queue = Queue.init(queueArray: [])
queue.printAllElements()//queue is empty
queue.isEmpty //true
queue.count   //0


queue.enqueue(2)
queue.printAllElements()
queue.isEmpty  //false
//[0]2

queue.enqueue(3)
queue.printAllElements()
//[0]2
//[1]3


queue.enqueue(4)
queue.printAllElements()
//[0]2
//[1]3
//[2]4
queue.front //2


queue.dequeue()
queue.printAllElements()
//[0]3
//[1]4
queue.front //3


queue.dequeue()
queue.printAllElements()
//[0]4
queue.front //4

queue.dequeue()
queue.printAllElements() //queue is empty
queue.front //return nil, and print : queue is empty
queue.isEmpty //true
queue.count//0



