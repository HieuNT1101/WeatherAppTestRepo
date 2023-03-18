//
//  TenDayForecastView.swift
//  WeatherApp
//
//  Created by Hieu on 17/03/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct TenDayForcastView: View {
    
    let dayWeatherList: [DayWeather]
    let weather: Weather?
    
    @State var presentingModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10-DAY FORECAST")
                .font(.caption)
                .opacity(0.5)
            
            List(dayWeatherList, id: \.date) { dailyWeather in
                HStack {
                    Text(dailyWeather.date.formatAsAbbreviatedDay())
                        .frame(maxWidth: 50, alignment: .leading)
                    
                    Image(systemName: "\(dailyWeather.symbolName)")
                        .foregroundColor(.yellow)
                    
                    Text(dailyWeather.lowTemperature.formatted())
                        .frame(maxWidth: .infinity)
                    
                    Text(dailyWeather.highTemperature.formatted())
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.listRowBackground(Color.clear)
                .onTapGesture{
                    presentingModal.toggle()
                }.sheet(isPresented: $presentingModal) {
                    DetailForecastView(presentedAsModal: self.$presentingModal, weather: weather, date: dailyWeather.date)
                }
            }.listStyle(.plain)

        }
        .frame(height: 300).padding()
        .background(content: {
            Color.secondary
        })
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .foregroundColor(.white)
    }
    
}

struct DetailForecastView: View {
    @Binding var presentedAsModal: Bool
    let weather: Weather?
    var date: Date
    var hourWeatherList: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(date) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        self.presentedAsModal = false
                    }, label: {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .trailing)
                            .padding(.trailing, 30)
                            .padding(.top, 20)
                    })
                }
                    VStack(alignment: .leading) {
                        Text("HOURLY FORECAST for \(date.formatAsAbbreviatedDate())")
                            .font(.caption)
                            .opacity(0.5)
                        List(hourWeatherList, id: \.date) { hourWeatherItem in
                            HStack {
                                Text(hourWeatherItem.date.formatAsAbbreviatedTime())
                                    .frame(maxWidth: 50, alignment: .leading)
                                
                                Image(systemName: "\(hourWeatherItem.symbolName)")
                                    .foregroundColor(.yellow)
                                
                                Text(hourWeatherItem.temperature.formatted())
                                    .frame(maxWidth: .infinity)
                            }.listRowBackground(Color.clear)
                        }.listStyle(.plain)
                    }.padding().background {
                        Color.secondary
                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .foregroundColor(.white).padding(30)
                Spacer()
            }
            
        }
    }
}
