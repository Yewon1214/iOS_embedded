//
//  MapView.swift
//  ios_Embedded
//
//  Created by 허예원 on 2021/09/14.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps
import CoreLocation
import GooglePlaces

class MapView: UIView, CLLocationManagerDelegate, GMSMapViewDelegate{

    //MARK: - Properties
    private var mapView: GMSMapView = .init()
    private var locationManager: CLLocationManager = .init()
    private let searchButton: UIButton = .init()
    private let marker = GMSMarker()
    
    internal var searchBtnClickEvent: PublishRelay<Void> = .init()
    
    let disposeBag: DisposeBag = .init()
    
    //MARK: - LifeCycle
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init() {
        super.init(frame: .zero)
        self.displaylocation()
        self.setAppearance()
    }
    
    //MARK: - view
    func setAppearance() {

        self.mapView.do{
            self.addSubview($0)
            $0.snp.makeConstraints{
                $0.width.equalToSuperview()
                $0.height.equalToSuperview()
                $0.top.equalToSuperview()
                $0.bottom.equalToSuperview()
            }
            $0.settings.myLocationButton = true
            $0.isMyLocationEnabled = true
            $0.settings.allowScrollGesturesDuringRotateOrZoom = true
        }
        
        self.searchButton.do{
            self.addSubview($0)
            $0.backgroundColor = .systemBlue.withAlphaComponent(0.7)
            $0.setTitle("검색하기", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 20
            $0.snp.makeConstraints{
                $0.centerX.equalToSuperview()
                $0.height.equalTo(40)
                $0.width.equalTo(200)
                $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-100)
            }
            $0.rx.tap.bind{
                self.searchBtnClickEvent.accept(())
            }.disposed(by: disposeBag)
        }
    }
    
    func displaylocation(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
            move(at: locationManager.location?.coordinate)
        }
    }
    
    
    func move(at coordinate: CLLocationCoordinate2D?){
        guard let coordinate = coordinate else {
            return
        }
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: self.frame, camera: camera)

    }
    
    func movetoSearch(at coordinate: CLLocationCoordinate2D?, place: GMSPlace){
        guard let coordinate = coordinate else {
            return
        }
        mapView.clear()
    
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let searchcoor = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
        let searchCamera = GMSCameraUpdate.setTarget(searchcoor)
        
        mapView.animate(with: searchCamera)
        
        let searchMarker = GMSMarker()
        searchMarker.position = searchcoor
        searchMarker.title = place.name
        searchMarker.snippet = place.formattedAddress
        searchMarker.map = mapView
        mapView.selectedMarker = searchMarker
    }
    
}

