
///冒泡排序高级版
func bubbleSortAdvanced(_ array:inout [Int]) ->[Int]{
    
    guard array.count>1 else {
        
        return array
    }
    
    for i in 0..<array.count - 1{
        
        
        var swapped = true
        
        for j in 0 ..< array.count - i - 1 {
            
            if array[j]>array[j+1]{
                array.swapAt(j, j+1)
                swapped = true
            }
            
        }
        
        if swapped == false {
            break
        }
        
    }
    
    
    return array
    
}


///选择排序
func selectionSort(_ array:inout [Int]) ->[Int]{
    
    guard array.count>1 else {
        
        return array
        
    }
    
    
    for i in 0..<array.count - 1 {
        
        var min = i
        
        for j in i+1..<array.count {
            
            if array[j]<array[min] {
                
                min = j
            }
        }
        
        if i != min{
            
            array.swapAt(i, min)
        }
        
    }
    
    return array
    
}


///插入排序

func insertionSort(_ array:inout [Int])->[Int]{
    
    
    guard array.count>1 else {
        
        return array
    }
    
    for i in 1..<array.count{
        
        var j = i
        
        while j>0 && array[j]<array[j-1] {
            array.swapAt(j-1, j)
            j -= 1
        }
        
        
    }
    
    return array
    
    
}



///归并排序




///快速排序

func quickSort<T:Comparable>(_ array:[T]) -> [T]{
    
    guard array.count>1 else {return array}
    
    let pivot = array[array.count/2]
    
    print("pivot \(pivot)")
    let less = array.filter{ $0<pivot}
    let equal = array.filter { $0 == pivot }
    let greater = array.filter{$0 > pivot}
    print("less \(less) greater \(greater)")

    return quickSort(less) + equal + quickSort(greater)
    
}

var arr = [1,2,12,12,11,4,11,6,8,8,12]

var sorted = quickSort(arr)

print("sorted \(sorted)")

import Foundation
import UIKit

//执行时间
public func executionTimeInterval(block: () -> ()) -> CFTimeInterval {
    let start = CACurrentMediaTime()
    block();
    let end = CACurrentMediaTime()
    return end - start
}


//格式化时间
public extension CFTimeInterval {
    public var formattedTime: String {
        return self >= 1000 ? String(Int(self)) + "s"
            : self >= 1 ? String(format: "%.3gs", self)
            : self >= 1e-3 ? String(format: "%.3gms", self * 1e3)
            : self >= 1e-6 ? String(format: "%.3gµs", self * 1e6)
            : self < 1e-9 ? "0s"
            : String(format: "%.3gns", self * 1e9)
    }
}


extension Array {
    
    static public func randomArray(size: Int, maxValue: UInt) -> [Int] {
        var result = [Int](repeating: 0, count:size)
        
        for i in 0 ..< size {
            result[i] = Int(arc4random_uniform(UInt32(maxValue)))
        }
        
        return result
    }
}

var originalArray = Array<Int>.randomArray(size: 10, maxValue:100)

var selectionSortedArray = [Int]()

//var time1 = executionTimeInterval{
//    selectionSortedArray = selectionSort(&originalArray) //要测试的函数
//}
//
//
//print("selection sort time duration : \(time1.formattedTime)") //打印出时间
//

//var time2 = executionTimeInterval{
//    selectionSortedArray = bubbleSortAdvanced(&originalArray) //要测试的函数
//}
//
//print("bubble advanced sort time duration : \(time2.formattedTime)") //打印出时间



//print(Int.Type.self)
//print(Int.self)

//protocol ContentCell { }
//
//class IntCell: UIView, ContentCell {
//    required init(value: Int) {
//        super.init(frame: CGRect.zero)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class StringCell: UIView, ContentCell {
//    required init(value: String) {
//        super.init(frame: CGRect.zero)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//


