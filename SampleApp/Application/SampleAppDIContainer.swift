//
//  SampleAppDIContainer.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation

public final class SampleAppDIContainer {
    private let service: LoanServicesProtocol
    init(service: LoanServicesProtocol) {
        self.service = service
    }
    
    func makeUserLoanRepository() -> UserLoanRepositoryProtocol {
        return UserLoanRepository(loanService: self.service)
    }
    func makeUserLoanUseCase() -> UserLoanUseCase {
        return UserLoanUseCase(repository: self.makeUserLoanRepository())
    }
    func makeUserLoanViewModel() -> UserLoanViewModel {
        return UserLoanViewModel(useCase: makeUserLoanUseCase())
    }
    func makeUserLoanViewController() -> UserLoanViewController {
        return UserLoanViewController(viewModel: makeUserLoanViewModel())
    }
    
}
