//
//  UserBorrowViewModel.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation

import RxFlow
import RxRelay
import RxSwift
import RxCocoa
final class UserBorrowViewModel: ViewModelType, Stepper {
    
    var loan: UserLoan
    
    public init(loan: UserLoan) {
        self.loan = loan
    }
    let steps = PublishRelay<Step>()
    
    struct Input {
        let number: Observable<String>
        let validate: Observable<String?>
    }
    struct Output {
        let isValidAmount: Driver<Bool>
        
    }
    func transform(input: Input) -> Output {
        let isValidAmount = input.validate
            .withLatestFrom(input.number)
            .map { [self] amount in
                return Double(amount) ?? 0 >=  self.loan.min.val && Double(amount) ?? 0 <= self.loan.max.val
            }
            .startWith(true)
            .asDriver(onErrorJustReturn: false)
        
        return Output(isValidAmount: isValidAmount)
    }
    
    
}
