//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Nguyen Linh on 22/12/2022.
//

import UIKit
import RxFlow
import RxSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let disposeBag = DisposeBag()
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    let service = LoanService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppAppearance.setupAppearance()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        self.coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        self.coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        
        let appDIContainer = SampleAppDIContainer(service: service)
        
        let appFlow = AppFlow(appDIContainer: appDIContainer)
        
        self.coordinator.coordinate(flow: appFlow, with: AppStepper())
        
        Flows.use(appFlow, when: .created) { root in
            self.window?.rootViewController = root
            self.window?.makeKeyAndVisible()
        }
        
        
        return true
    }
    
}

