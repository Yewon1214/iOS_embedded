//
//  LoadingViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit

class LoadingViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: LoadingView = .init()
    
    //MARK: - LifeCycle 
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        //메인스레드에서 현재시간으로부터 3.3초 뒤 화면 전환 이벤트
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.3, execute:{
        let loginPage = LoginViewController()
            loginPage.modalPresentationStyle = .fullScreen
            self.present(loginPage, animated: true, completion: nil)
        })
    }
}
