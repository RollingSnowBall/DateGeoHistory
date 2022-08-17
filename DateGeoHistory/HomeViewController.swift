//
//  CalendarViewController.swift
//  DateGeoHistory
//
//  Created by JUNO on 2022/08/10.
//

import UIKit
import SnapKit
import FSCalendar

class HomeViewController: UIViewController {
    
    private var calendarHeight: CGFloat = 0
    private var detailHeight: CGFloat = 0
    
    private var lastContentOffset: CGFloat = 0
    
    private var selectedDate: String {
        get {
            return calendar.selectedDate?.getStrDate() ?? calendar.today!.getStrDate()
        }
    }
    
    private lazy var calendarTitle: UILabel = {
        let label = UILabel()
        label.text = "방문 스케줄"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        
        return label
    }()
    
    private lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        
        // 주말 색깔 : TEXT COLOR
        view.appearance.titleWeekendColor = .red
        // 평일 색깔 : TEXT COLOR
        view.appearance.titleDefaultColor = .label
        
        // 다음 달 색깔 표기 여부
        view.placeholderType = .none
        // 전 달 표기 색깔
        view.appearance.headerMinimumDissolvedAlpha = 0
        
        // 년 월 표기 양식 변경
        view.appearance.headerDateFormat = "YYYY년 MM월"
        // 년 월 TEXT COLOR
        view.appearance.headerTitleColor = .label
        // 년 월 TEXT 사이즈
        view.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18)
        // 년 HEADER 위치 조정
        view.appearance.headerTitleOffset = CGPoint(x: 0, y: -8)
        
        // 달력 월-일 폰트 조정
        view.appearance.weekdayFont = UIFont.systemFont(ofSize: 15)
        // 날짜 폰트
        view.appearance.titleFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    private lazy var resizeButton: UIButton = {
        let button = UIButton()
        let chevronImage = UIImage(systemName: "chevron.up")
        
        button.setImage(chevronImage, for: .normal)
        button.addTarget(self , action: #selector(resize), for: .touchDown)
        
        return button
    }()
    
    private lazy var todayButton: UIButton = {
        let button = UIButton()

        button.configuration = .tinted()
        button.configuration?.title = " 오늘 "
        
        button.addTarget(self, action: #selector(setToday), for: .touchDown)

        return button
    }()
    
    private lazy var addEventButton: UIButton = {
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.title = "새로운 일정"
        
        button.addTarget(self, action: #selector(addSchedule), for: .touchDown)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    @objc func resize(){
        if calendar.scope == .month {
            calendar.setScope(.week, animated: true)
            resizeButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            calendar.setScope(.month, animated: true)
            resizeButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
    }
    
    @objc func setToday(){
        calendar.select(calendar.today)
    }
    
    @objc func addSchedule(){
        self.present(AddScheduleController(strDate: selectedDate).self, animated: true)
    }
}

private extension HomeViewController {
    
    func setupLayout(){
        
        calendarHeight = ((view.bounds.height) / 100) * 50
        
        [ calendarTitle, todayButton, calendar, addEventButton
          ].forEach {
            view.addSubview($0)
        }
        //scheduleTableView
        calendarTitle.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(25)
        }
        
        todayButton.snp.makeConstraints{
            $0.bottom.equalTo(calendarTitle.snp.bottom)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        calendar.snp.makeConstraints{
            $0.top.equalTo(calendarTitle.snp.bottom).offset(20)
            $0.width.equalTo(view.bounds.width - 20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(calendarHeight)
        }
    
        addEventButton.snp.makeConstraints{
            //$0.centerY.equalTo(resizeButton.snp.centerY)
            $0.top.equalTo(calendar.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(25)
        }
    }
}

extension HomeViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        // monthPosition.rawValue
        // 0 이면 저번 달
        // 1 이면 이번 달
        // 2 이면 다음 달
        if monthPosition.rawValue == 0 {
            calendar.setCurrentPage(date, animated: true)
        }
        else if monthPosition.rawValue == 2 {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints {
            $0.height.equalTo(bounds.height)
        }
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
}
