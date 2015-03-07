//
//  ViewController.swift
//  MapProjectA
//
//  Created by takashi sawada on 2015/02/26.
//  Copyright (c) 2015年 prototype. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        // MapViewを生成.
        var myMapView: MKMapView = MKMapView()
        myMapView.frame = self.view.frame
        
        // 経度、緯度.
        let myLatitude: CLLocationDegrees = 34.697974
        let myLongitude: CLLocationDegrees = 135.512248
        
        // 中心点.
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
        
        // MapViewに中心点を設定.
        myMapView.setCenterCoordinate(center, animated: true)
        
        // 縮尺.
        // 表示領域.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(center, mySpan)
        
        // MapViewにregionを追加.
        myMapView.region = myRegion
        
        // viewにMapViewを追加.
        self.view.addSubview(myMapView)
        
        // ピンを生成.
        var myPin: MKPointAnnotation = MKPointAnnotation()
        //var myPin2: MKPinAnnotationView = MKPinAnnotationView()
        
        // 座標を設定.
        myPin.coordinate = center
        
        // タイトルを設定.
        myPin.title = "HTS天神橋ビル"
        
        // サブタイトルを設定.
        myPin.subtitle = "ハイテクシステム"
        
        // MapViewにピンを追加.
        myMapView.addAnnotation(myPin)
        //myPin.animatesDrop = true
        
        let path : String = NSBundle.mainBundle().pathForResource("mapnavoskdat_iryou", ofType: "csv")!
        
        let data = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) as String
        data.enumerateLines { (line, stop) -> () in
            //println(line)
            var array = split(line,{ $0 == ","})
            //println(array[0]) // x
            //println(array[1]) // y
            //println(array[2]) // 施設名
            //println(array[7]) // TEL
            
            var doubleNum1: Double = atof(array[0])
            var doubleNum2: Double = atof(array[1])
            
            let myLatitude: CLLocationDegrees = doubleNum2
            let myLongitude: CLLocationDegrees = doubleNum1
            
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
            
            // ピンを生成.
            var myPin: MKPointAnnotation = MKPointAnnotation()
            
            // 座標を設定.
            myPin.coordinate = point
            
            // タイトルを設定.
            myPin.title = array[2]
            
            // サブタイトルを設定.
            myPin.subtitle = array[7]
            
            // MapViewにピンを追加.
            myMapView.addAnnotation(myPin)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

