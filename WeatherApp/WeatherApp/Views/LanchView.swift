//
//  LanchView.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 19/08/2023.
//

import SwiftUI

struct LanchView: View {
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            
                .ignoresSafeArea()
            VStack{
                Image("2")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .cornerRadius(20)
                
                Text(" Welcome to app weather")
                    .font(.system(size: 30))
            }
        }
        
        
    }
}

struct LanchView_Previews: PreviewProvider {
    static var previews: some View {
        LanchView()
    }
}
