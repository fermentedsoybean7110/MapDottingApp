//
//  ContentViewModel.swift
//  MapDottingApp
//

import Foundation
import CoreLocation
import MapKit

class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    // 初回起動時フラグ
    var isFirstLaunch: Bool = true
    
    // 表示地域の指定（default値）
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center : CLLocationCoordinate2D(latitude: 35.658584, longitude: 139.7454316),
        latitudinalMeters: 1000.0,
        longitudinalMeters: 1000.0
    )
    
    // 描画するPoIリスト
    @Published var spotList: [Spot] = []
    
    // 初期化
    override init() {
        super.init()
        // LocationManagerの生成
        locationManager = CLLocationManager()
        // 精度を指定
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        // ViewModelをデリゲートとしてセット
        locationManager?.delegate = self
        
        // 位置情報取得許可を求めるダイアログ表示
        locationManager?.requestWhenInUseAuthorization()
        
        // 利用許可が出ている場合
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        } else {
            print("利用許可が出ていないため、位置情報が取得できません")
        }
    }
    
    // 位置情報取得失敗時
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
    }
    
    // 利用許可状況変化時
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.requestLocation()
            
        }
    }
    
    // 位置情報変化時
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let initLocation = locations.first else { return }
        guard let newLocation = locations.last else { return }
        // 起動時に自分の位置を取得
        if isFirstLaunch {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: initLocation.coordinate.latitude, longitude: initLocation.coordinate.longitude),
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0)
            isFirstLaunch = false
        }
        // 取得した位置情報を追加
        spotList.append(Spot(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude))
    }
    
}
