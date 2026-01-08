//
//  ToDoListView.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext
    
    @Query var toDos: [ToDo]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { toDo in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                                .onTapGesture {
                                    toDo.isCompleted.toggle()
                                    
                                    //force save
                                    guard let _ = try? modelContext.save() else {
                                        print("😡 ERROR: Save after .toggle on ToDoListView did not work!")
                                        return
                                    }
                                }
                            
                            NavigationLink {
                                DetailView(toDo: toDo)
                            } label: {
                                Text(toDo.item)
                                
                            }
                        }
                        .font(.title2)
                        
                        HStack {
                            Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                            if toDo.reminderIsOn {
                                Image(systemName: "calendar.badge.clock")
                                    .symbolRenderingMode(.multicolor)
                            }
                        }
                    }
                }
                // Alternate for swipe delete
                .onDelete { indexSet in
                    indexSet.forEach({modelContext.delete(toDos[$0])})
                    // force save for simulator
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save after .onDelete on ToDoListView did not work!")
                        return
                    }
                    
                }
                
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .sheet(isPresented: $sheetIsPresented){
                NavigationStack {
                    DetailView(toDo: ToDo())
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
        .modelContainer(ToDo.preview)
}
