//
//  DataStore.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import Foundation
import SQLite

class LivesDataStore {
    // 設定放資料庫的資料夾名稱
    //static let DIR_TASK_DB = "LoginTestDB"
    // 設定資料庫名稱
    static let STORE_NAME = "loginTask.sqlite3"

    private let lives = Table("Lives")

    // 設定資料庫欄位名稱
    private let id = Expression<Int64>("id")
//    private let loginEmail = Expression<String>("loginEmail")
//    private let loginPassword = Expression<String>("loginPassword")
    private let set_up_time = Expression<Date>("set_up_time")
    private let _classification = Expression<Int>("_classification")
    private let _sub_classification = Expression<Int>("_sub_classification")
    private let task_name = Expression<String>("task_name")
    private let tag_id1 = Expression<Int>("tag_id1")
    private let quantity = Expression<Int>("quantity")
    private let begin = Expression<Date>("begin")
    private let finish = Expression<Date>("finish")
    private let fulfill = Expression<Int>("fulfill")
    private let _cycle = Expression<Int>("_cycle")
    private let note = Expression<String>("note")
    private let alert_time = Expression<Date>("alert_time")
    private let show_to_club = Expression<String>("show_to_club")
    private let completion = Expression<Int>("completion")
    private let uid = Expression<Int>("uid")
    

    //連接資料庫
    static let shared = LivesDataStore()

    private var db: Connection? = nil

    // 初始化資料庫
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let dirPath = docDir.appendingPathComponent(TaskDataStore.DIR_TASK_DB)

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
            try database.run(lives.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(set_up_time)
                table.column(_classification)
                table.column(_sub_classification)
                table.column(task_name)
                table.column(tag_id1)
                table.column(quantity)
                table.column(begin)
                table.column(finish)
                table.column(fulfill)
                table.column(_cycle)
                table.column(note)
                table.column(alert_time)
                table.column(show_to_club)
                table.column(completion)
                table.column(uid)
            })
//            print("Table Created...")
        } catch {
//            print(error)
        }
    }
    //

    // 將回傳進來的帳號密碼資料放到資料庫裡面
    func insert(set_up_time: Date,
                _classification: Int,
                _sub_classification: Int,
                task_name: String,
                tag_id1: Int,
                quantity: Int,
                begin: Date,
                finish: Date,
                fulfill: Int,
                _cycle: Int,
                note: String,
                alert_time: Date,
                show_to_club: String,
                completion: Int,
                uid:Int) -> Int64? {
        guard let database = db else { return nil }

        let insert = lives.insert(self.set_up_time <- set_up_time,
                                  self._classification <- _classification,
                                  self._sub_classification <- _sub_classification,
                                  self.task_name <- task_name,
                                  self.tag_id1 <- tag_id1,
                                  self.quantity <- quantity,
                                  self.begin <- begin,
                                  self.finish <- finish,
                                  self.fulfill <- fulfill,
                                  self._cycle <- _cycle,
                                  self.note <- note,
                                  self.alert_time <- alert_time,
                                  self.show_to_club <- show_to_club,
                                  self.completion <- completion,
                                  self.uid <- uid)

        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

    // 打開會面最一開始會先執行此function
    func getAllTasks() -> [Lives] {
        var lives: [Lives] = []
        guard let database = db else { return [] }
        
        do {
            for live in try database.prepare(self.lives) {
                lives.append(Lives(id: live[id], set_up_time: live[set_up_time], _classification: live[_classification], _sub_classification: live[_sub_classification], task_name: live[task_name], tag_id1: live[tag_id1], quantity: live[quantity], begin: live[begin], finish: live[finish], fulfill: live[fulfill], _cycle: live[_cycle], note: live[note], alert_time: live[alert_time], show_to_club: live[show_to_club], completion: live[completion], uid: live[uid]))
            }
        } catch {
            print(error)
        }
        return lives
    }

    func findTask(livesId: Int64) -> Lives? {
        var live: Lives = Lives(id: livesId, set_up_time: Date(), _classification: 0, _sub_classification: 0, task_name: "", tag_id1: 0, quantity: 0, begin: Date(), finish: Date(), fulfill: 0, _cycle: 0, note: "", alert_time: Date(), show_to_club: "", completion: 0, uid: 0)
        guard let database = db else { return nil }

        let filter = self.lives.filter(id == livesId)
        do {
            for t in try database.prepare(filter) {
                live.set_up_time = t[set_up_time]
                live._classification = t[_classification]
                live._sub_classification = t[_sub_classification]
                live.task_name = t[task_name]
                live.tag_id1 = t[tag_id1]
                live.quantity = t[quantity]
                live.begin = t[begin]
                live.finish = t[finish]
                live.fulfill = t[fulfill]
                live._cycle = t[_cycle]
                live.note = t[note]
                live.alert_time = t[alert_time]
                live.show_to_club = t[show_to_club]
                live.completion = t[completion]
                live.uid = t[uid]
            }
        } catch {
            print(error)
        }
        return live
    }


    func update(id: Int64, email: String, password: String) -> Bool {
        guard let database = db else { return false }

        let task = lives.filter(self.id == id)
        do {
            let update = task.update([

                self.set_up_time <- set_up_time,
                self._classification <- _classification,
                self._sub_classification <- _sub_classification,
                self.task_name <- task_name,
                self.tag_id1 <- tag_id1,
                self.quantity <- quantity,
                self.begin <- begin,
                self.finish <- finish,
                self.fulfill <- fulfill,
                self._cycle <- _cycle,
                self.note <- note,
                self.alert_time <- alert_time,
                self.show_to_club <- show_to_club,
                self.completion <- completion,
                self.uid <- uid
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
            let filter = lives.filter(self.id == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
