//
//  CalendarView.swift
//  SliderCalendar
//
//  Created by oguzhan on 7.01.2025.
//

import Foundation
import SwiftUI

private let frameSizeNormal: Double = 90
private let offsetSize: CGFloat = 12
private let frameMinSize: CGFloat = 5.0
private let roundedValue: Double = 15.0
private let appTint: Color = .red
private let paddingNormal: Double = 15

struct HomeView: View {
    
    @State private var currentDate: Date = .init()
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @Namespace private var animation
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 0) {
                HeaderView()
                
                Spacer()
                Text(currentDate.formatted(date: .complete, time: .omitted))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                    .textScale(.secondary)
                    .hSpacing()
                
                Spacer()
                
            }
            .padding()
            .vSpacing(.top)
            .onAppear{
                if weekSlider.isEmpty{
                    let currentWeek = Date().fetchWeek()
                    
                    if let firstDate = currentWeek.first?.date{
                        weekSlider.append(firstDate.createPreviousWeek())
                    }
                    
                    weekSlider.append(currentWeek)
                    
                    if let lastDate = currentWeek.last?.date{
                        weekSlider.append(lastDate.createNextWeek())
                    }
                    
                }
            }
            .background(.gray.opacity(AppSize.Opacity.medium.rawValue))
        }
    }
    
    
    
    @ViewBuilder
    func HeaderView() -> some View{
        VStack(alignment: .leading, spacing: AppSize.Spacing.lowest.rawValue){
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
                .textScale(.secondary)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self){ index in
                    let week = weekSlider[index]
                    WeekView(week)
                        .tag(index)
                        .padding(.horizontal, paddingNormal)
                }
            }
            .padding(.horizontal, -paddingNormal)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: frameSizeNormal)
            
        }
        .hSpacing(.leading)
        .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
            if newValue == 0 || newValue == (weekSlider.count - 1){
                createWeek = true
            }
        }
    }
    
    @ViewBuilder
    func WeekView(_ week: [Date.WeekDay]) -> some View{
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: AppSize.Spacing.low.rawValue) {
                    Text(day.date.format("E"))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                        .textScale(.secondary)
                    
                    Text(day.date.format("dd"))
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .textScale(.secondary)
                        .frame(width: AppSize.Width.low.rawValue, height: AppSize.Height.low.rawValue)
                        .background{
                            if isSameDate(day.date, currentDate){
                                Circle()
                                    .fill(appTint)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            
                            if day.date.isToday{
                                Circle()
                                    .fill(appTint)
                                    .frame(width: frameMinSize, height: frameMinSize)
                                    .vSpacing(.bottom)
                                    .offset(y: offsetSize)
                            }
                        }
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing()
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy){
                        currentDate = day.date
                    }
                }
            }
            .background{
                GeometryReader {
                    let minX = $0.frame(in: .global).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self) { value in
                            
                            if value.rounded() == roundedValue && createWeek{
                                paginateWeek()
                                createWeek = false
                            }
                        }
                }
            }
        }
    }
    
    func paginateWeek(){
        
        if weekSlider.indices.contains(currentWeekIndex){
                        
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0{
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1){
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
        
        debugPrint(weekSlider.count)
    }
}
