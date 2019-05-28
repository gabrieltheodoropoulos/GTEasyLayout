//
//  ViewController.swift
//  GTEasyLayoutDemo
//
//  Created by Gabriel Theodoropoulos on 28/05/2019.
//  Copyright © 2019 Gabriel Theodoropoulos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GTEasyLayoutAdaptable {

    lazy var testView1: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "View #1"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 34.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor.darkGray
        return label
    }()
    
    
    lazy var testView2: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "View #2"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 34.0)
        label.textAlignment = .center
        label.backgroundColor = UIColor.lightGray
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        
        ///////////////////////////////////////////////////////////////////////
        /// Note: Uncomment or comment out the various examples in this     ///
        /// and viewDidAppear(animated:) method so you can try them out.    ///
        ///////////////////////////////////////////////////////////////////////
        
        
        // Snap view to all edges leaving 50px padding from all sides.
        add(view: testView1, to: self.view, snapTo: .all, padding: UIEdgeInsets(all: 50.0), size: .zero)
        
        
        // Snap to top, left, bottom and set the width to 250px. Height will be 0.0, as it's calculated automatically.
        // add(view: testView1, to: self.view, snapTo: .topLeftBottom, padding: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0), size: CGSize(width: 250.0, height: 0.0))
        
        
        // Center both horizontally and vertically.
        // View size is 200x150px.
        // add(view: testView1, to: self.view, snapTo: .centerX_Y, padding: .zero, size: CGSize(width: 200.0, height: 150.0))
        
        
        // Snap two views to top-left-right and bottom-left-right.
        // Height is the same in both (150px).
        // add(view: testView1, to: self.view, snapTo: .topRightLeft, padding: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0), size: CGSize(width: 0.0, height: 150.0))
        // add(view: testView2, to: self.view, snapTo: .bottomRightLeft, padding: .zero, size: CGSize(width: 0.0, height: 150.0))
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Update the padding on the left side of the view.
        // Initially set it to -250 so the view is positioned
        // out of the visible area of the screen.
        /*
        add(view: testView1, to: self.view, snapTo: .topLeftBottom, padding: UIEdgeInsets(top: 20.0, left: -250.0, bottom: 0.0, right: 0.0), size: CGSize(width: 250.0, height: 0.0))

        // Update the left padding after 1 second.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Create custom animation settings.
            let animSettings = GTEasyLayout.AnimationSettings(withDuration: 0.5,
                                                              delay: 0.0,
                                                              damping: 0.7,
                                                              velocity: 1.0,
                                                              options: .curveLinear)

            // Update the padding animated.
            self.updatePadding(at: .left,
                               ofView: self.testView1,
                               newValue: 0.0,
                               animationSettings: animSettings,
                               completion: nil)
        }
        */
        
        
        
        
        
        // Update a dimension value.
        /*
        add(view: testView2,
            to: self.view,
            snapTo: .bottomCenterX,
            padding: .zero,
            size: CGSize(width: 300.0, height: 200.0))
        
        // Double the height after 1 second.
        // Use the default animation settings this time.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.updateDimension(.height,
                                 ofView: self.testView2,
                                 newValue: 400.0,
                                 animationSettings: nil,
                                 completion: nil)
        }
        */
    }

}

