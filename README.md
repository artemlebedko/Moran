# Moran
![Swift 4.2+](https://img.shields.io/badge/Swift-4.2%2B-orange.svg)
![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg)
[![Version](https://img.shields.io/cocoapods/v/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)
[![License](https://img.shields.io/cocoapods/l/Moran.svg?style=flat)](https://cocoapods.org/pods/Moran)

## Overview
![Simple custom transition demo](https://github.com/artemlebedko/Moran/blob/master/Demo_preview.gif)

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

You can change transitionDuration as you wish. Default value is 0.3 second.
```
Moran(animatedView: someViewToStart, transitionDuration: 0.1)
```

## Author

Artem Lebedko, artemlebedko@gmail.com

## Special 
Thanks to [JTMaterialTransition](https://github.com/jonathantribouharet/JTMaterialTransition)! I referred a lot to this project.

## License

Moran is available under the MIT license. See the LICENSE file for more info.
