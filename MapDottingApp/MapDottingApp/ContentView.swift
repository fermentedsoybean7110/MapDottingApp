//
//  ContentView.swift
//  MapDottingApp
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region,
            annotationItems: viewModel.spotList,
            annotationContent: {
            spot in MapAnnotation(coordinate: spot.coordinate, anchorPoint: CGPoint(x: 0, y: 0), content: { Image("PoI") })
        }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
