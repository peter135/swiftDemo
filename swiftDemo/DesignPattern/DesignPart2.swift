//
//  DesignPart2.swift
//  swiftDemo
//
//  Created by peter on 2018/12/27.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation

/// 命令模式 将一个请求封装成一个对象，从而使您可以用不同的请求对客户进行参数化。
protocol Command1 {
    
    var operation:()->Void {get}
    var backup:String {get}
    func undo()
}

struct ConcreteCommand:Command1 {
    
    var backup: String
    var operation: () -> Void
    
    func undo() {
        
        print(backup)
    }
    
}

struct Invoker {
    
    var command:Command1
    
    func execute(){
        command.operation()
        
    }
    
    func undo(){
        command.undo()
        
    }
    
    
}


//let printA = ConcreteCommand(backup: "Default A") {
//    print("A")
//}
//let i1 = Invoker(command: printA)
//i1.execute() // OUTPUT: A
//
//let printB = ConcreteCommand(backup: "Default B") {
//    print("B")
//}
//let i2 = Invoker(command: printB)
//i2.execute() // OUTPUT: B
//i2.undo() // OUTPUT: Default B


/// 解释器模式 给定一个语言，定义它的文法表示，并定义一个解释器，这个解释器使用该标识来解释语言中的句子。

protocol Expression {
    
    func evalute(_ context:String) -> Int
    
}

struct MyAdditionExpression:Expression {
    
    func evalute(_ context: String) -> Int {
        
        return context.components(separatedBy: "加")
            .compactMap{Int($0)}
            .reduce(0, +)
    }
    
}

//let c = MyAdditionExpression()
//c.evaluate("1加1") // OUTPUT: 2


/// 迭代器模式 提供一种方法顺序访问一个聚合对象中各个元素, 而又无须暴露该对象的内部表示。
protocol AbstractIterator {
    func hasNext() -> Bool
    func next() -> Int?
}

class ConcreteIterator: AbstractIterator {
    private var currentIndex = 0
    var elements = [Int]()
    
    
    func next() -> Int? {
        guard currentIndex < elements.count else { currentIndex = 0; return nil }
        defer { currentIndex += 1 }
        return elements[currentIndex]
    }
    
    func hasNext() -> Bool {
        guard currentIndex < elements.count else { currentIndex = 0; return false }
        return true
    }
}

protocol AbstractCollection {
    func makeIterator() -> AbstractIterator
}

class ConcreteCollection: AbstractCollection {
    let iterator = ConcreteIterator()
    func add(_ e: Int) {
        iterator.elements.append(e)
    }
    func makeIterator() -> AbstractIterator {
        return iterator
    }
}

//let c = ConcreteCollection()
//c.add(1)
//c.add(2)
//c.add(3)
//
//let iterator = c.makeIterator()
//while iterator.hasNext() {
//    print(iterator.next() as Any)
//}



/// 中介模式 用一个中介对象来封装一系列的对象交互，中介者使各对象不需要显式地相互引用，从而使其耦合松散，而且可以独立地改变它们之间的交互。
protocol Receiver {
    func receive(message: String)
}

protocol Mediator: class {
    func notify(message: String)
    func addReceiver(_ receiver: Receiver)
}

class ConcreteMediator: Mediator {
    var recipients = [Receiver]()
    func notify(message: String) {
        recipients.forEach { $0.receive(message: message) }
    }
    func addReceiver(_ receiver: Receiver) {
        recipients.append(receiver)
    }
}

protocol Component2: Receiver {
    var mediator: Mediator? { get }
}

struct ConcreteComponent: Component2 {
    weak var mediator: Mediator?
    var name: String
    func receive(message: String) {
        print(name, " receive: ", message)
    }
}

var mediator = ConcreteMediator()

//let c1 = ConcreteComponent(mediator: mediator, name: "c1")
//let c2 = ConcreteComponent(mediator: mediator, name: "c2")
//let c3 = ConcreteComponent(mediator: mediator, name: "c3")
//
//mediator.addReceiver(c1)
//mediator.addReceiver(c2)
//mediator.addReceiver(c3)
//
////c1  receive:  hi
////c2  receive:  hi
////c3  receive:  hi
//c1.mediator?.notify(message: "hi")

//备忘录模式 在不破坏封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。
typealias Memento1 = [String: String] // chatper: level
protocol MementoConvertible {
    var memento: Memento1 { get }
    init?(memento: Memento1)
}

class GameState: MementoConvertible {
    var memento: Memento1 {
        return [chapter: level]
    }
    var chapter: String
    var level: String
    
    required init?(memento: Memento1) {
        self.chapter = memento.keys.first ?? ""
        self.level = memento.values.first ?? ""
    }
    init(chapter: String, level: String) {
        self.chapter = chapter
        self.level = level
    }
}

protocol CaretakerConvertible {
    static func save(memonto: Memento, for key: String)
    static func loadMemonto(for key: String) -> Memento?
}

class Caretaker: CaretakerConvertible {
    static func save(memonto: Memento, for key: String) {
        let defaults = UserDefaults.standard
        defaults.set(memonto, forKey: key)
        defaults.synchronize()
    }
    
    static func loadMemonto(for key: String) -> Memento? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key) as? Memento
    }
    
}

//let g = GameState(chapter: "Prologue", level: "0")
//// after a while
//g.chapter = "Second"
//g.level = "20"
//// want a break
//Caretaker.save(memonto: g.memento, for: "gamename")
//// load game
//let gameState = Caretaker.loadMemonto(for: "gamename") // ["Second": "20"]
//



//观察者模式 定义对象间的一种一对多的依赖关系，当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。
//protocol Observable {
//    var observers: [Observer1] { get }
//    func add(observer: Observer1)
//    func remove(observer: Observer1)
//    func notifyObservers()
//}
//
//class ConcreteObservable: Observable {
//    var observers = [Observer1]()
//    func add(observer: Observer1) {
//        observers.append(observer)
//    }
//    func remove(observer: Observer1) {
//        if let index = observers.index(where: { $0 === observer }) {
//            observers.remove(at: index)
//        }
//    }
//    func notifyObservers() {
//        observers.forEach { $0.update() }
//    }
//}
//
//protocol Observer1: class {
//    func update()
//}
//
//class ConcreteObserverA: Observer1 {
//    func update() { print("A") }
//}
//
//class ConcreteObserverB: Observer1 {
//    func update() { print("B") }
//}

//////////////////////////////////

//let observable = ConcreteObservable()
//let a = ConcreteObserverA()
//let b = ConcreteObserverB()
//observable.add(observer: a)
//observable.add(observer: b)
//observable.notifyObservers() // output: A B
//
//observable.remove(observer: b)
//observable.notifyObservers() // output: A
//

//状态模式 允许对象在内部状态发生改变时改变它的行为，对象看起来好像修改了它的类。

protocol State {
    func operation()
}

class ConcreteStateA: State {
    func operation() {
        print("A")
    }
}

class ConcreteStateB: State {
    func operation() {
        print("B")
    }
}

class Context {
    var state: State = ConcreteStateA()
    func someMethod() {
        state.operation()
    }
}

//let c = Context()
//c.someMethod() // OUTPUT: A
//c.state = ConcreteStateB() // switch state
//c.someMethod() // OUTPUT: B


//策略模式 定义一系列的算法,把它们一个个封装起来, 并且使它们可相互替换。

protocol WeaponBehavior {
    func use()
}

class SwordBehavior: WeaponBehavior {
    func use() { print("sword") }
}

class BowBehavior: WeaponBehavior {
    func use() { print("bow") }
}

class Character {
    var weapon: WeaponBehavior?
    func attack() {  weapon?.use() }
}

class Knight: Character {
    override init() {
        super.init()
        weapon = SwordBehavior()
    }
}

class Archer: Character {
    override init() {
        super.init()
        weapon = BowBehavior()
    }
}

///////////////////////////////////
//
//Knight().attack() // output: sword
//Archer().attack() // output: bow


//模板方法模式 定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。
class Soldier {
    func attack() {} // <-- Template Method
    private init() {} // <-- avoid creation
}

class Paladin: Soldier {
    override func attack() {
        print("hammer")
    }
}

class Archer1: Soldier {
    override func attack() {
        print("bow")
    }
}

//访问者模式 主要将数据结构与数据操作分离。
protocol Visitor {
    func visit(_ c: ComponentA)
    func visit(_ c: ComponentB)
}

struct ConcreteVisitor: Visitor {
    func visit(_ c: ComponentA) {
        c.featureA()
    }
    func visit(_ c: ComponentB) {
        c.featureB()
    }
}

protocol Component3 {
    func accept(_ v: Visitor)
}

struct ComponentA: Component3 {
    func featureA() {
        print("Feature A")
    }
    func accept(_ v: Visitor) {
        v.visit(self)
    }
}

struct ComponentB: Component3 {
    func featureB() {
        print("Feature B")
    }
    func accept(_ v: Visitor) {
        v.visit(self)
    }
}

//let components: [Component] = [ComponentA(), ComponentB()]
//components.forEach {
//    $0.accept(ConcreteVisitor())
//}


