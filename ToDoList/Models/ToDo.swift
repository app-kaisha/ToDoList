//
//  ToDo.swift
//  ToDoList
//
//  Created by app-kaihatsusha on 07/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Date.now + 60*60*24
    var notes = ""
    var isCompleted = false
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 60*60*24, notes: String = "", isCompleted: Bool = false) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
    }
}


extension ToDo {
    
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        // Add Mock data
        container.mainContext.insert(ToDo(item: "Create SwiftData Lessons", reminderIsOn: true, dueDate: .now + 60*60*24, notes: "Now with iOS 16 & Xcode 18", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Educators Talk", reminderIsOn: true, dueDate: .now + 60*60*44, notes: "Learn about entrepreneurship", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Post Flyers", reminderIsOn: true, dueDate: .now + 60*60*72, notes: "Held in Chile", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Prepare iPhone", reminderIsOn: true, dueDate: .now + 60*60*12, notes: "Refresh old phone", isCompleted: false))
        return container
    }
    
    
    func purgeData() {
        let path = URL.documentsDirectory.appending(component: "toDos")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
}
