//
//  SportWalkInertViewModel.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/2/13.
//

import Foundation

class TagInsertViewModel: ObservableObject {
    @Published var allTag: [Tag] = []
    
    @Published var tagName: String = ""
//    @Published var tagCount: String = ""
    @Published var create_at: Date = Date()
//    @Published var update_at: Date = Date()
//    @Published var deleted_at: Date = Date()
    @Published var uid: Int = 0
 
    
    // 再點選Button的時候會執行此Funtion
    func onAddButtonClick() {
        if tagName != "" {
            // 變數設定為 (dataStore: viewModel)
            // 執行 TaskDataStore裡的insert()，並將剛剛輸入的帳號密碼回傳進function
            let id = TagDataStore.shared.insert(tagName: tagName,
                                                  create_at: create_at,
                                                uid:uid)
            // （功能保留）
            /* if id != nil {
                
            } */
        }
    }
    
    func getTaskList() {
        // 執行 TaskDataStore裡的getAllTasks()
        allTag = TagDataStore.shared.getAllTasks()
    }
    
    
    
}
