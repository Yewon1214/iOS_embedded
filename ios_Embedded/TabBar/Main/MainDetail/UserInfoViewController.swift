//
//  UserInfoViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/04.
//

import UIKit

class UserInfoViewController: UIViewController {
    //MARK: - Properties
    private let pageView: UserInfoView = .init()
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
