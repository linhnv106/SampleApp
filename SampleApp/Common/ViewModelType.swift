//
//  ViewModelType.swift
//  SampleApp
//
//  Created by Nguyen Linh on 22/12/2022.
//

import Foundation
protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
