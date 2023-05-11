//
//  ScanHistoryController.swift
//  ex01
//
//  Created by jjglobal on 2023/04/13.
//

import UIKit
import RealmSwift

class ScanHistoryController : UIViewController {
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historyDateButton: UIButton!
    
//    let dbMngr = DBManager.sharedInstance
    let dbHelper = DBHelper.shared
    
    var contentArrAll: Array<QrData>! // history 전체
    var contentArr: Array<QrData>! // 리스트 아이템
    var searchDate: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentArrAll = getQrHistory()
        self.contentArr = self.contentArrAll
        
        initTableView()
    }
    
    @IBAction func historyDateAction(_ sender: UIButton) {
        if #available(iOS 14, *) {
            openDatePickerPopup()
        }
    }
    
    @available(iOS 14, *)
    private func openDatePickerPopup() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.locale = NSLocale(localeIdentifier: "ko_KR") as Locale // datePicker의 default 값이 영어이기 때문에 한글로 바꿔줘야한다. 그래서 이 방식으로 변경할 수 있다.
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        
        let onAction = UIAlertAction(
            title: "선택완료",
            style:UIAlertAction.Style.default)
        {(_) in
            // 버튼 클릭시 실행되는 코드
            self.searchDate(date: self.dateFormatter(date: datePicker.date))
        }
        
        dateChooserAlert.addAction(onAction)
        //dialog.setValue(contentVC, forKey: "contentViewController") // private api
        
        let height : NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 400)
        dateChooserAlert.view.addConstraint(height)
        
        present(dateChooserAlert, animated: true, completion: nil)
    }

    private func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    private func searchDate(date: String) {
        print("\(date)")
        self.searchDate = date
        self.historyDateButton.setTitle(date, for: .normal)
        refreshHistoryList(date: date)
    }
    
    private func refreshHistoryList(date: String) {
        self.contentArr = getQrHistoryWithDate(date: date)
        
        historyTableView.reloadData()
    }
    
    private func initTableView() {
        // 쎌 리소스 파일 가져오기
        let myTableViewCellNib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        //        let myTableViewCellNib = UINib(nibName: String(describing: HistoryTableViewCell.self), bundle: nil)
        
        // 쏄에 리소스 등록, 셀 아이디 지정
        self.historyTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myCellId")
        
        // 셀 높이 자동 설정 (wrap content)
        self.historyTableView.rowHeight = UITableView.automaticDimension
        // 예상 height 지정 (없어도 됌)
        //        self.historyTableView.estimatedRowHeight = 120
        
        // 아주 중요,  extension 연결 (self)
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
    }
    
    // Realm DB에서 qr데이터 가져옴
    private func getQrHistory() -> Array<QrData> {
//        return Array(dbMngr.read(object: QrData()))
        return Array()
    }
    
    private func getQrHistoryWithDate(date: String) -> Array<QrData> {
//        return Array(dbMngr.fetch(object: QrData(), date: date))
        return Array()
    }
}

extension ScanHistoryController : UITableViewDelegate {
    
}

extension ScanHistoryController : UITableViewDataSource {
    // 테이블 뷰 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    
    // 각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell 재사용
        let cell = self.historyTableView.dequeueReusableCell(withIdentifier: "myCellId", for: indexPath) as! HistoryTableViewCell
        
        // cell 내부 데이터 변경
        cell.qrData.text = contentArr[indexPath.row].value
//        cell.regDate.text = contentArr[indexPath.row].date
        
        return cell
    }
    
    func convertDateToString(date: Date) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter3.string(from: date)
    }
    
    
}

