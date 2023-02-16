//
//  DataStore.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import Foundation
import SQLite

class TagDataStore {
    // 設定放資料庫的資料夾名稱
    //static let DIR_TASK_DB = "LoginTestDB"
    // 設定資料庫名稱
    static let STORE_NAME = "loginTask.sqlite3"

    private let tags = Table("tag")

    // 設定資料庫欄位名稱
    private let id = Expression<Int64>("id")
    private let tagName = Expression<String>("tagName")
    private let uid = Expression<Int>("uid")
    private let tagCount = Expression<Int>("tagCount")
    private let create_at = Expression<Date>("create_at")
    private let update_at = Expression<Date>("update_at")
    private let deleted_at = Expression<Date>("deleted_at")

    //連接資料庫
    static let shared = TagDataStore()

    private var db: Connection? = nil

    // 初始化資料庫
    private init() {
        if let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let dirPath = docDir.appendingPathComponent(TaskDataStore.DIR_TASK_DB)

            do {
                try FileManager.default.createDirectory(atPath: dirPath.path, withIntermediateDirectories: true, attributes: nil)
                let dbPath = dirPath.appendingPathComponent(TaskDataStore.STORE_NAME).path
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
            try database.run(tags.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(tagName)
                table.column(uid)
                table.column(tagCount)
                table.column(create_at)
                table.column(update_at)
                table.column(deleted_at)
            })
            print("Table Created...")
        } catch {
            print(error)
        }
    }

    // 將回傳進來的帳號密碼資料放到資料庫裡面
//    func insert(tagName: String, uid: Int, tagCount: Int, create_at: Date, update_at: Date,deleted_at: Date) -> Int64? {
//        guard let database = db else { return nil }
//
//        let insert = tags.insert(self.tagName <- tagName,
//                                 self.uid <- uid,
//                                 self.tagCount <- tagCount,
//                                 self.create_at <- create_at,
//                                 self.update_at <- update_at,
//                                 self.deleted_at <- deleted_at)
//
//        do {
//            let rowID = try database.run(insert)
//            return rowID
//        } catch {
//            print(error)
//            return nil
//        }
//    }
    func insert(tagName: String, uid: Int, create_at: Date) -> Int64? {
        guard let database = db else { return nil }

        let insert = tags.insert(self.tagName <- tagName,
                                 self.uid <- uid,
                                 self.create_at <- create_at)

        do {
            let rowID = try database.run(insert)
            return rowID
        } catch {
            print(error)
            return nil
        }
    }

    // 打開會面最一開始會先執行此function
    func getAllTasks() -> [Tag] {
        var tags: [Tag] = []
        guard let database = db else { return [] }
        do {
            for tag in try database.prepare(self.tags) {
                tags.append(Tag(id: tag[id],name: tag[tagName],uid: tag[uid],count: tag[tagCount],create_at: tag[create_at], update_at: tag[update_at], deleted_at: tag[deleted_at]))
            }
        } catch {
            print(error)
        }
        return tags
    }

    func findTask(tagId: Int64) -> Tag? {
        var tag: Tag = Tag(id: tagId, name: "", uid: 0,count: 1,create_at: Date(),update_at: Date(), deleted_at: Date())
        guard let database = db else { return nil }

        let filter = self.tags.filter(id == tagId)
        do {
            for t in try database.prepare(filter) {

                tag.name = t[tagName]
                tag.uid = t[uid]
                tag.count = t[tagCount]
                tag.create_at = t[create_at]
                tag.update_at = t[update_at]
                tag.deleted_at = t[deleted_at]

            }
        } catch {
            print(error)
        }
        return tag
    }


    func update(id: Int64, name: String, count: Int) -> Bool {
        guard let database = db else { return false }

        let task = tags.filter(self.id == id)
        do {
            let update = task.update([
                // 不確定
                tagName <- name,
                tagCount <- count

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
            let filter = tags.filter(self.id == id)
            try database.run(filter.delete())
            return true
        } catch {
            print(error)
            return false
        }
    }
}
