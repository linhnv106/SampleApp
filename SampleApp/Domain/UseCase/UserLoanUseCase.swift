//
//  UserLoanUseCase.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import RxSwift
final class UserLoanUseCase {
    let repository: UserLoanRepositoryProtocol
    
    init(repository: UserLoanRepositoryProtocol) {
        self.repository = repository
    }
    func fetchUserLoan() -> Observable<UserLoanDTO?> {
        return repository.fetchUserLoan()
    }
    
}
