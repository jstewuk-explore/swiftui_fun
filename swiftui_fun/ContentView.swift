//
//  ContentView.swift
//  swiftui_fun
//
//  Created by James Stewart on 9/3/19.
//  Copyright © 2019 James Stewart. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("barbarian")
            Text("Nogitsune Takeshi")
                .font(.title)
                .foregroundColor(.black)
        }
        .lineLimit(1)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
