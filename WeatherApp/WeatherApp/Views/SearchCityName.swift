//
//  SearchCityName.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 18/08/2023.
//


import SwiftUI
import CoreLocation

struct SearchCityName: View {
    @AppStorage("nameOfcity") var cityName: String = ""
    @State var weatherInfo: [String] = []
    @State var weatherOfArray: [String] = UserDefaults.standard.array(forKey: "weatherOfArray") as? [String] ?? []

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer(minLength: 30)
                    HStack {
                        
                        TextField("Enter city name", text: $cityName)
                            .padding()
                        Button(action: {
                            searchCityWeather()
                        }, label: {
                            Text("Search")
                                .padding()
                        })
                    }
                    .frame(width: 370, height: 60)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)

                    List {
                        ForEach(weatherInfo, id: \.self) { i in
                            Text(i)
                                .contextMenu {
                                    Button(action: {
                                        deleteWeatherInfo(i)
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .onDelete(perform: deleteWeatherInfos)
                    }

                    Spacer()
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("Add City")
            .onAppear {
                weatherInfo = UserDefaults.standard.array(forKey: "weatherOfArray") as? [String] ?? []
            }
        }
    }

    func searchCityWeather() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName) { [self] (placemarks, error) in
            if let placemark = placemarks?.first,
               let location = placemark.location {
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude

                Task {
                    do {
                        let weatherData = try await WeatherViewModle().getCurrentWeather(latitude: latitude, longitude: longitude)
                        
                let weatherString = "City: \(cityName)                                           Temperature: \(weatherData.main.temp.roundDouble())°C                                        Condition: \(weatherData.weather[0].main)"
                        
                        DispatchQueue.main.async { [self] in
                            weatherInfo.append(weatherString)
                            UserDefaults.standard.set(weatherInfo, forKey: "weatherOfArray")
                        }
                    } catch {
                        DispatchQueue.main.async { [self] in
                            let errorString = "Error: \(error.localizedDescription)"
                            weatherInfo.append(errorString)
                            UserDefaults.standard.set(weatherInfo, forKey: "weatherOfArray")
                        }
                    }
                }
            } else {
                DispatchQueue.main.async { [self] in
                    let errorString = "City not found."
                    weatherInfo.append(errorString)
                    UserDefaults.standard.set(weatherInfo, forKey: "weatherOfArray")
                }
            }
        }
    }

    func deleteWeatherInfo(_ info: String) {
        if let index = weatherInfo.firstIndex(of: info) {
            weatherInfo.remove(at: index)
            UserDefaults.standard.set(weatherInfo, forKey: "weatherOfArray")
        }
    }

    func deleteWeatherInfos(at offsets: IndexSet) {
        weatherInfo.remove(atOffsets: offsets)
        UserDefaults.standard.set(weatherInfo, forKey: "weatherOfArray")
    }
}

struct SearchCityName_Previews: PreviewProvider {
    static var previews: some View {
        SearchCityName()
    }
}
