// 冒泡排序
func bubbleSort() {
    var list = [61,5,33,44,22]
    for i in 0..<list.count {
        for j in i+1..<list.count{
            if list[j]>list[i]{
                let temp = list[j]
                list[j] = list[i]
                list[i] = temp
            }
        }
    }
    print(list)
}

bubbleSort()

// 选择排序

func chooseSort(){
    var list = [61,5,33,44,22]
    for i in 0..<list.count {
        var min = i
        for j in i+1..<list.count{
            if list[j]<list[min]{
                min = j
            }
        }
        let temp = list[min]
        list[min] = list[i]
        list[i] = temp
    }
    
    print(list)
}

chooseSort()

// 插入排序
func insertSort(){
    var list = [61,5,33,44,22]
    var nlist = [list[0]]
    
    for i in 1..<list.count {
        var max:Int? = nil
        for j in 0..<nlist.count {
            if list[i]>nlist[j]{
                max = i;
                nlist.insert(list[i], at: j)
                break
            }
        }
        
        if max == nil {
            nlist.append(list[i])
        }
    }
    
    print(nlist)
}

insertSort()

// 快速排序
func quickSort(list: inout [Int], left: Int, right: Int) {
    if left > right {//左边往右边移，右边往左边移动，最后过了就停止
        return
    }
    
    var i, j, pivot: Int
    
    i = left
    j = right
    pivot = list[left]
    
    while i != j {
        
        while list[j] <= pivot && i < j {//右边大的往左移动
            j -= 1
            print("j:",j)
        }
        
        while list[i] >= pivot && i < j {//左边小的往右移动
            i += 1
            print("i:",i)
        }
        

        if i < j {//找到两个对方区域的值进行交换
            let temp = list[i]
            list[i] = list[j]
            list[j] = temp
        }
        print(list)

    }
    
    list[left] = list[i]//此时i和j相等，处于中间位置，替换pivot值
    list[i] = pivot
    
    //重复以上动作
    quickSort(list: &list, left: left, right: i-1)
    quickSort(list: &list, left: i+1, right: right)
}

var list = [61,5,33,11,3,4,55,44,22]
quickSort(list: &list, left: 0, right: list.count-1)
