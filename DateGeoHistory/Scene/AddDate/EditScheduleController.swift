//
//  EditScheduleController.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/31.
//

import SnapKit
import RealmSwift
import UIKit

class EditScheduleController: UIViewController {
    
    private var date: Date?
    private var schedule: Schedule?
    weak var delegate: commonViewControllerDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(date!.getStrDate(format: "M월 d일"))의 여정"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private lazy var titleTextField: UnderLineTextField = {
        let label = UnderLineTextField()
        label.placeholder = "이번 여정의 제목"
        label.borderStyle = .none
        label.font = .systemFont(ofSize: 18)
        
        label.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        
        return label
    }()
    
    let textViewPlaceHolder = "이번 여정의 상세설명"
    private lazy var memoTextView: UITextView = {
        let view = UITextView()
        
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5
        view.textContainer.lineFragmentPadding = 5
        
        view.font = .systemFont(ofSize: 16)
        view.text = textViewPlaceHolder
        
        view.delegate = self
        
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
        
        button.addTarget(self, action: #selector(saveTrip), for: .touchDown)
        
        return button
    }()
    
    private lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    init(strDate: String, schedule: Schedule){
        super.init(nibName: nil, bundle: nil)
        self.date = strDate.getDate()
        self.schedule = schedule
        self.titleTextField.text = schedule.title
        self.memoTextView.text = schedule.memo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        guard let homeview = self.presentingViewController as? HomeViewController else { return }
        
        homeview.refreshView()
        self.dismiss(animated: true)
    }
    
    @objc func textDidChanged(){
        if (titleTextField.text?.isEmpty ?? false) {
            saveButton.isEnabled = false
        }
        else
        {
            saveButton.isEnabled = true
        }
    }
    
    @objc func saveTrip(){
        let realm = try! Realm()
        
        let title = titleTextField.text!
        let memo = memoTextView.text!
        
        try! realm.write {
            self.schedule!.title = title
            self.schedule!.memo = memo
        }
        
        dismissView()
        self.delegate?.dismiss(date: date!)
    }
}

private extension EditScheduleController {
    
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
            $0.height.equalTo(180)
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
            $0.height.equalTo(closeButton.snp.height)
        }
    }
}

extension EditScheduleController: UITextViewDelegate, UITableViewDataSource {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoTextView.text == textViewPlaceHolder {
            memoTextView.text = nil
            memoTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            memoTextView.text = textViewPlaceHolder
            memoTextView.textColor = .lightGray
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "11"
        
        return cell
    }
}
