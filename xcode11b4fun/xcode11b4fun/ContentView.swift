//
//  ContentView.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/6/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        GeometryReader { inner in
            VStack {
                GeometryReader { lowest in
                    ForEach(0 ..< self.rows) { row in
                        HStack {
                            ForEach(0 ..< self.columns) { column in
                                Rectangle()
                                    .fill(Color.orange)
                                    .frame(width: 100, height: 100)
                                
                            }
                        }
                    }
                    .onAppear { print("lowest: \(lowest.size)") }
                    .border(Color.red)
                }
                
                
            }
            .onAppear { print(inner.size) }
            .offset(x: -20, y: 50)
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct BasicRectView: View {
    var body: some View {
            Rectangle()
                .fill(Color.orange)
                .frame(width: 514, height: 100)
                .border(Color.blue)
                .background(WidthSetter())
    }
}

struct WidthSetter: View {
    var body: some View {
        GeometryReader { d in
            Rectangle()
                .fill(Color.clear)
                .preference(key: MPreferenceKey.self, value: d.size)
        }
    }
}

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
