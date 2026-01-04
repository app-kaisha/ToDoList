//
//  ToDoListView.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    Text("Welcome to the New View")
                } label: {
                    Text("Show the New View!")
                }  
            }
            .padding()
        }

    }
}

#Preview {
    ToDoListView()
}
