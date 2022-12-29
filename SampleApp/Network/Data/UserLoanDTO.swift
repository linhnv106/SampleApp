//
//  UserLoanDTO.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
public struct UserLoanDTO: Decodable {
    var availableLOC: CurrencyDTO
    var offeredInterestRate: Float
    var offeredEIR: Float
    var min: CurrencyDTO
    var max: CurrencyDTO
    
    func toModel() -> UserLoan {
        return UserLoan(
            availableLOC: self.availableLOC.toModel(),
            offeredInterestRate: self.offeredInterestRate,
            offeredEIR: self.offeredEIR,
            min: self.min.toModel(),
            max: self.max.toModel()
        )
    }
    
}
public struct CurrencyDTO : Decodable {
    var currencyCode: String
    var val: Double
    func toModel() -> Currency {
        return Currency(currencyCode: self.currencyCode, val: self.val)
    }
}
