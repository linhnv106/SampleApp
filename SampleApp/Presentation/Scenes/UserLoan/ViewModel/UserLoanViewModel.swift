//
//  UserLoanViewModel.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import RxFlow
import RxSwift
import RxRelay
import RxCocoa
final class UserLoanViewModel: ViewModelType, Stepper {    
    let steps = PublishRelay<Step>()
    var userLoan: UserLoan? = nil
    struct Input {        
    }
    struct Output {
        let userLoan: Driver<UserLoanDTO?>
    }
    private let useCase: UserLoanUseCase
    
    init(useCase: UserLoanUseCase) {
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        let userLoanDTO = useCase.fetchUserLoan().asDriver(onErrorJustReturn: nil)
        return Output(userLoan: userLoanDTO)
    }
    func actionBorrow() {
        if let loan = userLoan {
            self.steps.accept(AppStep.borrow(loan: loan ))
        }
    }
    
}
