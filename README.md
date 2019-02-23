# Moran

[![CI Status](https://img.shields.io/travis/artemlebedko/Moran.svg?style=flat)](https://travis-ci.org/artemlebedko/Moran)
[![Version](https://img.shields.io/cocoapods/v/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)
[![License](https://img.shields.io/cocoapods/l/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)
[![Platform](https://img.shields.io/cocoapods/p/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage
```Swift
import Moran

var transition: Moran?

//when you presenting another view controller set delegate and presentation style
let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.modalPresentationStyle = .custom
            detailViewController.transitioningDelegate = self.transition
            present(detailViewController, animated: true)
        }
        
//add element where animation will started
self.transition = Moran(animatedView: button, transitionDuration: 0.5)
```
## Installation

Moran is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Moran'
```

## Author

artemlebedko, artemlebedko@gmail.com

## License

Moran is available under the MIT license. See the LICENSE file for more info.
