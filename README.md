# Moran

[![CI Status](https://img.shields.io/travis/artemlebedko/Moran.svg?style=flat)](https://travis-ci.org/artemlebedko/Moran)
[![Version](https://img.shields.io/cocoapods/v/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)
[![License](https://img.shields.io/cocoapods/l/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)
[![Platform](https://img.shields.io/cocoapods/p/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)

## Installation

- Using [CocoaPods](http://cocoapods.org/):

  ```ruby
  pod 'Moran'
  ```

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

## Author

artemlebedko, artemlebedko@gmail.com

## License

Moran is available under the MIT license. See the LICENSE file for more info.
