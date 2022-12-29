//
//  UserLoanViewController.swift
//  SampleApp
//
//  Created by Nguyen Linh on 23/12/2022.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
class UserLoanViewController: UIViewController {
    
    var didSetupConstraints = false
    
    var viewModel: UserLoanViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: UserLoanViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let limitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = NSLocalizedString("Available limit", comment: "")
        return label
    }()
    let availableValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 44.0, weight: .bold)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = NSLocalizedString("S$10,000", comment: "")
        return label
    }()
    
    let interestValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        label.textColor = UIColor.lightText
        label.numberOfLines = 0
        label.text = NSLocalizedString("S$10,000", comment: "")
        return label
    }()
    
    let borrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.circleButtonColor
        button.setTitle("Borrow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.addTarget(self, action: #selector(actionBorrow), for: .touchUpInside)
        
        return button
    }()
    
    let historyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.circleButtonColor
        button.setTitle("History", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        return button
    }()
    let manageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.backgroundColor = UIColor.circleButtonColor
        button.setTitle("Manage", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }()
    
    let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
        
    }()
    let emptyLoanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("You haven't taken any loan yet!", comment: "")
        return label
    }()
    
    let emptyLoanView: UIView = {
        let view =  UIView()
        view.backgroundColor = UIColor.emptyViewColor
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = NSLocalizedString("User Loan Sample", comment: "")
        
    }
    private func setupViews() {
        
        view.backgroundColor = UIColor.backGroundColor
        
        view.addSubview(limitLabel)
        view.addSubview(availableValueLabel)
        view.addSubview(interestValueLabel)
        view.addSubview(menuStackView)
        menuStackView.addArrangedSubview(borrowButton)
        menuStackView.addArrangedSubview(historyButton)
        menuStackView.addArrangedSubview(manageButton)
        
        emptyLoanView.addSubview(emptyLoanLabel)
        
        view.addSubview(emptyLoanView)
        view.setNeedsUpdateConstraints()
    }
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            limitLabel.snp.makeConstraints { make in
                make.top.equalTo(view.snp.top).offset(160.0)
                make.left.equalTo(view.snp.left).offset(Dimension.defaultMarginLeft)
            }
            availableValueLabel.snp.makeConstraints { make in
                make.left.equalTo(limitLabel.snp.left)
                make.top.equalTo(limitLabel.snp.bottom).offset(Dimension.defaultMarginTop)
                
            }
            interestValueLabel.snp.makeConstraints { make in
                make.left.equalTo(limitLabel.snp.left)
                make.top.equalTo(availableValueLabel.snp.bottom).offset(Dimension.defaultMarginTop)
                
            }
            
            borrowButton.snp.makeConstraints { make in
                make.width.equalTo(Dimension.defaultCircleButtonHeight)
                make.height.equalTo(Dimension.defaultCircleButtonHeight)
            }
            historyButton.snp.makeConstraints { make in
                make.width.equalTo(Dimension.defaultCircleButtonHeight)
                make.height.equalTo(Dimension.defaultCircleButtonHeight)
            }
            manageButton.snp.makeConstraints { make in
                make.width.equalTo(Dimension.defaultCircleButtonHeight)
                make.height.equalTo(Dimension.defaultCircleButtonHeight)
            }
            
            
            menuStackView.snp.makeConstraints { make in
                make.left.equalTo(view.snp.left).offset(Dimension.margin48)
                make.right.equalTo(view.snp.right).offset(Dimension.margin48 * -1)
                make.top.equalTo(interestValueLabel.snp.bottom).offset(Dimension.margin40)
            }
            borrowButton.layer.cornerRadius = Dimension.defaultCircleButtonHeight * 0.5
            borrowButton.clipsToBounds = true
            
            historyButton.layer.cornerRadius = Dimension.defaultCircleButtonHeight * 0.5
            historyButton.clipsToBounds = true
            manageButton.layer.cornerRadius = Dimension.defaultCircleButtonHeight * 0.5
            manageButton.clipsToBounds = true
            
            emptyLoanView.snp.makeConstraints { make in
                make.left.equalTo(menuStackView.snp.left)
                make.right.equalTo(menuStackView.snp.right)
                make.top.equalTo(menuStackView.snp.bottom).offset(Dimension.margin40)
                make.height.equalTo(200.0)
                
            }
            emptyLoanLabel.snp.makeConstraints { make in
                make.center.equalTo(emptyLoanView.snp.center)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    @objc func actionBorrow(sender: UIButton!) {
        self.viewModel.actionBorrow()
        
    }
    private func bindViewModel() {
        let output = viewModel.transform(input: UserLoanViewModel.Input())
        output.userLoan.drive() { data in
            self.availableValueLabel.text = "\(data?.availableLOC.currencyCode ?? "$") \(data?.availableLOC.val ?? 0.0)"
            
            self.interestValueLabel.text = "Interest @ \(data?.offeredInterestRate ?? 0.0)% p.a ( \(data?.offeredEIR ?? 0.0)% p.a EIR )"
            self.viewModel.userLoan = data?.toModel()
        }.disposed(by: disposeBag)
    }
}
