//
//  GridStack.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/7/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< self.rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                        .background( GeometryHelper(label: "Content") )
                    }
                }.background( GeometryHelper(label: "HStack") )
            }
        }.background( GeometryHelper(label: "VStack") )
    }

    
    struct GeometryHelper: View {
        let label: String
        var body: some View {
            GeometryReader { d in
                Rectangle()
                    .fill(Color.clear)
                    .onAppear {
                        print("\(self.label): \(d.size)")
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

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 2, columns: 2) {_, _ in
            Rectangle()
                .fill(Color.green)
                .frame(width:100, height: 100)
        }
    }
}
