//
//  ViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/07/18.
//

import UIKit
import RxCocoa
import RxSwift
import SocketIO

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: LoginView = .init()
    
    let disposeBag: DisposeBag = .init()
    var socket: SocketIOClient!
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewEvent()
    }
    
    //MARK: - PageEvent
    func requestNextPage(){
        let tabPage = TabBarController()
        tabPage.modalPresentationStyle = .fullScreen
        self.present(tabPage, animated: true, completion: nil)
    }
    
    func viewEvent() {
        self.pageView.loginBtnClickEvent
            .subscribe(onNext: {
                self.requestNextPage()
            }).disposed(by: self.disposeBag)
        
        self.pageView.loginFailEvent
            .subscribe(onNext: {
                self.makeFailAlert()
            }).disposed(by: disposeBag)
    }
    
    //MARK: - Alert
    func makeFailAlert() {
        let alert = UIAlertController(title: "로그인 실패", message: "이메일 혹은 비밀번호를 확인해주세요", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - 아무 곳이나 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){ self.view.endEditing(true)
    }
}
