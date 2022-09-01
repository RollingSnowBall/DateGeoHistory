//
//  ScheduleCell.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/27.
//

import UIKit
import SnapKit

protocol OpenRegisteredScheduleDelegate : AnyObject {
    func openSchedule(schedule: Schedule)
}

class ScheduleCell: UICollectionViewCell {
    
    private var schedule: Schedule?
    weak var delegate: OpenRegisteredScheduleDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private lazy var memoTextView: UILabel = {
        let memo = UILabel()
        memo.font = .systemFont(ofSize: 18, weight: .light)
        memo.textColor = .secondaryLabel
        memo.numberOfLines = 3
        
        return memo
    }()
    
    private lazy var detailBtn: UIButton = {
        let button = UIButton()
        button.setTitle(" 자세히 보기 ", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(editSchedule), for: .touchDown)
        
        return button
    }()
    
    @objc func editSchedule(){
        self.delegate?.openSchedule(schedule: schedule!)
    }
    
    func initCell(schedule: Schedule){
        setup()
        
        self.schedule = schedule
        titleLabel.text = schedule.title
        memoTextView.text = (schedule.memo != "") ? schedule.memo : ""
        backgroundColor = .systemBackground
    }
    
}

private extension ScheduleCell {
    
    func setup(){
        [ titleLabel, memoTextView, detailBtn ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        
        
        memoTextView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        detailBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.cornerRadius = 15
    }
}
