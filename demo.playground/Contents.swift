
var array = [1,3,5,6,7,8,11]
var search = 8


func searchFun(array:[Int],search:Int)  {
    
    var binaryIndex = array.count/2
    var arrayNew:[Int]
    
    if (search == array[binaryIndex]) {
        return
    }
    
    if(search > array[binaryIndex]) {
        
    }
    
    if(search < array[binaryIndex]) {
        
    }
    
    searchFun(array:arrayNew,search:search)

}

searchFun(array:array,search:search)





