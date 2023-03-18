//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Hieu on 17/03/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("night")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.vertical)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
