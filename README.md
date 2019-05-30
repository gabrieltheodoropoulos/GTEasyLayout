# GTEasyLayout

![Platform](https://img.shields.io/cocoapods/p/GTEasyLayout.svg)
![Language](https://img.shields.io/github/languages/top/gabrieltheodoropoulos/GTEasyLayout.svg?color=orange)
![License](https://img.shields.io/github/license/gabrieltheodoropoulos/GTEasyLayout.svg)
![Version](https://img.shields.io/cocoapods/v/GTEasyLayout.svg)

## What is GTEasyLayout?

*GTEasyLayout* is a small framework written in Swift which aims to *minimise the effort of setting up constraints programmatically when implementing UI in iOS apps*. It's the perfect tool to use when constraints are not extremely complicated and typing a bunch of similar lines for multiple views becomes tiring and anti-productive.

GTEasyLayout is composed by:

1. The `GTEasyLayoutAdaptable` Swift **protocol** which defines methods that automate the constraint configuration process. An extension with default implementation is included so the aimed functionality exists instantly and out of the box.
2. The `GTEasyLayout` class which is just a *namespace for custom defined types*. There should not be created instances of this class as there are not any available properties or methods to access.

The main idea behind the current implementation is that *a subview snaps to all or some of the edges of the container view*. It's possible to *specify spacing (padding)* between the subview and the container view on any side, to *provide the size of the view*, as well as to *animate changes to the padding and size dimensions* (meaning to change the constraints that control the position and size of the subview animated).

Here is the protocol definition:

```swift
public protocol GTEasyLayoutAdaptable {

    func add(view: UIView, to targetView: UIView, snapTo edges: GTEasyLayout.SnapEdges, padding: UIEdgeInsets, size: CGSize)

    func updatePadding(at side: GTEasyLayout.Side, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (()-> Void)?)

    func updateDimension(_ dimension: GTEasyLayout.Dimension, ofView view: UIView, newValue: CGFloat, animationSettings: GTEasyLayout.AnimationSettings?, completion: (() -> Void)?)
}
```

See the *GTEasyLayout.swift* file for documentation on the custom types appearing above and the *GTEasyLayoutAdaptable.swift* for documentation regarding each method. You can find all that at this [generated documentation](https://gtiapps.com/docs/gteasylayout/index.html) by [jazzy](https://github.com/realm/jazzy).

---

## Integration

GTEasyLayout can be integrated into a project in two different ways:

### Using CocoaPods

In your Podfile add:

```ruby
pod 'GTEasyLayout'
```

Remember to *import* the framework anywhere you are about to use it:

```swift
import GTEasyLayout
```

### Manually

Download or clone this repository, then add the *Source* directory along with the two contained files into your project.

---

## Usage Examples

**Note:** *See the [wiki](https://github.com/gabrieltheodoropoulos/GTEasyLayout/wiki) for detailed examples along with visual representation of the results, or open the sample project in Xcode to see everything in action.*

First, make your class conform to the `GTEasyLayoutAdaptable` protocol:

```swift
class ViewController: UIViewController, GTEasyLayoutAdaptable {
    ...
}
```

Into the point now:

**Snap a subview to all edges** of the view controller's root view leaving 50px padding from all sides:

```swift
add(view: someView,
    to: self.view,
    snapTo: .all,
    padding: UIEdgeInsets(all: 50.0),
    size: .zero)
```

**Snap to top, left, bottom and set the width to 250px**. Height will be 0.0, as it's calculated automatically:

```swift
add(view: myView,
    to: self.view,
    snapTo: .topLeftBottom,
    padding: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0),
    size: CGSize(width: 250.0, height: 0.0))
```

**Center both horizontally and vertically** a view with size 200x150px:

```swift
add(view: someView,
    to: self.view,
    snapTo: .centerX_Y,
    padding: .zero,
    size: CGSize(width: 200.0, height: 150.0))
```

**Updating the padding on the left side animated**:

```swift
let animSettings = GTEasyLayout.AnimationSettings(withDuration: 0.5, delay: 0.0, damping: 0.7, velocity: 1.0, options: .curveLinear)

updatePadding(at: .left,
              ofView: someView,
              newValue: 150.0,
              animationSettings: animSettings,
              completion: nil)
```

**Animating the change of the height dimension** (passing `nil` to `animationSettings` will make the following method use default animation settings):

```swift
updateDimension(.height,
                ofView: someView,
                newValue: 400.0,
                animationSettings: nil,
                completion: nil)
```

If you don't want to animate changes on constraints, then initialize a `GTEasyLayout.AnimationSettings` object and set the `duration` to zero.

---

## Other Notes

GTEasyLayout is a work in progress, and new functionalities will be added over the course of time.

Created with ❤️ by [Gabriel Theodoropoulos](https://gtiapps.com) (gabrielth.devel@gmail.com) and it is provided under the MIT license.
