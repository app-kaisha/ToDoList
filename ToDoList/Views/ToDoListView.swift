//
//  ToDoListView.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 04/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case unOrdered = "Unordered"
    case alphabetical = "Z-A"
    case chronological = "Date"
    case completed = "Not Done"
}

struct SortedToDoList: View {
    
    let sortSelection: SortOption
    
    @Environment(\.modelContext) var modelContext
    @Query var toDos: [ToDo]
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .unOrdered:
            _toDos = Query()
        case .alphabetical:
            _toDos = Query(sort: \.item, order: .reverse)
        case .chronological:
            _toDos = Query(sort: \.dueDate, animation: .default)
        case .completed:
            _toDos = Query(filter: #Predicate { $0.isCompleted == false}, animation: .default)
        }
    }
    
    var body: some View {
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
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .unOrdered
    
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortSelection: sortSelection)
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.automatic)
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
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
