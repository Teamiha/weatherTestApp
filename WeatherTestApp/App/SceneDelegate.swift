//
//  SceneDelegate.swift
//  WeatherTestApp
//
//  Created by Михаил Светлов on 05.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        let assemblyBilder = ModuleBuilder()
        let router = Router(navigationController: navigationController, assemblyBilder: assemblyBilder)
        router.showCityChosen()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

