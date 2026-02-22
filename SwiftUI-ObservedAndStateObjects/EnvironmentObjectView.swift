//
//  ContentView.swift
//  SwiftUI-ObservedAndStateObjects
//
//  Created by Krish Mishra on 20/02/26.
//

//Env objects are used when we need to pass data from parent to any child without passing it unnecessarily to the other children

//If I use environment object in the main app file then every view would be able to access that object and value in it

import SwiftUI
internal import Combine

class UserData : ObservableObject {
    @Published var userName = "Krish"
}

struct ParentView: View {
    
    @State var userData = UserData()
    var body: some View {
        NavigationStack {
            Text(userData.userName)
            NavigationLink(destination: Child1View()) {
                Text("Go to Child screen 1")
            }
        }
        .environmentObject(userData)
        //all children can use userData now, name doesnt matter but the type matters
    }
}

struct Child1View: View {
    var body: some View {
        VStack{
            NavigationLink("Go to Child Screen 2", destination: Child2View())
        }
    }
}

struct Child2View: View {
    var body: some View {
        VStack {
            NavigationLink("Go to Last screen", destination: LastView())
        }
    }
}

struct LastView: View {
    
    @EnvironmentObject var abc : UserData
    // to access env object, never forget to add referenced object in parent view or the preview will crash
    
    var body: some View {
        VStack {
            Text(abc.userName)
            Text("Last Screen")
        }
    }
}

#Preview {
    ParentView()
}

