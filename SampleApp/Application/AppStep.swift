//
//  AppStep.swift
//  SampleApp
//
//  Created by Nguyen Linh on 22/12/2022.
//

import Foundation
import RxFlow
enum AppStep : Step {
    case home
    case borrow(loan: UserLoan)
}
