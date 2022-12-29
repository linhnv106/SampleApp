//
//  UserLoanRepository.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import RxSwift
public protocol UserLoanRepositoryProtocol {
    func fetchUserLoan() -> Observable<UserLoanDTO?>
}
public class UserLoanRepository: UserLoanRepositoryProtocol {
    let loanService: LoanServicesProtocol

    init(loanService: LoanServicesProtocol) {
        self.loanService = loanService
    }
    public func fetchUserLoan() -> Observable<UserLoanDTO?> {
        return self.loanService.fetchUserLoan()
    }
}
