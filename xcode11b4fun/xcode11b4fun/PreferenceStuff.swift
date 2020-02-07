//
//  PreferenceStuff.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/7/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

struct SizeSetter: View {
    var body: some View {
        GeometryReader { d in
            Rectangle()
                .fill(Color.red)
                .preference(key: MPreferenceKey.self, value: d.size)
                .onAppear { print("SizeSetter: \(d.size)")}
        }
    }
}



struct MPreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        print("PrefKey value: \(value)")
        
        // This is a hack, but since the inner size isn't changing it should work -- grab nonzero value and hold on to it.
        value = nextValue() == CGSize.zero ? value : nextValue()
        print("Pref key nextValue: \(value)")
        print("**************")
    }
}
