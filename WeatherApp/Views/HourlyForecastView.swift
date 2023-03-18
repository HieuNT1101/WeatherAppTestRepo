//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Hieu on 17/03/2023.
//

import SwiftUI
import WeatherKit

struct HourlyForcastView: View {
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("HOURLY FORECAST")
                .font(.caption)
                .opacity(0.5)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 20) {
                            Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .foregroundColor(.yellow)
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.medium)
                        }.padding()
                    }
                }
            }
        }.padding().background {
            Color.secondary
        }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .foregroundColor(.white)
    }
    
}
