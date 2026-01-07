//
//  ToDoListView.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    
    var toDos = ["Learn Swift",
                 "Build Apps",
                 "Change the World",
                 "Bring the Awesome",
                 "Take A Break",]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { todo in
                    NavigationLink {
                        DetailView(toDo: todo)
                    } label: {
                        Text(todo)
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented){
                NavigationStack {
                    DetailView(toDo: "")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                    }

                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
