//
//  CityViewViewModel.swift
//  Meteo
//
//  Created by Georgina Jezabel Castillo Morales on 10/18/24.
//

import SwiftUI

import CoreLocation

final class CityViewViewModel: ObservableObject {
    
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = "San Francisco" {
        didSet{
            getLocation()
        }
    }
    
    private lazy var dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    private lazy var dayformatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
        
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocation ()
    }
    
    var date: String {
        return dateFormater.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        if weather.current.weather.count > 0{
            return weather.current.weather[0].icon
        }
        return "sun.max.fill"
    }
    
    //This creates the temperature object
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String{
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return ""
    }
    
    var windSpeed: String{
        return String (format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String{
        return String (format:"%0.0f%%", weather.current.dew_point)
    }
    
    
    //This funciont gets the
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    
    //This function gets the temperature
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayformatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places =  placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    //Gets the specific weather based on the lattitud
    private func getWeather (coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLfor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
    
        //We set a random location in case the location doesn't respond
        } else {
            let urlString = API.getURLfor(lat:37.5485, lon:-121.9886)
            getWeatherInternal(city: city, for: urlString)
                
        }
    }

    //Call a function to get weather information, calls the network
    //we construct the URL
    //the self.weather gives sets to our object weathe the information fetched
    
    private func getWeatherInternal(city: String, for urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
        }
        NetworkManager<WeatherResponse>.fetch(for: url){ result in
            switch result {
            case .sucess(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let err):
                print("Failed to fetch weather data: \(err)")
                
            }
        }
    }
//This JSON permits to show the animation based on the name of each icon and its state
                                              
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
            case"01d":
                return "dayClearSky"
            case"01n":
                return "nightClearSky"
            case"02d":
                return "dayFewClouds"
            case"02n":
                return "nightFewClouds"
            case"03d":
                return "dayScatteredClouds"
            case"03n":
                return "nightScatteredClouds"
            case"04d":
                return "dayBrokenClouds"
            case"04n":
                return "nightBrokenClouds"
            case"09d":
                return "dayshowerRains"
            case"09n":
                return "nightshowerRains"
            case"10d":
                return "dayRain"
            case"10n":
                return "nightRain"
            case"11d":
                return "dayThunderstorm"
            case"11n":
                return "nightThunderstorm"
            case"13d":
                return "daySnow"
            case"13n":
                return "nightSnow"
            case"50d":
                return "dayMist"
            case"50n":
                return "nightMist"
            default:
                return "dayClearSky"
                
        }
    }
  
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case"01d":
                return Image(systemName: "sun.max.fill") //"claer_sky_day"
            case"01n":
                return Image(systemName: "moon.fill") //"nightClearSky"
            case"02d":
                return Image(systemName: "cloud.sun.fill") //"dayFewClouds"
            case"02n":
                return Image(systemName: "cloud.moon.fill") //"nightFewClouds"
            case"03d":
                return Image(systemName: "cloud.fill") //"dayScatteredClouds"
            case"03n":
                return Image(systemName: "cloud.fill") //"nightScatteredClouds"
            case"04d":
                return Image(systemName: "cloud.fill") //"dayBrokenClouds"
            case"04n":
                return Image(systemName: "cloud.fill") //"nightBrokenClouds"
            case"09d":
                return Image(systemName: "cloud.drizzle.fill") //"dayshowerRains"
            case"09n":
                return Image(systemName: "cloud.drizzle.fill") //"nightshowerRains"
            case"10d":
                return Image(systemName: "cloud.heavyrain.fill") //"dayRain"
            case"10n":
                return Image(systemName: "cloud.heavyrain.fill") //"nightRain"
            case"11d":
                return Image(systemName: "cloud.bolt.fill") //"dayThunderstorm"
            case"11n":
                return Image(systemName: "cloud.bolt.fill") //"nightThunderstorm"
            case"13d":
                return Image(systemName: "cloud.snow.fill") //"daySnow"
            case"13n":
                return Image(systemName: "cloud.snow.fill") //"nightSnow"
            case"50d":
                return Image(systemName: "cloud.fog.fill") //"dayMist"
            case"50n":
                return Image(systemName: "cloud.fog.fill") //"nightMist"
            default:
                return Image(systemName: "sun.max.fill")
            
            
                
            }
            
        }
}






