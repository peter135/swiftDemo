## swift demo|notes
[简书](https://www.jianshu.com)

![](https://wx2.sinaimg.cn/mw690/51205a7fgy1fwsbd4g17nj20sg0lcgnb.jpg)

> 一盏灯，一片黄昏

```swift
struct  Work {
   
    var height = 180
    
    var color = "yellow"
    
    //初始化方法
    init(height:Int,color:String) {
        
        self.height = height
        self.color = color
        
    }
    
    init(height:Int) {
        
        self.init(height: height,color:"red")
    }
    
    
    func printSelf(){
        
        print("my height is \(height) color is \(color)" )
    }
    
    //修改属性（值类型）
    mutating func setColor(newColor:String){
        
        color = newColor
    }
    
    //static 类方法
    static func getNumberOfWorker()->Int{
        
        return 5
    }
    
}

```
