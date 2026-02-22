//
//  ContentView.swift
//  SwiftUI-ObservedAndStateObjects
//
//  Created by Krish Mishra on 20/02/26.
//

import SwiftUI

struct ObsAndStateView: View {
    
    @State var heroNames : [String] = ["Thor", "Batman"]
    @State var hero: String = ""
    @State var isEmptyText: Bool = true
    
    var body: some View {
        TextField("New hero", text: $hero)
        NavigationStack {
            List(heroNames, id: \.self) { heroName in
                Text(heroName)
            }
            .navigationTitle("Marvel Heroes")
            .toolbar {
                Button {
                    if hero == "" {
                        return
                    }
                    heroNames.append(hero)
                    hero = ""
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    if heroNames.isEmpty {
                        return
                    }
                    heroNames.removeLast()
                } label: {
                    Image(systemName: "minus")
                }
            }
        }
    }
}

#Preview {
    ObsAndStateView()
}

