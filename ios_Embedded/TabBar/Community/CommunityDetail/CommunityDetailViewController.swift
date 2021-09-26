//
//  CommunityDetailViewController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/09/01.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    
    //MARK: - Properties
    private let pageView: CommunityDetailView = .init()
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = pageView.self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestCommunityDetail(searchResults: [Result], index: Int ) {
        self.pageView.displayCellModel(searchResults, index: index)
    }
}
