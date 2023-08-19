//
//  RectangleView.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 17/08/2023.
//

import SwiftUI

struct RectangleView: View {
    var textImage:String = ""
    var text1:String = ""
    var text2:String = ""
    var text3:String = ""
    var body: some View {
       
            ZStack{
                        LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea (.all)
                    

                VStack(alignment: .leading,spacing: 40){
                    
                    HStack{
                        Image(systemName: textImage)
                            .foregroundColor(.black.opacity(0.4))
                        
                        Text(text1)
                            .foregroundColor(.black.opacity(0.4))
//
                        Spacer()

                    }
    
                    Text(text2)
                        .font(.system(size: 40))
//
                    Text(text3)

                        .font(.system(size: 12))
                        .foregroundColor(.black)
                        .lineLimit(0)

                }
                
            .padding()
        }.frame(width: 190,height: 180)
            .cornerRadius(20)
            
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
