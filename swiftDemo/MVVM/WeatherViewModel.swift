//
//  WeatherViewModel.swift
//  swiftDemo
//
//  Created by apple on 2021/5/30.
//  Copyright © 2021 Fubao. All rights reserved.
//

import Foundation
import CoreLocation

public class WeatherViewModel {
   internal let locationName = Box("Loading")
   private let geocoder = LocationGeocoder()
   private static let defaultAddress = "McGaheysville, VA"

    init() {
      changeLocation(to: Self.defaultAddress)
    }
    
    func changeLocation(to newLocation:String){
        locationName.value = "Loading..."
        geocoder.geocode(addressString: newLocation){ [weak self] locations in
            guard let self = self else {return}
            if let location = locations.first {
                self.locationName.value = location.name
                return
            }
        }
    }
    
}
