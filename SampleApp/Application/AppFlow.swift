//
//  AppFlow.swift
//  SampleApp
//
//  Created by Nguyen Linh on 22/12/2022.
//

import Foundation
import UIKit
import RxFlow
import RxRelay
class AppFlow: Flow {
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    private let appDIContainer: SampleAppDIContainer
    
    init(appDIContainer: SampleAppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .home:
            return navigateToHomeScreen()
        case .borrow(let loan):
            return navigateToBorrowScreen(loan: loan)
            
        }
        
    }
    
    private func navigateToHomeScreen() -> FlowContributors {
        let userLoanViewController = appDIContainer.makeUserLoanViewController()
        rootViewController.viewControllers = [userLoanViewController]
        return .one(flowContributor: .contribute(withNextPresentable: rootViewController, withNextStepper: userLoanViewController.viewModel))
    }
    
    private func navigateToBorrowScreen(loan: UserLoan) -> FlowContributors {
        
        let viewModel = UserBorrowViewModel(loan: loan)
        let userBorrowViewController = UserBorrowViewController(viewModel: viewModel)
        rootViewController.pushViewController(userBorrowViewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: userBorrowViewController,withNextStepper: viewModel))
    }
}
class AppStepper: Stepper {
    
    let steps = PublishRelay<Step>()
    
    var initialStep: Step {
        return AppStep.home
    }
    func readyToEmitSteps() {
        
    }
    
//    @objc func actionBorrow() {
//        self.steps.accept(AppStep.borrow)
//    }
}
