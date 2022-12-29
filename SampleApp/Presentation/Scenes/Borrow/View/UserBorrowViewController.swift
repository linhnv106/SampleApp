//
//  UserBorrowViewController.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class UserBorrowViewController: NiblessViewController {
    var viewModel: UserBorrowViewModel
    var didSetupConstraints = false
    let disposeBag = DisposeBag()

    public init(viewModel: UserBorrowViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    let creditLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = NSLocalizedString("Draw from your credit limit", comment: "")
        return label
    }()
    
    let borrowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.lightText
        label.numberOfLines = 0
        label.text = NSLocalizedString("I want to borrow", comment: "")
        return label
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 44.0, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = NSLocalizedString("SGD", comment: "")
        return label
    }()
    let borrowTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 44.0, weight: .bold)
        label.textColor = UIColor.lightCream
        label.tintColor = UIColor.gray
        label.isUserInteractionEnabled = true
        label.keyboardType = .numberPad
        label.placeholder = NSLocalizedString("0.00", comment: "")
        return label
    }()
    
    let amountLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor.lightText
        label.numberOfLines = 0
        label.text = NSLocalizedString("I want to borrow", comment: "")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = " "
        setupViews()
        bindViewModelToViews()
    }
    private func setupViews() {
        view.backgroundColor = UIColor.backGroundColor
        view.addSubview(creditLimitLabel)
        view.addSubview(borrowLabel)
        view.addSubview(currencyLabel)
        view.addSubview(borrowTextField)
        view.addSubview(amountLimitLabel)

        view.setNeedsUpdateConstraints()
    }
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            
            creditLimitLabel.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(160.0)
                make.left.equalTo(view.snp.left).offset(Dimension.defaultMarginLeft)
            }
            borrowLabel.snp.makeConstraints { make in
                make.top.equalTo(creditLimitLabel.snp.bottom).offset(Dimension.margin40)
                make.left.equalTo(view.snp.left).offset(Dimension.defaultMarginLeft)
            }
            currencyLabel.snp.makeConstraints { make in
                make.top.equalTo(borrowLabel.snp.bottom).offset(Dimension.defaultMarginTop)
                make.left.equalTo(view.snp.left).offset(Dimension.defaultMarginLeft)
            }
            borrowTextField.snp.makeConstraints { make in
                make.top.equalTo(borrowLabel.snp.bottom).offset(Dimension.defaultMarginTop)
                make.left.equalTo(currencyLabel.snp.right).offset(Dimension.margin4)
                make.right.equalTo(view.snp.right).offset(Dimension.defaultMarginRight)
            }
            amountLimitLabel.snp.makeConstraints { make in
                make.top.equalTo(currencyLabel.snp.bottom).offset(Dimension.defaultMarginTop)
                make.left.equalTo(view.snp.left).offset(Dimension.defaultMarginLeft)
                make.right.equalTo(view.snp.right).offset(Dimension.defaultMarginRight)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
        
    }
    func bindViewModelToViews() {
        amountLimitLabel.text = "Enter an amount between \(viewModel.loan.min.currencyCode) \(viewModel.loan.min.val) and \(viewModel.loan.max.currencyCode) \(viewModel.loan.max.val)"
        
        let input = UserBorrowViewModel.Input(number: borrowTextField.rx.text.orEmpty.asObservable(), validate: borrowTextField.rx.text.changed.asObservable())
        
        let output = viewModel.transform(input: input)
        output.isValidAmount.drive() { isValid in
            self.amountLimitLabel.textColor = isValid ? UIColor.lightText: UIColor.orange
            
        }.disposed(by: disposeBag)
    }
}
