//
//  Date+Extensions.swift
//  SliderCalendar
//
//  Created by oguzhan on 7.01.2025.
//

import Foundation


extension Date{
    
    func format(_ format: String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    
    var isToday: Bool{
        return Calendar.current.isDateInToday(self)
    }
    
    var isSameHour: Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool{
        return Calendar.current.compare(self, to: .init(), toGranularity: .hour) == .orderedAscending
    }
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay]{
        
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        
        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        guard let startOfWeek = weekForDate?.start else
        {
            return []
        }
        
        (0..<7).forEach{ index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek){
                week.append(.init(date: weekDay))
            }
        }
        
        return week
    }
    
    func createNextWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else {
            return []
        }
        
        return fetchWeek(nextDate)
        
    }
    
    func createPreviousWeek() -> [WeekDay]{
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else {
            return []
        }
        
        return fetchWeek(previousDate)
    }

    struct WeekDay: Identifiable{
        var id: UUID = .init()
        var date: Date
    }

}
