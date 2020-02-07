//
//  ContentView.swift
//  xcode11b4fun
//
//  Created by James Stewart on 2/6/20.
//  Copyright © 2020 James Stewart. All rights reserved.
//

//: Referencing https://swiftui-lab.com/communicating-with-the-view-tree-part-2/
//: and: https://github.com/gahntpo/CollectionView/blob/master/CollectionView/FlowCollectionView/FlowCollectionView.swift
//:  -- I dont think it's working because I'm only getting nil for the anchorPreferenceData,
//:       nil is the default value, but this only seems to get hit once, so only ever see nil, not sure but out of time to figure it out,
//:  

import SwiftUI

struct AnchorKeyView: View {
    @State var innerSize = CGSize.zero
    
    var body: some View {
        GeometryReader{ d in
            BasicRectView()
                .backgroundPreferenceValue(AnchorPreferenceKey.self, { p in
                    GeometryReader { g in
                        ZStack {
                            self.createRect(g: g, p)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                })
            //                .offset(CGSize(width: (self.innerSize.width - d.size.width)/2, height: (self.innerSize.height - d.size.height)/2))
        }
    }
    
    func createRect(g: GeometryProxy, _ p: AnchorPreferenceData?) -> some View {
        let bounds = p != nil ? g[p!.bounds] : .zero
        print("bounds: \(bounds), g.size: \(g.size)")
        
        return Rectangle()
            .fill(Color.clear)
            .frame(width: bounds.size.width, height: bounds.size.height)
            .fixedSize()
            .offset(x: bounds.minX, y: bounds.minY)
    }
    
    struct AnchoredRectView: View {
        var body: some View {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 514, height: 100)
                    .border(Color.blue)
                    .anchorPreference(key: AnchorPreferenceKey.self, value: .bounds, transform: { AnchorPreferenceData(bounds: $0) })
        }
    }
    
    struct AnchorPreferenceData {
        let bounds: Anchor<CGRect>
    }
    
    struct AnchorPreferenceKey: PreferenceKey {
        typealias Value = Optional<AnchorPreferenceData>
        
        static var defaultValue: Optional<Anchor<CGRect>> = nil
        
        static func reduce(value: inout AnchorKeyView.AnchorPreferenceData?, nextValue: () -> AnchorKeyView.AnchorPreferenceData?) {
            value = nextValue()
        }
    }
}

//: Using Geometry reader forces the alignment to be topleading?
//  GR always gives the size the parent "offers"

struct AnchorKeyView_Previews: PreviewProvider {
    static var previews: some View {
        AnchorKeyView()
    }
}
