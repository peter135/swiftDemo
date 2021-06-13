//
//  SlideChildController.swift
//  swiftDemo
//
//  Created by peter on 2018/11/16.
//  Copyright © 2018年 Fubao. All rights reserved.
//

import Foundation

import UIKit

class ValueListener<T> {
    
    var value:T?{
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T?){
        self.value = value
    }
    
    private var listener:((T?)->Void)?
    
    func  bind(_ listener:@escaping((T?)->Void))  {
        listener(value)
        self.listener = listener
    }
    
}

struct UserModel: Codable {
    let name: String
}

struct UserListViewModel {
    var users : ValueListener<[UserTableViewCellViewModel]> = ValueListener([])
    
    
}

struct UserTableViewCellViewModel {
    let name: String
    
}


class SlideChildController: UIViewController, UITableViewDataSource{
    
    
    //MARK: Views
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = UserListViewModel()
    
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .white
         view.addSubview(tableView)
         tableView.frame = view.bounds
         tableView.dataSource = self
        
         viewModel.users.bind { [weak self] _ in
             DispatchQueue.main.async {
                 self?.tableView.reloadData()
             }
         }
        
        fetchData()
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.users.value?[indexPath.row].name
        return cell
    }
    
    func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/user") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){(data,_,_) in
            guard let data = data else {return}
            do{
                let userModels = try JSONDecoder().decode([UserModel].self, from: data)
                self.viewModel.users.value = userModels.compactMap({
                    UserTableViewCellViewModel(name: $0.name)
                })
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
}
