//
//  LoginTestApp.swift
//  LoginTest
//
//  Created by 呂沄 on 2023/1/2.
//

import SwiftUI

@main

struct LoginTestApp: App {
    
    var body: some Scene {
    
        WindowGroup {
            ContentView(viewModel: LoginInsertViewModel())
        }
    }
}

