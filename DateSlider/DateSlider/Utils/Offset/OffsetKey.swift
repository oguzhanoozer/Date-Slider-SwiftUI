//
//  OffsetKey.swift
//  SliderCalendar
//
//  Created by oguzhan on 7.01.2025.
//

import SwiftUI

struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
