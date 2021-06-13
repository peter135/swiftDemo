//
//  WeatherViewController.swift
//  swiftDemo
//
//  Created by apple on 2021/5/30.
//  Copyright © 2021 Fubao. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController:UIViewController {
    private let viewModel = WeatherViewModel()
    private var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        viewModel.locationName.bind{ [weak self] locationName in
                  self?.cityLabel.text = locationName

        }
        
    }

    
}
