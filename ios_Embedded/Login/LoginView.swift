//
//  LoginView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/01.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import SocketIO

class UserInfo {
    static let shared = UserInfo()
    
    var email: String?
    var password: String?
    var name: String?
    var carName: String?
    var carRealName: String?
    var carNumber: String?
    var carImage: String?
    private init() {}
}

class LoginView: UIView {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = .init()
    private let textLabel: UILabel = .init()
    private let forgotPwdLabel: UILabel = .init()
    
    private let idTextField: UITextField = .init()
    private let passwdTextField: UITextField = .init()
    private let loginBtn: UIButton = .init()
    private let regiButton: UIButton = .init()
    
    private let testBtn: UIButton = .init()
    
    internal var loginBtnClickEvent: PublishRelay<Void> = .init()
    internal var loginFailEvent: PublishRelay<Void> = .init()
    
    let disposeBag: DisposeBag = .init()
    
    private var loginCheck: Int = 0
    
    var userModel = UserModel()
    var userInfo = UserInfo.shared


    //MARK: - LifeCycle

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    //MARK: - view
    func setAppearance() {
        
        self.backgroundColor = .init(red: 000/255, green: 153/255, blue: 255/255, alpha: 1)
        
        self.logoImageView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.height.equalTo(50)
                $0.width.equalTo(self.logoImageView.snp.height).multipliedBy(2.511)
                $0.top.equalToSuperview().offset(150)
            }
            $0.image = UIImage(named: "LoginLogoImage")
        }
        
        self.textLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
                $0.top.equalTo(self.logoImageView.snp.bottom).offset(80)
            }
            $0.text = "Login to your Account"
            $0.textAlignment = .left
        }
        
        self.idTextField.do {
            self.addSubview($0)
            $0.placeholder = "아이디"
            $0.textColor = .black
            $0.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            $0.layer.borderWidth = 1

            $0.layer.cornerRadius = 15
            $0.autocapitalizationType = .none
            $0.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.logoImageView.snp.bottom).offset(130)
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        self.passwdTextField.do {
            self.addSubview($0)
            $0.placeholder = "비밀번호"
            $0.textColor = .black
            $0.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            $0.layer.borderWidth = 1

            $0.layer.cornerRadius = 15
            $0.autocapitalizationType = .none
            $0.layer.borderColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(50)
                $0.top.equalTo(idTextField.snp.bottom).offset(15)
            }
            $0.addTarget(self, action: #selector(didEndOnExit), for: UIControl.Event.editingDidEndOnExit)
        }
        
        self.forgotPwdLabel.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-100)
                $0.height.equalTo(20)
                $0.top.equalTo(self.passwdTextField.snp.bottom).offset(25)
            }
            $0.text = "비밀번호를 잊으셨습니까?"
            $0.textAlignment = .center
            $0.textColor = .white
        }
        
        self.loginBtn.do {
            self.addSubview($0)
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
            $0.snp.makeConstraints{
                $0.top.equalTo(self.forgotPwdLabel.snp.bottom).offset(25)
                $0.height.equalTo(50)
                $0.width.equalToSuperview().offset(-100)
                $0.centerX.equalToSuperview()
            }
            $0.rx.tap.bind {
                self.didTapLoginButton(self.loginBtn)
                if self.loginCheck == 1 {
                    self.loginBtnClickEvent.accept(())
                }
            }.disposed(by: disposeBag) //메모리 해제
        }
        
        self.regiButton.do {
            self.addSubview($0)
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 15
            $0.snp.makeConstraints{
                $0.top.equalTo(self.loginBtn.snp.bottom).offset(15)
                $0.height.equalTo(50)
                $0.width.equalToSuperview().offset(-100)
                $0.centerX.equalToSuperview()
            }
        }
        
        //****** 테스트 버튼임 ******
//        self.testBtn.do {
//            self.addSubview($0)
//            $0.backgroundColor = .white
//            $0.setTitle("테스트 버튼", for: .normal)
//            $0.setTitleColor(.black, for: .normal)
//            $0.layer.cornerRadius = 15
//            $0.snp.makeConstraints {
//                $0.top.equalTo(regiButton.snp.bottom).offset(30)
//                $0.height.equalTo(40)
//                $0.width.equalToSuperview().offset(-100)
//                $0.centerX.equalToSuperview()
//            }
//            $0.rx.tap.bind {
//                self.userInfo.email = "minjun@naver.com"
//                self.userInfo.password = "1234"
//                self.userInfo.carName = "붕붕쓰"
//                self.userInfo.carNumber = "40가 1234"
//                self.userInfo.name = "최민준"
//                self.userInfo.carRealName = "맥라렌"
//                self.userInfo.carImage = "mclarenImage"
//                self.loginBtnClickEvent.accept(())
//            }.disposed(by: disposeBag) //메모리 해제
//        }
    }
    //****** 테스트 버튼임 ******
    
    //MARK: - login Method
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in userModel.users {
            if user.email == id && user.password == pwd {
                userInfo.email = user.email
                userInfo.password = user.password
                userInfo.carName = user.carName
                userInfo.carNumber = user.carNumber
                userInfo.name = user.name
                userInfo.carRealName = user.carRealName
                userInfo.carImage = user.carImage
                return true // 로그인 성공
            }
        }
        return false
    }
    
    // 다음 누르면 입력창 넘어가기, 완료 누르면 키보드 내려가기
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwdTextField.becomeFirstResponder()
        }
    }
    
    //로그인 버튼 클릭 시
    @objc func didTapLoginButton(_ sender: UIButton) {
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let email = idTextField.text, !email.isEmpty else { return }
        guard let password = passwdTextField.text, !password.isEmpty else { return }
        
        if userModel.isValidEmail(id: email){
            if let removable = self.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        }
        else {
            self.loginFailEvent.accept(())
        } // 이메일 형식 오류
        
        if userModel.isValidPassword(pwd: password){
            if let removable = self.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        }
        else{
            self.loginFailEvent.accept(())

        } // 비밀번호 형식 오류
        
        if userModel.isValidEmail(id: email) && userModel.isValidPassword(pwd: password) {
            let loginSuccess: Bool = loginCheck(id: email, pwd: password)
            if loginSuccess {
                print("로그인 성공")
                //로그인 체크 변수 변경 -> 로그인 성공 시
                self.loginCheck = 1
                if let removable = self.viewWithTag(102) {
                    removable.removeFromSuperview()
                }
            }
            else {
                self.loginFailEvent.accept(())
            }
        }
    } // end of didTapLoginButton
}
