//
//  Tickets.swift
//  MovieBooking
//
//  Created by Карина on 14.03.2023.
//

import SwiftUI

struct Tickets: View {
    
   @State var tickets: [TicketModel] = [
        TicketModel(image: "thor", title: "Thor", subtitle: "Love and Thunder", top: "thor-top", bottom: "thor-bottom"),
        TicketModel(image: "panther", title: "Black Panther", subtitle: "Wakanda Forever", top: "panther-top", bottom: "panther-bottom"),
        TicketModel(image: "scarlet", title: "Doctor Strange", subtitle: "in the Multiverse of Madness", top: "scarlet-top", bottom: "scarlet-bottom")
    ]
    
    var body: some View {
        ZStack {
            ForEach(tickets) { ticket in
                InfiniteStackView(tickets: $tickets, ticket: ticket)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
    }
}

struct Tickets_Previews: PreviewProvider {
    static var previews: some View {
        Tickets()
    }
}

struct InfiniteStackView: View {
    
    @Binding var tickets: [TicketModel]
    var ticket: TicketModel
    
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = .zero
    
    @State var height: CGFloat = 0
    
    var body: some View {
        VStack {
            Ticket(title: ticket.title, subtitle: ticket.subtitle, top: ticket.top, bottom: ticket.bottom, height: $height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity )
        .zIndex(Double(tickets.count) - getIndex())
        .rotationEffect(.init(degrees: getRolation(angle: 10)))
        .rotationEffect(getIndex() == 1 ? .degrees(-6) : .degrees(0))
        .rotationEffect(getIndex() == 2 ? .degrees(6) : .degrees(0))
        .scaleEffect(getIndex() == 0 ? 1 : 0.9)
        .offset(x: getIndex() == 1 ? -40 : 0)
        .offset(x: getIndex() == 2 ? 40 : 0)
        .offset(x: offset)
        // Жесты при перетягивании карточки
        .gesture(
           DragGesture()
            .updating($isDragging, body: { _, out, _ in
                out = true
            })
            .onChanged({ value in
                var translashion = value.translation.width
                translashion = tickets.first?.id == ticket.id ? translashion : 0
                translashion = isDragging ? translashion : 0
                
                withAnimation(.easeInOut(duration: 0.3)) {
                    offset = translashion
                }
            })
            .onEnded({ value in
                
                let widht = UIScreen.main.bounds.width
                let swipedRight = offset > (widht / 2)
                withAnimation(.easeInOut(duration: 0.5)) {
                    if swipedRight {
                        offset = widht
                        removeAndAdd()
                    } else {
                        offset = .zero
                    }
                    
                }
            })
        
        )
    }
    
    func getIndex() -> CGFloat {
        let index = tickets.firstIndex { ticket in
            return self.ticket.id == ticket.id
        } ?? 0
        return CGFloat(index)
    }
    
    func getRolation(angle: Double) -> Double {
        let weght = UIScreen.main.bounds.width
        let progress = offset / weght
        
        return Double(progress * angle)
    }
    
    func removeAndAdd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            var updateTicket = ticket
            updateTicket.id = UUID().uuidString
            
            tickets.append(updateTicket)
            
            withAnimation(.spring()) {
                tickets.removeFirst()
            }
            
                          }
    }
}
