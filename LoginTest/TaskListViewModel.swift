//
//  TaskListViewModel.swift
//  SQLiteExample
//
//  Created by Amisha I on 26/07/22.
//
import UIPilot
import Foundation

class TaskListViewModel: ObservableObject {

    @Published var allTask: [Lives] = []


    func onAddButtonClick() {
//        appPilot.push(.Insert)
    }

    func getTaskList() {
        allTask = LivesDataStore.shared.getAllTasks()
    }

//    func deleteTask(at indexSet: IndexSet) {
//        let id = indexSet.map { self.allTask[$0].id }.first
//        if let id = id {
//            let delete = TaskDataStore.shared.delete(id: id)
//            if delete {
//                getTaskList()
//            }
//        }
//    }
}
