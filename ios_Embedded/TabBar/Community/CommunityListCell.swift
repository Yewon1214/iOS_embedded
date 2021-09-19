//
//  CommunityListCell.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/28.
//

import UIKit
import SnapKit
import RxSwift

struct CommnuityListCellModel {
    var title: String?
    var date: String?
    var question: String?
    var answer: [String]?
}

class CommunityListCell: UITableViewCell {
    //MARK: - Properties
    private let view: UIView = .init()
    private let vstackView: UIStackView = .init()
    private let vstackView2: UIStackView = .init()

    private let dotImage: UIImageView = .init()
    
    private let titleLabel: UILabel = .init()
    private let answerLabel: UILabel = .init()
    
    private let hstackView: UIStackView = .init()
    private let answerNumLabel: UILabel = .init()
    private let dateLabel: UILabel = .init()
    
    // Object LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setAppearance()
    }
    
    //MARK: - View
    private func setAppearance() {
        
        self.dotImage.do {
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalTo(10)
                $0.leading.equalToSuperview().offset(10)
                $0.top.equalToSuperview().offset(17)
            }
            $0.image = UIImage(named: "dot")
        }
        
        self.vstackView.do {
            self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
            self.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.leading.equalTo(self.dotImage.snp.trailing).offset(5)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        
        self.vstackView2.do {
            self.vstackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        self.titleLabel.do {
            vstackView2.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(15)
            }
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14)
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        }
        
        self.answerLabel.do {
            vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(10)
            }
            $0.textColor = .gray
            $0.numberOfLines = 3
            $0.font = .systemFont(ofSize: 13)
        }
        
        self.hstackView.do {
            vstackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.answerNumLabel.do {
            self.hstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(50)
            }
            $0.numberOfLines = 0
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 11)
        }
        self.dateLabel.do {
            self.hstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(50)
            }
            $0.numberOfLines = 0
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 11)
        }
    }
    
    func displayCellModel(_ model: CommnuityListCellModel) {
        self.titleLabel.text = model.title
        self.answerLabel.text = model.question
        self.answerNumLabel.text = "댓글 수: \(model.answer?.count ?? 0)"
        
        let date = model.date?.components(separatedBy: "\n")
        self.dateLabel.text = "작성일: \(date![1])"
    }
}
