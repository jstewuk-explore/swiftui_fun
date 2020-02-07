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

struct BasicRectView: View {
    var body: some View {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 514, height: 100)
                .border(Color.blue)
                .background(SizeSetter())
    }
}

struct SizeSetter: View {
    var body: some View {
        GeometryReader { d in
            Rectangle()
                .fill(Color.clear)
                .preference(key: MPreferenceKey.self, value: d.size)
        }
    }
}

struct PrefKeyView: View {
    @State var innerSize = CGSize.zero
    
    var body: some View {
        GeometryReader{ d in
        BasicRectView()
            .onPreferenceChange(MPreferenceKey.self) { value in
                self.innerSize = value
                print("value: \(value)")
            }
        .offset(CGSize(width: (self.innerSize.width - d.size.width)/2, height: (self.innerSize.height - d.size.height)/2))
        }
    }
    
}


struct MPreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        print(nextValue())
        value = nextValue()
    }
}

//: Using Geometry reader forces the alignment to be topleading?
//  GR always gives the size the parent "offers"

struct PrefKeyView_Previews: PreviewProvider {
    static var previews: some View {
        PrefKeyView()
    }
}
