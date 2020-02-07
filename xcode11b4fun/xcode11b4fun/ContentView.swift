//
//  ContentView.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/7/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        PrefKeyView()
        
//        AnchorKeyView()
        
//        SPrefKeyView() // Simulated scrolling
        
        ScrollingGridStackView { _, _  in
            Rectangle()
            .fill(Color.green)
            .frame(width:100, height: 100)
        }
        
        
        
        
        
//        GridStack(rows: 3, columns: 3) { _, _  in
//            Rectangle()
//            .frame(width:100,height:100)
//            .border(Color.red)
//        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
