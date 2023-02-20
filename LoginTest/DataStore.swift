//
//  DataStore.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import Foundation
import SQLite

class TaskDataStore {
    // 設定放資料庫的資料夾名稱
    static let DIR_TASK_DB = "LoginTestDB"
    // 設定資料庫名稱
    static let STORE_NAME = "loginTask.sqlite3"

    private let tasks = Table("loginTests")

    // 設定資料庫欄位名稱
    private let id = Expression<Int64>("id")
    private let loginEmail = Expression<String>("loginEmail")
    private let loginPassword = Expression<String>("loginPassword")

    //連接資料庫
    static let shared = TaskDataStore()

    private var db: Connection? = nil

    // 初始化資料庫
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let dirPath = docDir.appendingPathComponent(Self.DIR_TASK_DB)

            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(Self.STORE_NAME).path
                db = try Connection(dbPath)
                createTable()
                print("SQLiteDataStore init successfully at: \(dbPath) ")
            } catch {
                db = nil
                print("SQLiteDataStore init error: \(error)")
            }
        } else {
            db = nil
        }
    }

    private func createTable() {
        guard let database = db else {
            return
        }
        do {
            try database.run(tasks.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(loginEmail, unique: true)
                table.column(loginPassword)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }

    // 將回傳進來的帳號密碼資料放到資料庫裡面
    func insert(email: String, password: String) -> Int64? {
        guard let database = db else { return nil }

        let insert = tasks.insert(self.loginEmail <- email,
                                  self.loginPassword <- password)

        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

    // 打開會面最一開始會先執行此function
    func getAllTasks() -> [Login] {
        var tasks: [Login] = []
        guard let database = db else { return [] }
        
        do {
            for task in try database.prepare(self.tasks) {
                tasks.append(Login(id: task[id],email: task[loginEmail], password: task[loginPassword]))
            }
        } catch {
            print(error)
        }
        return tasks
    }

    func findTask(taskId: Int64) -> Login? {
        var task: Login = Login(id: taskId, email: "", password: "")
        guard let database = db else { return nil }

        let filter = self.tasks.filter(id == taskId)
        do {
            for t in try database.prepare(filter) {

                task.email = t[loginEmail]
                task.password = t[loginPassword]

            }
        } catch {
            print(error)
        }
        return task
    }


    func update(id: Int64, email: String, password: String) -> Bool {
        guard let database = db else { return false }

        let task = tasks.filter(self.id == id)
        do {
            let update = task.update([

                loginEmail <- email,
                loginPassword <- password

            ])
            if try database.run(update) > 0 {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }

    func delete(id: Int64) -> Bool {
        guard let database = db else {
            return false
        }
        do {
            let filter = tasks.filter(self.id == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
