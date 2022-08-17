//
//  AddScheduleController.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/14.
//

import SnapKit
import UIKit

class AddScheduleController: UIViewController {
    
    private var date: Date?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(date!.getStrDate(format: "M월 dd일"))의 여정"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        
        return label
    }()
    
    private lazy var titleTextField: UITextField = {
        let label = UITextField()
        label.placeholder = "이번 여정의 제목"
        label.borderStyle = .none
        
        return label
    }()
    
    private lazy var memoTextView: UITextView = {
        let view = UITextView()
        view.text = "안녕하세요. 이준호입니다. 가나라라마바사매불쇼이준석국민의힘보수정권 윤석열"
        view.font = .systemFont(ofSize: 14)
        
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .gray()
        button.configuration?.title = "닫기"
        button.tintColor = .red
        button.addTarget(self, action: #selector(dismissView), for: .touchDown)
        
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.title = "저장하기"
        button.isEnabled = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        titleTextField.addBottomLineBorder(width: 1.0)
        super.viewDidAppear(animated)
    }
    
    init(strDate: String){
        super.init(nibName: nil, bundle: nil)
        self.date = strDate.getDate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true)
    }
}

private extension AddScheduleController {
    
    func setupLayout(){
        [ titleLabel, titleTextField, memoTextView, closeButton ,saveButton
          ].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        titleTextField.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        memoTextView.snp.makeConstraints{
            $0.top.equalTo(titleTextField.snp.bottom).offset(30)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.height.equalTo(150)
        }
        
        closeButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalTo(view.safeAreaInsets).inset(65)
            $0.width.equalTo((view.bounds.width / 2) - 35)
            $0.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(closeButton.snp.bottom)
            $0.width.equalTo((view.bounds.width / 2) - 35)
            $0.height.equalTo(50)
        }
    }
}
