//
//  MainView.swift
//  ios_Embedded
//
//  Created by 최민준 on 2021/08/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

//스크롤 형태를 열거형으로
enum ScrollCase {
    case able
    case unable
}

class MainView: UIView {
    //MARK: - Properties
    
    //MARK: 전체 ScrollView
    private let vscrollView: UIScrollView = .init()
    private let contentView: UIView = .init()
    private let vstackView: UIStackView = .init()
    
    //MARK: Info
    private let infoHstackView: UIStackView = .init()
    private let infoImageView: UIButton = .init()
    private let infoNameLabel: UILabel = .init()
    private let infoRightBtn: UIButton = .init()
    //벨 구분 플래그
    private var infoRightBtnFlag = 0
    
    //MARK: Main
    private let mainHstackView: UIStackView = .init()
    private let mainLabel: UILabel = .init()
    private let mainBtnImageView: UIImageView = .init()
    
    //MARK: Car Info
    private let carInfoVstackView: UIStackView = .init()
    
    private let carInfoHstackView: UIStackView = .init()
    private let carInfoLabel: UILabel = .init()
    private let carInfoBtn: UIButton = .init()
    internal let carInfoBtnEvent: PublishRelay<Void> = .init()
    
    private let carInfoHstackView2: UIStackView = .init()
    private let carImageView: UIImageView = .init()
    private let carinfoVstackView2: UIStackView = .init()
    private let carNameLabel: UILabel = .init()
    private let carRealNameLabel: UILabel = .init()
    
    //MARK: AD Image
    private let adScrollView: UIScrollView = .init()
    private let innerView: UIView = .init()
    private let adPageControl: UIPageControl = .init()
    
    private let adStackView: UIStackView = .init()
    private let adImageView1: UIImageView = .init()
    private let adImageView2: UIImageView = .init()
    private let adImageView3: UIImageView = .init()
    
    private let disposeBag: DisposeBag = .init()
    var socket = SocketIOManager.shared
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    required init() {
        super.init(frame: .zero)
        self.setAppearance()
    }
    
    //MARK: - 스크롤 셋팅 메소드
    func settingScroll(_ isScroll: ScrollCase) {
        switch isScroll {
        case .able :
            self.adScrollView.alwaysBounceHorizontal = true
        case .unable :
            self.adScrollView.alwaysBounceHorizontal = false
        }
    }
    
    //MARK: -   View Method
    private func setAppearance() {
        //MARK: - 전체 ScrollView
        self.vscrollView.do {
            self.addSubview($0)
            self.vscrollView.alwaysBounceVertical = true
            $0.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
                $0.leading.equalTo(safeAreaLayoutGuide.snp.leading)
                $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            }
        }
        // contentLayoutGuide -> ScrollView에 들어갈 Content의 전체영역이다.
        // frameLayoutGuide -> ScrollView의 Frame에 해당하는 영역
        self.contentView.do {
            vscrollView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.vscrollView.contentLayoutGuide.snp.top)
                $0.bottom.equalTo(self.vscrollView.contentLayoutGuide.snp.bottom)
                $0.leading.equalTo(self.vscrollView.contentLayoutGuide.snp.leading)
                $0.trailing.equalTo(self.vscrollView.contentLayoutGuide.snp.trailing)
                $0.width.equalTo(self.vscrollView.frameLayoutGuide.snp.width)
            }
        }
        self.vstackView.do {
            contentView.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().offset(-60)
                $0.height.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.trailing.equalToSuperview().offset(-30)
                $0.leading.equalToSuperview().offset(30)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
        }
        
        //MARK: - Info
        self.infoHstackView.do {
            vstackView.addArrangedSubview($0)
            self.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
            $0.layer.cornerRadius = 13
            $0.snp.makeConstraints {
                $0.height.equalTo(60)
                $0.centerX.equalToSuperview()
            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.infoImageView.do {
            infoHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(60)
            }
            $0.setImage(UIImage(named: "personDefault"), for: .normal)
            $0.tintColor = .black
        }
        self.infoHstackView.setCustomSpacing(10, after: infoImageView)
        
        self.infoNameLabel.do {
            infoHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
            $0.text = "\(UserInfo.shared.name ?? "")" + "님"
            $0.font = .boldSystemFont(ofSize: 17)
            $0.textColor = .black
        }
        self.infoRightBtn.do {
            infoHstackView.addArrangedSubview($0)
            $0.tintColor = .black
            $0.snp.makeConstraints {
                $0.width.equalTo(40)
            }
            $0.setImage(UIImage(systemName: "bell"), for: .normal)
            $0.rx
                .tap
                .asDriver()
                .asObservable()
                .subscribe(onNext: {
                    //벨 버튼 눌리면 Flag 판단해서 이미지 변경
                    if self.infoRightBtnFlag == 1 {
                        self.infoRightBtn.setImage(UIImage(systemName: "bell"), for: .normal)
                        self.infoRightBtnFlag = 0
                        
                    }
                    else {
                        self.infoRightBtn.setImage(UIImage(systemName: "bell.slash"), for: .normal)
                        self.infoRightBtnFlag = 1
                        
                    }
                }).disposed(by: disposeBag)
        }
        self.vstackView.setCustomSpacing(25, after: infoHstackView)
        
        //MARK: - Main
        self.mainHstackView.do {
            vstackView.addArrangedSubview($0)
            $0.backgroundColor = .init(red: 000/255, green: 153/255, blue: 255/255, alpha: 1)
            $0.layer.cornerRadius = 13
            $0.layer.shadowOpacity = 0.1
            $0.snp.makeConstraints {
                $0.height.equalTo(60)
                $0.centerX.equalToSuperview()
            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.mainLabel.do {
            mainHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
                $0.leading.equalToSuperview().offset(20)
            }
            $0.text = "상담 시작하기"
            $0.font = .boldSystemFont(ofSize: 17)
            $0.textColor = .white
        }
        self.mainBtnImageView.do {
            mainHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(60)
            }
            $0.image = UIImage(named: "arrow")
            $0.tintColor = .white
        }
        self.vstackView.setCustomSpacing(25, after: mainHstackView)
        
        //MARK: - Car Info
        self.carInfoVstackView.do {
            vstackView.addArrangedSubview($0)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 13
            $0.layer.shadowOpacity = 0.1
            $0.snp.makeConstraints {
                $0.height.equalTo(100)
                $0.centerX.equalToSuperview()
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        self.carInfoHstackView.do {
            carInfoVstackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.carInfoLabel.do {
            carInfoHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
                $0.leading.equalToSuperview().offset(20)
            }
            $0.text = "차고"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 20)
        }
        self.carInfoBtn.do {
            carInfoHstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(60)
            }
            $0.setImage(UIImage(systemName: "plus.magnifyingglass"), for: .normal)
            $0.tintColor = .black
            $0.rx
                .tap
                .asDriver()
                .asObservable()
                .subscribe(onNext:{
                    self.carInfoBtnEvent.accept(())
                }).disposed(by: disposeBag)
        }
        self.carInfoHstackView2.do {
            carInfoVstackView.addArrangedSubview($0)
            $0.axis = .horizontal
            $0.alignment = .leading
            $0.distribution = .fill
        }
        self.carImageView.do {
            carInfoHstackView2.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.height.equalTo(35)
                $0.leading.equalToSuperview().offset(20)
            }
            $0.image = UIImage(named: "car2")
        }
        carInfoHstackView2.setCustomSpacing(10, after: carImageView)
        self.carinfoVstackView2.do {
            carInfoHstackView2.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(80)
            }
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fillEqually
        }
        self.carNameLabel.do {
            carinfoVstackView2.addArrangedSubview($0)
            $0.text = "\(UserInfo.shared.carName ?? "")"
            $0.textColor = .black
            $0.font = .boldSystemFont(ofSize: 17)
        }
        self.carRealNameLabel.do {
            carinfoVstackView2.addArrangedSubview($0)
            $0.text = "\(UserInfo.shared.carRealName ?? "")"
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 13)
        }
        self.vstackView.setCustomSpacing(25, after: carInfoVstackView)
        
        //MARK: - AD Page
        self.adScrollView.do {
            $0.backgroundColor = UIColor(displayP3Red: 235/255, green: 251/255, blue: 255/255, alpha: 1)
            vstackView.addArrangedSubview($0)
            $0.layer.shadowOpacity = 0.1
            $0.layer.cornerRadius = 13
            self.settingScroll(.able)
            $0.snp.makeConstraints {
                $0.height.equalTo(473)
                $0.centerX.equalToSuperview()
            }
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            //$0.delegate = self.scrollViewDelegate
        }
        self.adPageControl.do {
            vstackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.equalTo(30)
            }
            $0.currentPage = 3
            $0.isUserInteractionEnabled = false
        }
        self.innerView.do {
            $0.backgroundColor = .black
            self.adScrollView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(self.adScrollView.contentLayoutGuide.snp.top)
                $0.bottom.equalTo(self.adScrollView.contentLayoutGuide.snp.bottom)
                $0.leading.equalTo(self.adScrollView.contentLayoutGuide.snp.leading)
                $0.trailing.equalTo(self.adScrollView.contentLayoutGuide.snp.trailing)
                //가로 스크롤을 위해서
                $0.height.equalTo(self.adScrollView.frameLayoutGuide.snp.height)
            }
        }
        self.adStackView.do {
            innerView.addSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
                $0.height.top.bottom.equalToSuperview()
                $0.centerX.equalToSuperview()
            }
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        self.adImageView1.do {
            adStackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(self.adImageView1.snp.height).multipliedBy(0.666)
                $0.height.equalToSuperview()
            }
            $0.image = UIImage(named: "AD1")
        }
        self.adImageView2.do {
            adStackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(self.adImageView2.snp.height).multipliedBy(0.666)
                $0.height.equalToSuperview()
            }
            $0.image = UIImage(named: "AD2")
        }
        self.adImageView3.do {
            adStackView.addArrangedSubview($0)
            $0.snp.makeConstraints {
                $0.width.equalTo(self.adImageView3.snp.height).multipliedBy(0.666)
                $0.height.equalToSuperview()
            }
            $0.image = UIImage(named: "AD3")
        }
    }
}
