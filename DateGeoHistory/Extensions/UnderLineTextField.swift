//
//  UnderLineTextField.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/18.
//

import UIKit
import SnapKit

class UnderLineTextField: UITextField {
    
    //placeholder 컬러값
    lazy var placeholderColor: UIColor = self.tintColor
    lazy var placeholderString: String = ""
    
    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .systemGray3
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //underline 추가 및 레이아웃 설정
        addSubview(underLineView)
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
