//
//  LoadingView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit

class LoadingView: UIView {
    
    //MARK: - Properties
    private let logoImageView: UIImageView = .init()
    
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
        self.backgroundColor = .init(red: 000/255, green: 153/255, blue: 255/255, alpha: 1) //스카이 블루 느낌 컬러
        
        self.logoImageView.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(340)
                $0.width.equalTo(self.logoImageView.snp.height).multipliedBy(1.968)
                $0.height.equalTo(90)
            }
            $0.image = UIImage(named: "mainLogoImage")
        }
    }
}
