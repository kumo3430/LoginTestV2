//
//  Login.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import Foundation

struct Login {
    let id: Int64
    var email: String
    var password: String
}

struct Tag {
    let id: Int64
    var name: String
    var count: Int
    var create_at: Date
    var update_at: Date
    var deleted_at: Date
}

struct Lives {
    let id: Int64
    var set_up_time: Date
    var _classification: Int
    var _sub_classification: Int
    var task_name: String
    var tag_id1: Int
    var quantity: Int
    var begin: Date
    var finish: Date
    var fulfill: Int
    var _cycle: Int
    var note: String
    var alert_time: Date
    var show_to_club: String
    var completion: Int
    var uid: Int
}

