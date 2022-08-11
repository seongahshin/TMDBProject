//
//  MapViewController.swift
//  TMDBProject
//
//  Created by 신승아 on 2022/08/11.
//

import UIKit

// L1. import
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // L2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // L3. 프로토콜 연결
        locationManager.delegate = self
        
        // 지도 중심 설정
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        setRegionAnnotation(center: center)
    }
    
    func setRegionAnnotation(center: CLLocationCoordinate2D) {
        
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // annotation 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "청년취업사관학교"
        
        // 지도에 핀 추가
        mapView.addAnnotation(annotation)
    }

    

}

// L4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
}
