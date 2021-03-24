//
//  Cart11.swift
//  PicoCart
//
//  Created by David Lund on 1/26/21.
//

import Foundation

class Cart11 : Cart {
    
    //
 //
 // centerX-- X origin of the spiral.
 // centerY-- Y origin of the spiral.
 // radius--- Distance from origin to outer arm.
 // sides---- Number of points or sides along the spiral's arm.
 // coils---- Number of coils or full rotations. (Positive numbers spin clockwise, negative numbers spin counter-clockwise)
 // rotation- Overall rotation of the spiral. ('0'=no rotation, '1'=360 degrees, '180/360'=180 degrees)
 //
    func SetBlockDisposition(centerX:Double,  centerY:Double, radius:Double,  sides:Double, coils:Double,  rotation: Double)
    {
        // value of theta corresponding to end of last coil
        let thetaMax = coils * 2.0 * Double.pi

        // How far to step away from center for each side.
        let awayStep = radius / thetaMax

        // distance between points to plot
        let chord = 10.0

        // For every side, step around and away from center.
        // start at the angle corresponding to a distance of chord
        // away from centre.
        var theta = chord / awayStep
        while ( theta <= thetaMax) {
            //
            // How far away from center
            let away = awayStep * theta
            //
            // How far around the center.
            let around = theta + rotation
            //
            // Convert 'around' and 'away' to X and Y.
            let x = centerX + Foundation.cos ( around ) * away
            let y = centerY + Foundation.sin ( around ) * away
            //
            // Now that you know it, do it.
            pico.circfill(x: x, y: y, r: 2, color: 10)

            // to a first approximation, the points are on a circle
            // so the angle between them is chord/radius
            theta += chord / away
        }
    }
    
    func SetBlockDispositionPico(centerX:Double,  centerY:Double, radius:Double,  sides:Double, coils:Double,  rotation: Double)
    {
        // value of theta corresponding to end of last coil
        let thetaMax = coils

        // How far to step away from center for each side.
        let awayStep = radius / thetaMax

        // distance between points to plot
        let chord = 1.0

        // For every side, step around and away from center.
        // start at the angle corresponding to a distance of chord
        // away from centre.
        var theta = chord / awayStep
        while ( theta <= thetaMax) {
            //
            // How far away from center
            let away = awayStep * theta
            //
            // How far around the center.
            let around = theta + rotation
            //
            // Convert 'around' and 'away' to X and Y.
            let x = centerX + pico.cos ( around ) * away
            let y = centerY + pico.sin ( around ) * away
            //
            // Now that you know it, do it.
            pico.circ(x: x, y: y, r: 16, color: 10)

            // to a first approximation, the points are on a circle
            // so the angle between them is chord/radius
            theta += chord / away
        }
    }
    
    override func initCart() {
        pico.cls(0)
        SetBlockDispositionPico(centerX: 64, centerY: 64, radius: 128, sides: 0, coils: 8, rotation: 0)
    }
    
    override func draw() {
    }
}
