//
//  LoanServices.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import RxSwift
public protocol LoanServicesProtocol {
    func fetchUserLoan() -> Observable<UserLoanDTO?>
}
public class LoanService: LoanServicesProtocol {
    public func fetchUserLoan() -> Observable<UserLoanDTO?> {
        let mockData = UserLoanDTO(availableLOC: CurrencyDTO(currencyCode: "SGD", val: 10000), offeredInterestRate: 3.00, offeredEIR: 5.45, min: CurrencyDTO(currencyCode: "SGD", val: 200), max: CurrencyDTO(currencyCode: "SGD", val: 10000))
        return Observable.create { observer in
                    observer.on(.next(mockData))
                    observer.on(.completed)
                    return Disposables.create()
                }
    }
}
