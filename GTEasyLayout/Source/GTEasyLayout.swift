//
//  GTEasyLayout.swift
//  GTEasyLayout
//
//  Created by Gabriel Theodoropoulos.
//  Copyright © 2019 Gabriel Theodoropoulos. All rights reserved.
//

//    MIT License
//
//    Copyright (c) 2019 Gabriel Theodoropoulos
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.


import UIKit

/**
 This class acts as a namespace to the various custom types defined
 for using along with the `GTEasyLayoutAdaptable` protocol.
 
 **Do not create instances of this class** as it only contains definition
 of custom types.
 */
public class GTEasyLayout {
    /**
     Edge snapping cases which describe combinations regarding
     the position of a view into another view.
     */
    public enum SnapEdges {
        /// Snap to top, right, bottom, left sides.
        case all
        /// Snap to top, right and bottom. *Width* should be provided.
        case topRightBottom
        /// Snap to top right and left edges. *Height* should be provided.
        case topRightLeft
        /// Snap to top, left and bottom. *Width* should be provided.
        case topLeftBottom
        /// Snap to bottom, right and left. *Height* should be provided.
        case bottomRightLeft
        /// Snap to top left edges. *Width* and *Height* should be provided.
        case topLeft
        /// Snap to top right edges. *Width* and *Height* should be provided.
        case topRight
        /// Snap to bottom left edges. *Width* and *Height* should be provided.
        case bottomLeft
        /// Snap to bottom right edges. *Width* and *Height* should be provided.
        case bottomRight
        /// Snap to top and bottom, and center horizontally. *Width* should be provided.
        case topBottomCenterX
        /// Snap to top and center horizontally. *Width* and *Height* should be provided.
        case topCenterX
        /// Snap to bottom and center horizontally. *Width* and *Height* should be provided.
        case bottomCenterX
        /// Snap to left and right and center vertically. *Height* should be provided.
        case leftRightCenterY
        /// Snap to left and center vertically. *Width* and *Height* should be provided.
        case leftCenterY
        /// Snap to right and center vertically. *Width* and *Height* should be provided.
        case rightCenterY
        /// Center the view both horizontally and vertically into its container view.
        /// *Width* and *Height* should be provided for a complete set of constraints.
        case centerX_Y
    }
    
    
    /**
     A programmatic representation of the four sides of a view.
     
     Values of this enumeration are handy to specify the side of a view
     when it's necessary to update the *padding*.
     */
    public enum Side {
        case top
        case bottom
        case left
        case right
    }
    
    
    /**
     A custom representation of the width and height dimensions.
     
     Cases of this enumeration are useful to specify a dimension value
     of a view.
     */
    public enum Dimension {
        case width
        case height
    }
    
    
    /**
     It contains default animation settings which apply when constraints
     are being changed animated.
     
     By default a change to the padding or to a dimension constraint takes
     place animated using the predefined values specified into this structure.
     
     Create objects of this struct to disable animation by setting the duration
     to zero, or customize other animation properties. Custom initializers are
     provided.
     */
    public struct AnimationSettings {
        /// The animation duration. Set this value to 0.0 to prevent animation.
        /// Default value is 0.4.
        public var duration: TimeInterval = 0.4
        
        /// The delay of the animation. Default value is 0.0.
        public var delay: TimeInterval = 0.0
        
        /// The damping. Default value is 0.75.
        public var damping: CGFloat = 0.75
        
        /// The velocity of the animation. Default value is 1.0.
        public var velocity: CGFloat = 1.0
        
        /// Animation options. Default value is "curveEaseInOut".
        public var options: UIView.AnimationOptions = .curveEaseInOut
        
        public init() { }
        
        public init(withDuration duration: TimeInterval) {
            self.duration = duration
        }
        
        public init(withDuration duration: TimeInterval, delay: TimeInterval, damping: CGFloat, velocity: CGFloat, options: UIView.AnimationOptions) {
            self.duration = duration
            self.delay = delay
            self.damping = damping
            self.velocity = velocity
            self.options = options
        }
    }
}
