//
//  MapViewController.swift
//  bubble
//
//  Created by Sawyer Blatz on 2/10/18.
//  Copyright © 2018 CS 408. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var createBubbleView: CreateBubbleView!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        setupBubbleView()
        // Retrieve posts around me with backend function!
    }

    func setupBubbleView() {
        createBubbleView.postButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControlEvents#>)
    }

    // Set up the map view and grab the current location of the user
    func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()

            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController(title: "Enable Location Services", message: "Without location services, bubble cannot function, as it is a location-based network. Please enable location services for bubble under: Settings>Privacy>Location Serivces>bubble", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: {})

            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                let userLocation = locationManager.location!.coordinate
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 1000, 1000)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }

    @IBAction func newBubbleButtonPressed(_ sender: Any) {
        // TODO: present this with a better animation like coming up from the bottom of the screen
        UIView.animate(withDuration: 1.0) {
            self.createBubbleView.alpha = 1.0
        }
    }

    // MARK - Bubble Posting

    func postBubble() {
        var bubbleData = [String: Any]()

        bubbleData["text"] = createBubbleView.textView.text
        bubbleData["user"] = "currentUser" // TODO: Use firebase to get FIRUser

        var latitude = 0.0
        var longitude = 0.0

        if let latitudeCoordinate = locationManager.location?.coordinate.latitude {
            latitude = Double(latitudeCoordinate)
        }

        if let longitudeCoordinate = locationManager.location?.coordinate.longitude {
            longitude = Double(longitudeCoordinate)
        }

        if createBubbleView.textView.text != "" {
            DataService.instance.createBubble(bubbleData: bubbleData, latitude: latitude, longitude: longitude, success: { (bubble) in
                print(bubble)
            }, failure: { (error) in
                print(error)
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: {})
            })
        } else {
            let alert = UIAlertController(title: "Cannot post empty bubble", message: "You must enter at least one character to post this bubble.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: {})
        }
    }

    func cancelPost() {
        createBubbleView.textView.text = ""
        UIView.animate(withDuration: 1.0) {
            self.createBubbleView.alpha = 1.0
        }
    }

}
