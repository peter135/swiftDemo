//
//  AbstractFactory.swift
//  swiftDemo
//
//  Created by peter on 2018/12/26.
//  Copyright © 2018 Fubao. All rights reserved.
//

import Foundation

///抽象工厂模式

protocol ProductA {}

class ConcreteProductA1: ProductA {}
class ConcreteProductA2: ProductA {}


protocol ProductB {}
class ConcreteProductB1: ProductB {}
class ConcreteProductB2: ProductB {}


class Client {
    
    let f = Factory()
    
}

class Factory {
    
    
    func createProductA() -> ProductA? { return nil } // 用于继承
    func createProductB() -> ProductB? { return nil } // 用于继承
    
    
    func createProductA(type: Int) -> ProductA? { // 用于调用
        if type == 0 {
            return ConcreteFactory1().createProductA()
        } else {
            return ConcreteFactory2().createProductA()
        }
    }
    func createProductB(type: Int) -> ProductB? { // 用于调用
        if type == 0 {
            return ConcreteFactory1().createProductB()
        } else {
            return ConcreteFactory2().createProductB()
        }
    }
}

class ConcreteFactory1: Factory {
    override func createProductA() -> ProductA? {
        // ... 产品加工过程
        return ConcreteProductA1()
    }
    override func createProductB() -> ProductB? {
        // ... 产品加工过程
        return ConcreteProductB1()
    }
}

class ConcreteFactory2: Factory {
    override func createProductA() -> ProductA? {
        // ... 产品加工过程
        return ConcreteProductA2()
    }
    override func createProductB() -> ProductB? {
        // ... 产品加工过程
        return ConcreteProductB2()
    }
}


///builder 模式 将一个复杂的构建与其表示相分离，使得同样的构建过程可以创建不同的表示。

struct Builder {
    var partA: String
    var partB: String
}

struct Product {
    var partA: String
    var partB: String
    init(builder: Builder) {
        partA = builder.partA
        partB = builder.partB
    }
}

// 通过builder完成产品创建工作
let b = Builder(partA: "A", partB: "B")
// 这样产品只需要一个builder就可以完成制作
let p = Product(builder: b)


//MARK: 原型模式
//你只要实现一个返回你自己的新对象的方法即可。这里我采用的实现还不是最简单的，这个interface并不是必须的。

protocol Prototype {
    func clone() -> Prototype
}

struct ProductP: Prototype {
    var title: String
    func clone() -> Prototype {
        return ProductP(title: title)
    }
}

let p1 = ProductP(title: "p1")
let p2 = p1.clone()


///单例模式 保证一个类仅有一个实例，并提供一个访问它的全局访问点。

class Singleton {
    static let sharedInstance = Singleton()
    private init() {
        // 用private防止被new
    }
}
let s  = Singleton.sharedInstance


///适配器模式 将一个类的接口转换成客户希望的另外一个接口。适配器模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。

protocol Target {
    var value: String { get }
}

struct Adapter: Target {
    let adaptee: Adaptee
    var value: String {
        return "\(adaptee.value)"
    }
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
}

struct Adaptee {
    var value: Int
}

//Adapter(Adaptee(value: 1)).value // "1"

///桥接模式 将抽象部分与实现部分分离，使它们都可以独立的变化。

//class 设备 {
//    let obj: 开关能力
//    func turnOn(_ on: Bool) {
//        obj.turnOn(on)
//    }
//    init(_ obj: 开关能力) {
//        self.obj = obj
//    }
//}
//
//
//class 电视: 开关能力 {
//    func turnOn(_ on: Bool) {
//        if on {
//            // 打开电视
//        } else {
//            // 关闭电视
//        }
//    }
//}
//
//class 空调: 开关能力 {
//    func turnOn(_ on: Bool) {
//        if on {
//            // 打开空调
//        } else {
//            // 关闭空调
//        }
//    }
//}
//
//let tv = 设备(电视())
//tv.turnOn(true) // 打开电视
//
//let aircon = 设备(空调())
//aircon.turnOn(false) // 关闭空调



///组合模式  将对象组合成树形结构以表示"部分-整体"的层次结构。组合模式使得用户对单个对象和组合对象的使用具有一致性。
protocol Component {
    func someMethod()
}

class Leaf: Component {
    func someMethod() {
        // Leaf
    }
}

class Composite: Component {
    var components = [Component]()
    func someMethod() {
        // Composite
    }
}

let leaf = Leaf()
let composite = Composite()


///装饰者模式 动态地给一个对象添加一些额外的职责。就增加功能来说，装饰器模式相比生成子类更为灵活。

protocol Component1 {
    var cost: Int { get }
}

protocol Decorator: Component1 {
    var component: Component1 { get }
    init(_ component: Component1)
}

struct Coffee: Component1 {
    var cost: Int
}

struct Sugar: Decorator {
    var cost: Int {
        return component.cost + 1
    }
    var component: Component1
    init(_ component: Component1) {
        self.component = component
    }
}

struct Milk: Decorator {
    var cost: Int {
        return component.cost + 2
    }
    var component: Component1
    init(_ component: Component1) {
        self.component = component
    }
}

//Milk(Sugar(Coffee(cost: 19))).cost

///外观模式 为子系统中的一组接口提供一个一致的界面，外观模式定义了一个高层接口，这个接口使得这一子系统更加容易使用。

protocol Facade {
    func simpleMethod()
}

class LegacyCode {
    func someMethod1() { }
    func someMethod2() { }
}

extension LegacyCode: Facade {
    func simpleMethod() {
        someMethod1()
        someMethod2()
    }
}

class Client1 {
    let f: Facade = LegacyCode()
}


///享元模式 运用共享技术有效地支持大量细粒度的对象。

struct TargetObject {
    var title: String?
    func printTitle() {
        print(title ?? "default")
    }
}

class Cache {
    var targetObjects = [String: TargetObject]()
    func lookup(key: String) -> TargetObject {
        if targetObjects.index(forKey: key) == nil {
            return TargetObject()
        }
        return targetObjects[key]!
    }
}

//let c = Cache()
//c.targetObjects["Test"] = TargetObject(title: "Test")
//c.lookup(key: "123").printTitle() // nil
//c.lookup(key: "Test").printTitle() // Test


///代理模式 为其他对象提供一种代理以控制对这个对象的访问。

protocol Subject {
    mutating func operation()
}

struct SecretObject: Subject {
    func operation() {
        // real implementation
    }
}

struct PublicObject: Subject {
    private lazy var s = SecretObject()
    mutating func operation() {
        s.operation()
    }
}

//var p = PublicObject()
//p.operation()


///责任链模式 避免请求发送者与接收者耦合在一起，让多个对象都有可能接收请求，将这些对象连接成一条链，并且沿着这条链传递请求，直到有对象处理它为止。
protocol ChainTouchable {
    var next: ChainTouchable? { get }
    func touch()
}

class ViewA: ChainTouchable {
    var next: ChainTouchable? = ViewB()
    func touch() {
        next?.touch()
    }
}

class ViewB: ChainTouchable {
    var next: ChainTouchable? = ViewC()
    func touch() {
        next?.touch()
    }
}

class ViewC: ChainTouchable {
    var next: ChainTouchable? = nil
    func touch() {
        print("C")
    }
}

//let a = ViewA()
//a.touch() // OUTPUT: C




