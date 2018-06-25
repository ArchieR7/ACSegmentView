//
//  ViewController.swift
//  ACSegmentView
//
//  Created by Archie-BlaySolutions on 06/25/2018.
//  Copyright (c) 2018 Archie-BlaySolutions. All rights reserved.
//

import UIKit
import ACSegmentView
import RxSwift

class ViewController: UIViewController {

    @IBOutlet private weak var segmentView: ACSegmentView!
    @IBOutlet private weak var demoLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var viewModel: ACSegmentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            segmentView.viewModel = viewModel
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ACSegmentViewModel(titles: ["Segment 1", "Segment 2", "Segment 3"])
    }
}

extension ViewController: ACSegmentViewModelDelegate {
    func segmentView(didSelectIndexAt index: Int) {
        demoLabel.text = "Select \(index)"
    }
}
