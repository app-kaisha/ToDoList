//
//  ToDoListView.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ToDoListView: View {
    var toDos = ["Learn Swift",
                 "Change the World",
                 "Bring the Awesome",
                 "Tak A Break",]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { todo in
                    NavigationLink {
                        DetailView(passedValue: todo)
                    } label: {
                        Text(todo)
                    }

                    
                }

            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }

    }
}

#Preview {
    ToDoListView()
}
