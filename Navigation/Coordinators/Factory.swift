//
//  Factory.swift
//  Navigation
//
//  Created by Ekaterina Saveleva on 02.06.2023.
//

//import UIKit
//
//final class Factory {
//    enum State {
//        case first
//        case second
//        case third
//        case fourth
//    }
//    
//     let navigationController: UINavigationController
//     let state: State
//    
//    init(navigationController: UINavigationController, state: State) {
//        self.navigationController = navigationController
//        self.state = state
//        startModule()
//    }
//   private func startModule() {
//        switch state {
//        case .first:
//            let profileCoordinator = ProfileCoordinator(navigation: navigationController)
//            profileCoordinator.startApplication()
//        case .second:
//            let feedCoordiator = FeedCoordinator(navigation: navigationController)
//            feedCoordiator.startApplication()
//        case .third:
//            ()
//        case .fourth:
//            let loginCoordinator = LoginCoordinator(navigation: navigationController)
//            loginCoordinator.startApplication()
//            
//        }
//    }
//}
