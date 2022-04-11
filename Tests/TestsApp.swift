//
//  TestsApp.swift
//  Tests
//
//  Created by Andres camilo Raigoza misas on 1/03/22.
//

import SwiftUI
import Firebase

@main
struct TestsApp: App {
    
    // Conect App delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var vm = ItemListViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(vm: vm)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                vm.saveItemsToDatabase()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
