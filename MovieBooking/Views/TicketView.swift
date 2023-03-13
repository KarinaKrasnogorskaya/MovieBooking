//
//  TicketView.swift
//  MovieBooking
//
//  Created by Карина on 13.03.2023.
//

import SwiftUI

struct TicketView: View {
    @State var animate = false
    var body: some View {
        ZStack {
            
            //MARK: Circle animation
            CircleBackground(color: Color("greenCircle"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 7).repeatForever()) {
                        animate.toggle()
                    }
                }
            
            CircleBackground(color: Color("pinkCircle"))
                .blur(radius: 100)
                .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
            
            // MARK: Mobile Ticket
            VStack(spacing: 30) {
                Text("Mobile Ticket")
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("Once you buy a movie ticket simply scan the barcode to acces to your movie.")
                    .font(.body)
                    .frame(maxWidth: 248)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background(
            LinearGradient(colors: [Color("backgroundColor"), Color("backgroundColor2")], startPoint: .top, endPoint: .bottom)
        )
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
