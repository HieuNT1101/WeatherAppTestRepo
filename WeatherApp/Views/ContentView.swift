//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hieu on 17/03/2023.
//

import SwiftUI
import CoreLocation
import WeatherKit



struct ContentView: View {
    
    let weatherService = WeatherService.shared
    @StateObject var locationManager = LocationManager()
    @State var weather: Weather?
    
    var hourlyWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                if let weather {
                    VStack {
                        Text("San Francisco")
                            .font(.largeTitle)
                        Text("\(weather.currentWeather.temperature.formatted())")
                    }
                    
                    HourlyForcastView(hourWeatherList: hourlyWeatherData)
                    
                    TenDayForcastView(dayWeatherList: weather.dailyForecast.forecast, weather: weather)
                }
            }
            .padding()
            .task(id: locationManager.currentLocation) {
                do {
                    if let location = locationManager.currentLocation {
                    self.weather =  try await weatherService.weather(for: location)
                    }
                } catch {
                    print(error)
                }
               
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
