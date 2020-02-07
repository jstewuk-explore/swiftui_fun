//
//  ContentView.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/6/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

//: Notes:
//:   - Preference keys can be used to pass anything from child to parent, it doesn't have to be child's view geometry
//:     - similar to @Environment stuff, not sure if this would work with @Environment -- need to check
//:   - GeometryReader affects view alignment, if you wrap the view in it, but you can add a conforming view like a background
//:     as a 'subview' and wrap that in GeometryReader to avoid this complication
//:   - offsets make sense, remembering that the offset moves the container, not the contained view
//:


//: Scrolling (sort of)
//:  -- inner view moves down with each tap, and movement is animated.

//: Next step, use a gesture recognizer to actually scroll, using gesture recognizer offsets


struct SBasicRectView: View {
    var body: some View {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 514, height: 100)
                .border(Color.blue)
                .background(SizeSetter())
                
    }
}

struct SSizeSetter: View {
    var body: some View {
        GeometryReader { d in
            Rectangle()
                .fill(Color.clear)
                .preference(key: SMPreferenceKey.self, value: d.size)
        }
    }
}

struct SPrefKeyView: View {
    @State var innerSize = CGSize.zero
    @State var scrollOffset = CGFloat.zero
    
    var body: some View {
        GeometryReader{ d in
            SBasicRectView()
                .onPreferenceChange(SMPreferenceKey.self) { value in
                    self.innerSize = value
                    print("value: \(value)")
            }
            .offset(CGSize(
                width: (self.innerSize.width - d.size.width)/2,
                height: (self.innerSize.height - d.size.height)/2 + self.scrollOffset))
            .onTapGesture {
                withAnimation {
                    self.scrollOffset += 50
                }
            }
        }
    }
    
}


struct SMPreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        print(nextValue())
        value = nextValue()
    }
}

//: Using Geometry reader forces the alignment to be topleading?
//  GR always gives the size the parent "offers"

struct SPrefKeyView_Previews: PreviewProvider {
    static var previews: some View {
        SPrefKeyView()
    }
}
