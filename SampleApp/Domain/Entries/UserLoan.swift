//
//  UserLoan.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
public struct UserLoan: Encodable {
    var availableLOC: Currency
    var offeredInterestRate: Float
    var offeredEIR: Float
    var min: Currency
    var max: Currency
    
}
public struct Currency : Encodable {
    var currencyCode: String
    var val: Double
}
