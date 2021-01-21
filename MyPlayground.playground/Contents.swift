
var originalArr = [2,1,3]

func removeLastInArray(_ array:inout [Int]){
    
    array.removeLast()
    
}

print("\n ===== before moving: \(originalArr)")


removeLastInArray(&originalArr)


print("\n ===== after moving: \(originalArr)")


var mutableNumbers:[Int] = [2,1,5,4,1,3]

//mutableNumbers.forEach{ value in
//
//    if let index = mutableNumbers.index(of:value){
//
//        print("index of \(value) is \(index)")
//    }
//
//}

for (index, value) in mutableNumbers.enumerated() {
    print("Item \(index + 1): \(value)")
}

let oneSet:Set = [1,2,3,4,5]
print(oneSet)

oneSet.forEach { value in
    print(value)
}

var mutableStringSet:Set = ["one","two","three"]

let item = "two"

if mutableStringSet.contains(item) {
    
    print("\(item) found in the set")
    
}


var dayOfWeek = [0:"sun",1:"mon",2:"tue"]

if let day = dayOfWeek[2]{
    
    print(day)
    
}

enum HttpAction{
    
    case get
    case post(String)
    case delete(Int,String)

}

var action1 = HttpAction.get
var action2 = HttpAction.post("Boxue")

switch action1 {
    
    case .get:
        print("Http get")
    
    case .post(let message):
        print("\(message)")

    case .delete(let id, _):
        print("\(id)")

    
}




enum Direction:Int{
    
    case east = 1
    case south = 2
    case west = 3
    case north = 4

}


//
//let customOb = Observable<Int>.create{ observers in
//
//    observers.onNext(10)
//    observers.onNext(11)
//
//    observers.onCompleted()
//
//    return Disposables.create()
//
//}
//
//let disposeBag = DisposeBag()
//
//customOb.subscribe(onNext: {print($0)},
//                   onCompleted: {},
//                   onDisposed: {print("game over")}).disposed(by: disposeBag)
//
//
//
////rx subject
//let subject = PublishSubject<String>()
//
//let sub1 = subject.subscribe(onNext:{
//
//    print("sub1 = what happended \($0)")
//
//})
//
//subject.onNext("episode updated")
//sub1.dispose()
//
//
//let sub2 = subject.subscribe(onNext:{
//
//    print("sub2 = what happended \($0)")
//
//})
//subject.onNext("episode2 updated")
//subject.onNext("episode3 updated")
//
//sub2.dispose()
