//
//  ContentView.swift
//  SwiftUI-ObservedAndStateObjects
//
//  Created by Krish Mishra on 20/02/26.
//

// whenever we need to interact with the calsses, wee must use StateObjects to get implemented changes from other class

//whenever any view is dependent on the variables and the view re renders then Observable ojects also re initiate and the data persisting will get cleared

//this is not the case with State objects because these tend to persist the data iin them even after the view re renders or reloads

//state object should lways be used in our parent class and on our child screen we can use Observed Object

import SwiftUI
internal import Combine

class ViewModel : ObservableObject {
    
    @Published var heroNames : [String] = []
    //so that change can occur in heroNames visually in list
    
    init() {
        getAllDefaultHeroNames()
    }
    
    func getAllDefaultHeroNames() {
        heroNames.append("Thor")
        heroNames.append("Iron Man")
    }
    
    func addNewName (_ name : String) {
        heroNames.append(name)
        print(heroNames)
    }
}

struct StateAndObsView: View {
    
    @ObservedObject var viewModel : ViewModel = ViewModel()
    @State var path : [String] = []
    
    var body: some View {
        NavigationStack (path: $path) {
            List(viewModel.heroNames, id: \.self) { heroName in
                Text(heroName)
            }
            .navigationTitle(Text("Marvel Heroes"))
            .toolbar(content: {
                Button {
                    viewModel.addNewName("Captain America")
                } label: {
                    Image(systemName: "plus")
                }
            })
            
            .toolbar(content: {
                Button {
                    path.append("Screen 2")
                } label: {
                    Image(systemName: "heart")
                }
            })
            .navigationDestination(for: String.self) { _ in
                FavoriteView(viewModel: viewModel)
            }
        }
    }
}

struct FavoriteView : View {
    @ObservedObject var viewModel : ViewModel
    
    var body: some View {
        Text("favorite screen")
    }
}

#Preview {
    StateAndObsView()
}

