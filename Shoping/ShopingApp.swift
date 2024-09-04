//
//  ShopingApp.swift
//  Shoping
//
//  Created by Enrique on 3/09/24.
//

import SwiftUI

@main
struct ShopingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
