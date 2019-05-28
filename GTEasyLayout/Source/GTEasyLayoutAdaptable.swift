//
//  GTEasyLayoutAdaptable.swift
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
 Layout views, apply constraints and update them easily by using the methods
 specified in the `GTEasyLayoutAdaptable` protocol. An extension with default
 implementation is included for instant usage of the protocol.
 */
public protocol GTEasyLayoutAdaptable {
    
    func add(view: UIView, to targetView: UIView, snapTo edges: GTEasyLayout.SnapEdges, padding: UIEdgeInsets, size: CGSize)
    
    func updatePadding(at side: GTEasyLayout.Side, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (()-> Void)?)
    
    func updateDimension(_ dimension: GTEasyLayout.Dimension, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (() -> Void)?)
}



extension GTEasyLayoutAdaptable {
    
    /**
     It adds the given view as a subview to the target view, snapping it to
     the specified edges and applying spacing on each side as described by
     the padding parameter value.
     
     All edge values except for the "all" case require the width, the height,
     or both to have a proper value in the `size` parameter. In case there's no
     need to provide them, then just pass a zero size (`CGSize.zero`).
     
     See the `GTEasyLayout.SnapEdges` enumeration for available values regarding
     edge snapping. To center a view both horizontally and vertically provide the
     "centerX_Y" edge along with a valid size for it.
     
     Use the `padding` parameter value to add some spacing to each side of the view.
     If no spacing is necessary, pass a zero edge insets value (`UIEdgeInsets.zero`).
     
     When using any combination of snap edges which includes horizontal or vertical
     centering (centerX or centerY), then provide only the "left" and "top" values of the
     `padding` property, "right" and "bottom" are disregarded. To add padding to the left
     set a positive value to the "left" parameter of the edge insets; to add padding to
     the right set a negative value instead. Accordingly, in vertical axis provide a
     positive value to "top" parameter of the edge insets so the view is "pushed" down;
     give a negative value to "push" it up.
     
     Note that this method takes into account the safe area of the screen.
     
     - Parameter view: The view that should be added as a subview and setup constraints for it.
     - Parameter targetView: The view that will contain the first one.
     - Parameter edges: A `GTEasyLayout.SnapEdges` value which specifies the edges of the
     target view where the new view should snap to.
     - Parameter padding: An optional spacing on any side of the new view.
     - Parameter size: The width and height of the view as a CGSize type. Make sure to provide
     proper values to any dimension necessary.
    */
    public func add(view: UIView, to targetView: UIView, snapTo edges: GTEasyLayout.SnapEdges, padding: UIEdgeInsets, size: CGSize) {
        // Add the view to the target view as a subview.
        targetView.addSubview(view)
        // Set this to false to prevent automatic constraints creation.
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Specify the view's name.
        // It's needed as it will be used as part of an identifier
        // for each constraint as shown in the following lines.
        // The view name is the type of the view.
        let viewName = "\(type(of: view))"
        
        // Initialize an array which will hold the constraints
        // that will apply to the view depending on the edges value.
        var constraints = [NSLayoutConstraint]()
        
        // Set the default constraints.
        // At first check if the edges value is other than "centerX_Y".
        // This is a special case treated in the "else" clause.
        //
        // Create constraints for the "all" edges value. If the actual given
        // edges parameter has a different value, then the unnecessary constraints
        // will be removed in the switch statement below and the missing ones will
        // be added there too.
        if edges != .centerX_Y {
            // Set top, left, right and bottom anchors - use the padding value
            // to add some spacing to each side as specified.
            constraints.append(view.topAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor, constant: padding.top, identifier: "\(viewName)_top"))
            constraints.append(view.leftAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.leftAnchor, constant: padding.left, identifier: "\(viewName)_left"))
            constraints.append(view.rightAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.rightAnchor, constant: padding.right, identifier: "\(viewName)_right"))
            constraints.append(view.bottomAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor, constant: padding.bottom, identifier: "\(viewName)_bottom"))
        } else {
            // This is the case of "centerX_Y" edges value.
            // In this case the view is centered both horizontally and vertically
            // by setting the respective constraints (centerX and centerY), and the
            // additional constraints created regard the width and height (as given in
            // the size parameter value).
            constraints.append(view.centerXAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerXAnchor, constant: padding.left, identifier: "\(viewName)_centerX"))
            constraints.append(view.centerYAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerYAnchor, constant: padding.top, identifier: "\(viewName)_centerY"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
        }
        
        // The following switch statement covers any case but "all" and "centerX_Y".
        // Depending on the edges value, one or more constraints previously added to
        // the constraints array above is being removed and the missing ones
        // (width, height, centerX, centerY) are being added instead.
        // Note that in case of "centerX_Y" edges none of the following cases will be
        // executed - it's a special case which has been handled already above.
        switch edges {
        case .topRightBottom:
            // Not necessary anchor: Left - Need: Width
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
        
        case .topRightLeft:
            // Not necessary anchor: Bottom - Need: Height
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
        
        case .topLeftBottom:
            // Not necessary anchor: Right - Need: Width
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
        
        case .bottomRightLeft:
            // Not necessary anchor: Top - Need: Height
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .topLeft:
            // Not necessary anchors: Right & Bottom
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
        
        case .topRight:
            // Not necessary anchors: Left & Bottom
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .bottomLeft:
            // Not necessary anchors: Right & Top
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .bottomRight:
            // Not necessary anchors: Left & Top
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .topBottomCenterX:
            // Not necessary anchors: Left & Right - Need: Width & CenterX
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.append(view.centerXAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerXAnchor, constant: padding.left, identifier: "\(viewName)_centerX"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            
        case .topCenterX:
            // Not necessary anchors: Left & Right & Bottom - Need: Width & Height & CenterX
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.append(view.centerXAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerXAnchor, constant: padding.left, identifier: "\(viewName)_centerX"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .bottomCenterX:
            // Not necessary anchors: Left & Right & Top - Need: Width & Height & CenterX
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.append(view.centerXAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerXAnchor, constant: padding.left, identifier: "\(viewName)_centerX"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .leftRightCenterY:
            // Not necessary anchors: Top & Bottom - Need: Height & CenterY
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.append(view.centerYAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerYAnchor, constant: padding.top, identifier: "\(viewName)_centerY"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
            
        case .leftCenterY:
            // Not necessary anchors: Top & Bottom & Right - Need: Width & Height & CenterY
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.removeAll { $0.identifier == "\(viewName)_right" }
            constraints.append(view.centerYAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerYAnchor, constant: padding.top, identifier: "\(viewName)_centerY"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
        
        case .rightCenterY:
            // Not necessary anchors: Top & Bottom & Left - Need: Width & Height & CenterY
            constraints.removeAll { $0.identifier == "\(viewName)_top" }
            constraints.removeAll { $0.identifier == "\(viewName)_bottom" }
            constraints.removeAll { $0.identifier == "\(viewName)_left" }
            constraints.append(view.centerYAnchor.setupConstraint(equalTo: targetView.safeAreaLayoutGuide.centerYAnchor, constant: padding.top, identifier: "\(viewName)_centerY"))
            constraints.append(view.widthAnchor.setupConstraint(equalToConstant: size.width, identifier: "\(viewName)_width"))
            constraints.append(view.heightAnchor.setupConstraint(equalToConstant: size.height, identifier: "\(viewName)_height"))
        
        default: ()
        }
        
        // Activate the constraints.
        _ = constraints.map { $0.isActive = true }
    }
    
    
    
    /**
     Update the padding at the specified side of the given view by applying a new value.
     Optionally provide customized animation settings and a completion handler.
     
     - Parameter side: The side of the view where the padding should be changed at.
     - Parameter view: The view the update regards.
     - Parameter newValue: The new value that should be applied.
     - Parameter animationSettings: The animation settings for the animation that will
     show the padding change. If you want to keep the default settings then pass `nil`. If
     you don't want animation, initialize a `GTEasyLayout.AnimationSettings` object
     and set the animation duration to zero.
     - Parameter completion: An optional closure which will be called upon finishing the
     animated changes.
    */
    public func updatePadding(at side: GTEasyLayout.Side, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (()-> Void)?) {
        // Get the parent view of the given view.
        // Note that if the superview property below is nil then the
        // method returns and no further actions are taken.
        guard let parentView = view.superview else { return }
        
        // Specify the name of the view - it's the type of the view.
        // The proper side will be appended next.
        let viewName = "\(type(of: view))"
        
        // Find the constraint that should be updated in the collection
        // of constraints of the parent view using the type of the view
        // and the side as the identifier to search for.
        //
        // Note: Since the change is about to be made to a constraint which
        // is not dimension, then the constraint will be found in the parent
        // view and not in the given view itself.
        guard let constraint = parentView.constraints.filter({ (constraint) -> Bool in
            return constraint.identifier == "\(viewName)_\(side)"
        }).first else { print("Couldn't find constraint with identifier \(viewName)_\(side)"); return }
        
        // Set the new value to the constant.
        constraint.constant = newValue
        
        // Check if custom animation settings were specified.
        // If not then initialize and use the default ones from
        // a GTEasyLayout.AnimationSettings object.
        let animSettings = animationSettings == nil ? GTEasyLayout.AnimationSettings() : animationSettings!
        
        UIView.animate(withDuration: animSettings.duration, delay: animSettings.delay, usingSpringWithDamping: animSettings.damping, initialSpringVelocity: animSettings.velocity, options: animSettings.options, animations: {
            // Update the constraint animated.
            parentView.layoutIfNeeded()
        }) { (finished) in
            if finished {
                // Upon finishing call the completion handle if it was provided.
                completion?()
            }
        }
    }
    
    
    
    /**
     Update the width or height constraint of the given view to the new value.
     
     - Parameter dimension: The dimension (width, height) to change. It's a
     `GTEasyLayout.Dimension` value.
     - Parameter view: The view the update regards.
     - Parameter newValue: The new value to set.
     - Parameter animationSettings: The animation settings for the animation that will
     show the dimension change. If you want to keep the default settings then pass `nil`. If
     you don't want animation, initialize a `GTEasyLayout.AnimationSettings` object
     and set the animation duration to zero.
     - Parameter completion: An optional closure which will be called upon finishing the
     animated changes.
    */
    public func updateDimension(_ dimension: GTEasyLayout.Dimension, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (() -> Void)?) {
        // Get the parent view of the given view.
        // Note that if the superview property below is nil then the
        // method returns and no further actions are taken.
        guard let parentView = view.superview else { return }
        
        // Specify the name of the view - it's the type of the view.
        // The proper dimension will be appended next.
        let viewName = "\(type(of: view))"
        
        // Find the proper constraint in the collection of the view's constraints
        // using the identifier built from the type of the view and the dimension.
        guard let constraint = view.constraints.filter({ (constraint) -> Bool in
            return constraint.identifier == "\(viewName)_\(dimension)"
        }).first else { print("Couldn't find constraint with identifier \(viewName)_\(dimension)"); return }
        
        // Set the new value to the constraint.
        constraint.constant = newValue
        
        // Check if custom animation settings were specified.
        // If not then initialize and use the default ones from
        // a GTEasyLayout.AnimationSettings object.
        let animSettings = animationSettings == nil ? GTEasyLayout.AnimationSettings() : animationSettings!
        
        UIView.animate(withDuration: animSettings.duration, delay: animSettings.delay, usingSpringWithDamping: animSettings.damping, initialSpringVelocity: animSettings.velocity, options: animSettings.options, animations: {
            parentView.layoutIfNeeded()
        }) { (finished) in
            if finished {
                // Call the completion handler if it was set upon
                // finishing animating the constraint change.
                completion?()
            }
        }
    }
}



extension NSLayoutAnchor {
    @objc func setupConstraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat, identifier: String?) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: c)
        constraint.identifier = identifier
        return constraint
    }
    
}



extension NSLayoutDimension {
    @objc func setupConstraint(equalToConstant c: CGFloat, identifier: String) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: c)
        constraint.identifier = identifier
        return constraint
    }
}


extension UIEdgeInsets {
    public init(all value: CGFloat) {
        self = UIEdgeInsets(top: value, left: value, bottom: -value, right: -value)
    }
}
