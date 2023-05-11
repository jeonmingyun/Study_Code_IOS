//
//  ScannerViewController.swift
//  ex01
//
//  Created by jjglobal on 2023/04/12.
//

import UIKit
import AVFoundation
import RealmSwift

class ScannerViewController : UIViewController {
    
    @IBOutlet weak var cameraTransBtn: UIButton!
    @IBOutlet weak var readerView: ReaderView!
    @IBOutlet weak var resultLabel: PaddingLabel!
    @IBOutlet weak var qrCount: UILabel!
    
//    private let dbMngr = DBManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readerView.delegate = self
        
        initCameraTransBtn()
        replaceQrCount()
        // alert action value : alert UI 조작에 사용
//        print(UIAlertAction.propertyNames)
    }
    
    // 화면 호출시
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 스캐너 활성화
        if !self.readerView.isRunning {
            self.readerView.start()
        }
    }

    // 화면이 가려지면
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 스캐너 비활성화
        if self.readerView.isRunning {
            self.readerView.stop(isButtonTap: true)
        }
    }
    
    private func initCameraTransBtn() {
        if #available(iOS 15.0, *) {
            cameraTransBtn?.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        } else {
            cameraTransBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }
    
    @IBAction func cameraTransBtnAction(_ sender: UIButton) {
        self.readerView.changeCameraPosition()
    }
    
}

extension ScannerViewController: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {
        
        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }
            
            title = "알림"
            message = "인식성공\n\(code)"
            successAction(code: code)
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
            print("ddddddd 스캔 fail")
        case let .stop(isButtonTap):
            print("ddddddd 스캔 stop")
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                self.cameraTransBtn.isSelected = readerView.isRunning
            } else {
                self.cameraTransBtn.isSelected = readerView.isRunning
                return
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){(_) in
            // 버튼 클릭시 실행되는 코드
            self.readerView.start()
        }
        okAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    // qr 스캔 성공시
    func successAction(code: String) {
        print("ddddddd 스캔 성공 \(code)")
        resultLabel.text = code
        
        saveQrData(code)
        replaceQrCount()
    }
    
    // Realm DB에 데이터 저장
    func saveQrData(_ data: String) {
//        let qrData = QrData()
//        qrData.value = data
//
//        dbMngr.write(object: qrData)
    }
    
    // qr 스캔 횟수
    func replaceQrCount() {
//        let count = dbMngr.read(object: QrData()).count
//        qrCount.text = String(count)
    }
}

// Alert 창 구현
extension UIAlertAction {
    static var propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }
        return result
    }
}
