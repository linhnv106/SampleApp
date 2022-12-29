//
//  AppDIContainer.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
final class AppDIContainer {
    
    func makeLoanService() -> LoanServicesProtocol {
        return LoanService()
    }
    func makeUserLoanRepository() -> UserLoanRepositoryProtocol {
        return UserLoanRepository(loanService: makeLoanService())
    }
    func makeUserLoanUseCase() -> UserLoanUseCase {
        return UserLoanUseCase(repository: makeUserLoanRepository())
    }
}
