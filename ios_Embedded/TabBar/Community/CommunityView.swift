//
//  CommunityView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/18.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CommunityView: UIView {
    
    //MARK: - Properties
    internal let communityListView: UITableView = .init(frame: .zero)
    private let CommunityListViewDelegate: CommunityListViewDelegate = .init()
    internal var communityCellTapEvent: PublishRelay<Int> {
        get {
            self.CommunityListViewDelegate.cellTapEvent
        }
    }
    
    //MARK: - LifeCycle 
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    func setAppearance() {
        self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
        
        self.communityListView.do {
            self.addSubview($0)
            self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
            $0.snp.makeConstraints {
                $0.width.top.equalToSuperview()
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            }
            $0.delegate = self.CommunityListViewDelegate
            $0.dataSource = self.CommunityListViewDelegate
            $0.register(CommunityListCell.self, forCellReuseIdentifier: "CommunityListCell")
        }
    }
    
    func displayTableView(cellModels: [CommnuityListCellModel]) {
        self.CommunityListViewDelegate.cellModels = {
            return cellModels
        }()
        self.communityListView.reloadData()
    }
}

//MARK: - TableView Delegate
fileprivate class CommunityListViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var cellModels: [CommnuityListCellModel]?
    let cellTapEvent: PublishRelay<Int> = .init()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "CommunityListCell", for: indexPath).do {
            guard let cellModel = self.cellModels?[indexPath.row] else { return }
            ($0 as? CommunityListCell)?.displayCellModel(cellModel)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return cellTapEvent.accept(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}



