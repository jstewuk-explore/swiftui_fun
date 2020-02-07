//
//  ScollingGridStack.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/7/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

struct ScrollingGridStackView<Content: View>: View {
    @State var innerSize = CGSize.zero
    @State var scrollOffset = CGFloat.zero
    let content: (Int, Int) -> Content
    
    var body: some View {
        GeometryReader{ d in
            LoadedGridStackView(rows: 10, columns: 3)
                .onPreferenceChange(MPreferenceKey.self) { value in
                    self.innerSize = value
                    print("prefChange value: \(value)")
                    
            }
            .padding(20)
            .background(Color.blue)
            .border(Color.gray, width: 5)
            .offset(self.calculatedOffset(innerSize: self.innerSize, outerSize: d.size))
            .onTapGesture {
                withAnimation {
                    self.scrollOffset += 50
                }
            }
        }
    }
    
    func calculatedOffset(innerSize: CGSize, outerSize: CGSize) -> CGSize {
        
        let retval = CGSize(
            width: self.innerSize.width < outerSize.width ? 0 : (self.innerSize.width - outerSize.width)/2,
            height:(self.innerSize.height - outerSize.height)/2 + self.scrollOffset + 10)
        print("calculatedOffset: \(retval) -- innerSize: \(innerSize), outerSize: \(outerSize)")
        return retval
    }
    
}

struct LoadedGridStackView: View {
    let rows: Int
    let columns: Int
    
    var body: some View {
        GridStackView(rows: rows, columns: columns ){_, _ in
            Rectangle()
                .fill(Color.green)
                .frame(width:100, height: 100)
        }
        .background(SizeSetter())
    }
}

struct GridStackView<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< self.rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ScrollingGridStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridStackView { _, _  in
            Rectangle()
            .fill(Color.green)
            .frame(width:100, height: 100)
        }
    }
}
