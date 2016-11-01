//
//  PlaceMarker.swift
//  
//
//  Created by Derek Vitaliano Vallar on 10/19/16.
//
//

import GoogleMaps
import GooglePlaces

class PlaceMarker: GMSMarker {

    let place: GMSPlace

    init(place: GMSPlace) {
        self.place = place
        super.init()

        position = place.coordinate
        icon = UIImage(named: place.types[0] + "_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
