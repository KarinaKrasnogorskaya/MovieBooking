//
//  ScrollSection.swift
//  MovieBooking
//
//  Created by Карина on 15.03.2023.
//

import SwiftUI

struct ScrollSection: View {
    
    @State var title = "Now Playing"
    
    @State var posters: [String] = ["poster1", "poster2", "poster3", "poster4", "poster5", "poster6"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(posters.indices, id: \.self) { index in
                        NavigationLink {
                            Text("Booking View")
                        } label: {
                            Image(posters[index])
                                .resizable()
                                .frame(width: 100, height: 130)
                                .cornerRadius(10)
                        }
                       
                    }
                }
                .offset(x: 20)
                .padding(.trailing, 40)
            }
        }
    }
}

struct ScrollSection_Previews: PreviewProvider {
    static var previews: some View {
        ScrollSection()
    }
}