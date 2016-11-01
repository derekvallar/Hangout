//
//  PlaceMarker.swift
//  
//
//  Created by Derek Vitaliano Vallar on 10/19/16.
//
//

class PlaceMarker: GMSMarker {

    let place: GooglePlace

    init(place: GooglePlace) {
        self.place = place
        super.init()

        position = place.coordinate
        icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}
