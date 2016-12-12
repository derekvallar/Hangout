//
//  FirstViewController.swift
//  Hangout
//
//  Created by Derek Vitaliano Vallar on 10/13/16.
//  Copyright © 2016 Derek Vallar. All rights reserved.
//

import GoogleMaps
import GooglePlaces
import UIKit

protocol RecommendationViewControllerDelegate: class {
    func didAddPlace(place: GMSPlace)
}

class RecommendationViewController: UIViewController {

    weak var delegate: RecommendationViewControllerDelegate?

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: HangoutSearchController?
    let locationManager = CLLocationManager()

    var isAddingToGroup = false
    var addButtonShown = false
    var selectedPlace: GMSPlace?

    let DEFAULT_ZOOM: Float = 16.0
    let MIN_ZOOM: Float = 14.0

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var addToGroupButton: UIButton!

    @IBAction func addToGroupAction(_ sender: Any) {
        if isAddingToGroup {
            delegate?.didAddPlace(place: selectedPlace!)
            performSegue(withIdentifier: "unwindToGroupView", sender: self)
        }
    }

    override func viewDidLoad() {

        searchBarView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        searchBarView.layer.shadowRadius = 4
        searchBarView.layer.shadowOpacity = 0.25

        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        configureSearchController()
        definesPresentationContext = true

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        mapView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        var searchbarFrame = searchController?.searchBar.frame
        searchbarFrame?.size.width = searchBarView.frame.size.width
        searchController?.searchBar.frame = searchbarFrame!
    }

    func configureSearchController() {

        searchController = HangoutSearchController(searchResultsController: resultsViewController, searchBarFrame: CGRect.init(x: 0.0, y: 0.0, width: searchBar.frame.size.width - searchBar.frame.size.height, height: searchBar.frame.size.height), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.orange, searchBarTintColor: UIColor.white)

        searchController?.searchResultsUpdater = resultsViewController
        searchController?.hidesNavigationBarDuringPresentation = false
        searchBarView.addSubview((searchController?.searchBar)!)
    }
}

// MARK: - GMSAutocompleteResultsViewControllerDelegate
extension RecommendationViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false

        let selectedCoordinate = GMSCameraUpdate.setTarget(place.coordinate, zoom: DEFAULT_ZOOM)
        mapView.animate(with: selectedCoordinate)

        let marker = PlaceMarker(place: place)
        mapView.clear()
        marker.map = mapView
        selectedPlace = place

        searchController?.searchBar.text = place.name

        if !addButtonShown {
            UIView.animate(withDuration: 0.5, animations: {
                self.addToGroupButton.layer.shadowOffset = CGSize.init(width: 0, height: 0)
                self.addToGroupButton.layer.shadowRadius = 4
                self.addToGroupButton.layer.shadowOpacity = 0.25

                self.addToGroupButton.center.y += self.addToGroupButton.frame.height + 10
            })

            addButtonShown = true
        }
    }

    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - CLLocationManagerDelegate
extension RecommendationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.compassButton = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {

            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: DEFAULT_ZOOM, bearing: 0, viewingAngle: 0)

            let visibleRegion = mapView.projection.visibleRegion()
            resultsViewController?.autocompleteBounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)

            locationManager.stopUpdatingLocation()
        }
    }
}

// MARK: - GMSMapViewDelegate
extension RecommendationViewController: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {

        CATransaction.begin()
        CATransaction.setValue(Int(1), forKey: kCATransactionAnimationDuration)
        if (mapView.camera.zoom < MIN_ZOOM || mapView.camera.zoom > DEFAULT_ZOOM) {
            mapView.animate(to: GMSCameraPosition.camera(withTarget: (locationManager.location?.coordinate)!, zoom: DEFAULT_ZOOM))
        }
        else {
            mapView.animate(toLocation: (locationManager.location?.coordinate)!)
        }
        CATransaction.commit()

        return false
    }
}
