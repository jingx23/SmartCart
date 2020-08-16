//
//  ContentView.swift
//  SmartCart
//
//  Created by Jan Scheithauer on 12.08.20.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @ObservedObject private var shoppingListViewModel: ShoppingListViewModel = ShoppingListViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(self.shoppingListViewModel.geoMarket?.name ?? "Ort unbekannt")
                        .font(.largeTitle)
                        .frame(width: geometry.size.width / 2, alignment: .leading)
                        .padding(.leading, 10)
                    Spacer()
                }
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))], spacing: 10) {
                        ForEach(self.shoppingListViewModel.shoppingItems ?? [], id: \.self) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50, alignment: .top)
                                Text(item.title)
                            }
                            .frame(width: 110, height: 110)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                            .transition(AnyTransition.opacity.combined(with: .scale))
                            .onTapGesture {
                                withAnimation(.linear(duration: 0.5)) {
                                    self.shoppingListViewModel.remove(item: item)
                                }
                            }
                        }
                    }
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
