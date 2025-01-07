//
//  AppSize.swift
//  SliderCalendar
//
//  Created by oguzhan on 7.01.2025.
//

import Foundation


struct AppSize{
    enum LineWidth: Double{
        case low = 2.0
        case textField = 0.8
    }
    
    static let titleTextLineLimit = 1
    static let descriptionTextLineLimit = 3
    
    enum View: Double{
        case lowest = 12
        case low = 20
        case normal = 40
        case medium = 60
        case high = 80
    }
    
    enum Height: Double{
        case lowest = 12
        case low = 35
        case normal = 40
        case medium = 50
        case high = 80
    }
    
    enum Width: Double{
        case lowest = 20
        case low = 35
        case normal = 50
        case medium = 100
        case high = 150
    }
    
    enum Spacing: Double{
        case lowest = 4
        case low = 8
        case mediumLow = 10
        case medium = 12
        case normal = 15
        case high = 20
        case highest = 30
    }
    
    enum Opacity: Double{
        case low = 0.1
        case medium = 0.15
        case normal = 0.25
        case high = 0.5
        
    }
}
