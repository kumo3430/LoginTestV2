//
//  LoginInsertViewModel.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/29.
//

import Foundation

class LoginInsertViewModel: ObservableObject {
    
    @Published var allTask: [Login] = []

    @Published var email: String = ""
    @Published var password: String = ""
    
    // 再點選Button的時候會執行此Funtion
    func onAddButtonClick() {
        if email != "" {
            // 變數設定為 (dataStore: viewModel)
            // 執行 TaskDataStore裡的insert()，並將剛剛輸入的帳號密碼回傳進function
            let id = TaskDataStore.shared.insert(email: email, password: password)
            // （功能保留）
            /* if id != nil {
                
            } */
        }
    }
    
    func getTaskList() {
        // 執行 TaskDataStore裡的getAllTasks()
        allTask = TaskDataStore.shared.getAllTasks()
    }
    
}
