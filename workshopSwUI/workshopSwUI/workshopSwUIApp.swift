//
//  workshopSwUIApp.swift
//  workshopSwUI
//
//  Created by Lucas Claro on 23/08/22.
//

import SwiftUI

@main
struct workshopSwUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: ItemViewModel())
        }
    }
}
