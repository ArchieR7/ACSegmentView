//
//  ScrollSegmentViewModel.swift
//  ScrollSegmentView
//
//  Created by Archie on 2018/6/23.
//

import RxCocoa

final public class ACSegmentViewModel {
    public let selectedIndex = BehaviorRelay.init(value: 0)
    var selectedLineColor: UIColor
    var titles: [String]
    var titleFont: UIFont?
    var selectedLineSize: CGSize
    var buttonTitleDefaultColor: UIColor
    var buttonSelectedTitleColor: UIColor
    
    public init(titles: [String], font: UIFont? = UIFont.init(name: "PingFangHK-Medium", size: 12), selectedLineColor: UIColor = .black, selectedLineSize: CGSize = CGSize(width: UIScreen.main.bounds.size.width * 0.15, height: 2), buttonTitleDefaultColor: UIColor = UIColor.lightGray, buttonSelectedTitleColor: UIColor = UIColor.black) {
        self.titles = titles
        self.selectedLineColor = selectedLineColor
        self.titleFont = font
        self.selectedLineSize = selectedLineSize
        self.buttonTitleDefaultColor = buttonTitleDefaultColor
        self.buttonSelectedTitleColor = buttonSelectedTitleColor
    }
}
