//
//  SeatsView.swift
//  MovieBooking
//
//  Created by Карина on 16.03.2023.
//

import SwiftUI

struct SeatsView: View {
    @Environment(\.dismiss) var diamiss
    @State var animate = false
    @State var showButton = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                CircleButton(action: {
                    diamiss()
                }, image: "arrow.left")
                
                Spacer()
                
                Text("Choose Seats")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                CircleButton(action: {}, image: "calendar")
            }
            .padding(.top, 46)
            .padding(.horizontal, 20)
            
            Image("frontSeat")
                .padding(.top, 55)
                .glow(color: Color("pink"), radius: 20)
            
            Image("seats")
                .frame(height: 240)
                .padding(.top, 60)
                .padding(.horizontal, 20)
                .onTapGesture {
                    withAnimation(.spring()) {
                        showButton = true
                    }
                }
            
            HStack(spacing: 20) {
                StatusUI()
                
                StatusUI(color: Color("majenta"), text: "Reserved")
                
                StatusUI(color: Color("cyan"), text: "Selected")
            }
            .padding(.top, 60)
            
            ZStack(alignment: .topLeading) {
                Circle()
                    .frame(width: 200, height: 230)
                    .foregroundColor(Color("purple"))
                    .blur(radius: animate ? 70 : 100)
                    .offset(x: animate ? -100 : 20, y: animate ? -20 : 20)
                    .task {
                        withAnimation(.easeInOut(duration: 7).repeatForever()) {
                            animate.toggle()
                        }
                    }
                
                Circle()
                    .frame(width: 200, height: 230)
                    .foregroundColor(Color("lightBlue"))
                    .blur(radius: animate ? 50 : 100)
                    .offset(x: animate ? 50 : 70, y: animate ? 70 : 30)
                
                Circle()
                    .frame(width: 200, height: 230)
                    .foregroundColor(Color("pink"))
                    .blur(radius: animate ? 70 : 100)
                    .offset(x: animate ? 150 : 170, y: animate ? 90 : 100)
                
                
                
                VStack(alignment: .leading, spacing: 30) {
                    HStack(spacing: 10) {
                        Image(systemName: "calendar")
                        Text("Aprel 22, 2022")
                        Circle()
                            .frame(width: 6, height: 6)
                        Text("6 p.m.")
                    }
                    
                    HStack(spacing: 10) {
                        Image(systemName: "ticket.fill")
                        Text("VIP Section")
                        Circle()
                            .frame(width: 6, height: 6)
                        Text("Seat 9, 10")
                    }
                    
                    HStack(spacing: 10) {
                        Image(systemName: "cart")
                        Text("Total: 30$")
                    }
                }
                .padding(42)
                .font(.headline)
                
                HStack {
                    Spacer()
                    
                    RoundButton {
                        NavigationUtil.popToRootView()
                    }
                }
                .frame(maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .clipped()
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
            .padding(.top, 50)
            .offset(y: showButton ? 0 : 250)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("backgroundColor"))
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct SeatsView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsView()
    }
}
