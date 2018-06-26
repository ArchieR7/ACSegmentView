# ACSegmentView

[![CI Status](https://img.shields.io/travis/ArchieR7/ACSegmentView.svg?style=flat)](https://travis-ci.org/ArchieR7/ACSegmentView)
[![Version](https://img.shields.io/cocoapods/v/ACSegmentView.svg?style=flat)](https://cocoapods.org/pods/ACSegmentView)
[![License](https://img.shields.io/cocoapods/l/ACSegmentView.svg?style=flat)](https://cocoapods.org/pods/ACSegmentView)
[![Platform](https://img.shields.io/cocoapods/p/ACSegmentView.svg?style=flat)](https://cocoapods.org/pods/ACSegmentView)

<a href="https://imgflip.com/gif/2cu2nv"><img src="https://i.imgflip.com/2cu2nv.gif" title="made at imgflip.com"/></a>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirement
- Swift 4.x
- Xcode 9.x
- iOS 10 or above

## Installation

ACSegmentView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ACSegmentView', '~> 1.0.2'
```

## Dependencies
- [RxSwift](https://www.github.com/ReactiveX/RxSwift)

## Usage
`ACSegmentViewModel` provides `rx` to subscribe with RxSwift.
We can create a `ACSegmentViewModel` and subscribe it to do something while user select difference index.

Here's an example, we subscribed `ACSegmentViewModel.rx.selectedSegmentIndex` and convert to string for `UILabel`.
```
viewModel.rx.selectedSegmentIndex.map { (index) -> String in
    return "Select \(index)"
}.bind(to: demoLabel.rx.text).disposed(by: disposeBag)
```
then set `ACSegmentViewModel` to be `ACSegmentView.viewModel`.👏👏👏

## Author

Archie, Archie@Archie.tw

## License

ACSegmentView is available under the MIT license. See the LICENSE file for more info.
