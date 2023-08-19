//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 17/08/2023.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @StateObject var locationManager = LocationViewModle ()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var weather: ResponseBody?
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea (.all)
                ScrollView {
//                    VStack(spacing: 12){
                       
                            
                           VStack{
                               if let weather = weather  {
                               Text(weather.name)
                                   .font(.system(size: 35))
                               Text(weather.main.feelsLike.roundDouble()+"˚")
                                   .font(.system(size: 50))
                               Text(weather.weather[0].main)
                               
                               
                               HStack{
                                   Text("H:\(weather.main.tempMax.roundDouble()+"˚")")
                                   Text("L\(weather.main.tembMin.roundDouble()+"˚")")
                                   
                                   
                               }
                               
                               LazyVGrid(columns: columns,alignment: .center,spacing: 12){
                                   RectangleView(textImage:"wind",text1: "WIND",text2: ("\(weather.wind.speed.roundDouble()) Km"))
                                   
                                   
                                   RectangleView(textImage:"humidity",text1: "HUMIDITY",text2: ("\(weather.main.humidity.roundDouble())%"),text3: "")
                                   
                                   RectangleView(textImage: "thermometer",text1: "FEELS LIKE",text2: weather.main.feelsLike.roundDouble()+"˚",text3: "Wind is making it feel cooler.")
                                   
                                   
                                   RectangleView(textImage: "thermometer",text1: "PRESSURE",text2: weather.main.pressure.roundDouble()+"hPa",text3: "")
                               }
                               .padding()
                           }
                        }
                        
                    }
//                }
                
            }
            
            NavigationLink(destination: {SearchCityName()}, label: {Image(systemName: "list.bullet.rectangle.fill")
                
                    .font(.system(size: 40))
            })
        }
        
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
