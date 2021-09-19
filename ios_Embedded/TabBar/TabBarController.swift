//
//  TabBarController.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/12.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - LifeCycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
        
        let vc1 = MainViewController()
        let vc2 = CommunityViewController()
        let vc3 = MapViewController()

        vc2.socketManager("community_init1", "자동차 사고")
        vc2.socketManager("community_init2", "범퍼")
        vc2.socketManager("community_init3", "와이퍼")
        vc2.socketManager("community_init4", "미러")
        
        vc1.title = "메인"
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.title = "커뮤니티"
        vc2.tabBarItem.image = UIImage(systemName: "message")
        vc3.title = "지도"
        vc3.tabBarItem.image = UIImage(systemName: "location")
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
        
    }
}
