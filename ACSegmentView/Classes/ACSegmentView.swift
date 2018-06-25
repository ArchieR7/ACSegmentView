//
//  ACSegmentView.swift
//  ACSegmentView
//
//  Created by Archie on 2018/6/23.
//

import RxSwift
import RxCocoa

public class ACSegmentView: UIView {
    private var stackView = UIStackView() {
        didSet {
            setUpStackView()
        }
    }
    private let selectedLineView = UIView()
    private var buttons = [UIButton]()
    private let disposeBag = DisposeBag()
    private var selectedLineViewCenterX: NSLayoutConstraint?
    
    public var viewModel: ACSegmentViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            removeAllSubviews()
            selectedLineView.backgroundColor = viewModel.selectedLineColor
            addSubview(selectedLineView)
            setUpSelectedLineView(size: viewModel.selectedLineSize)
            setUpButtons(titles: viewModel.titles, font: viewModel.titleFont)
            viewModel.selectedIndex.distinctUntilChanged().asObservable().subscribe(onNext: { [weak self] index in
                guard let `self` = self else { return }
                var targetButton: UIButton?
                self.selectedLineViewCenterX?.isActive = false
                self.buttons.forEach({ (button) in
                    if button.tag == index {
                        targetButton = button
                    }
                    button.setTitleColor(button.tag == index ? viewModel.buttonSelectedTitleColor : viewModel.buttonTitleDefaultColor, for: .normal)
                })
                guard let button = targetButton else { return }
                self.selectedLineViewCenterX = NSLayoutConstraint(item: self.selectedLineView, attribute: .centerX, relatedBy: .equal, toItem: targetButton, attribute: .centerX, multiplier: 1, constant: 0)
                UIView.animate(withDuration: 0.33, animations: {
                    self.selectedLineView.center.x = button.center.x
                    self.selectedLineViewCenterX?.isActive = true
                })
            }).disposed(by: disposeBag)
        }
    }
    
    private func removeAllSubviews() {
        stackView.removeFromSuperview()
        selectedLineView.removeFromSuperview()
    }
    
    private func setUpButtons(titles: [String], font: UIFont?) {
        guard let viewModel = viewModel else { return }
        buttons = titles.enumerated().map({ (index, title) -> UIButton in
            let button = UIButton()
            button.tag = index
            button.setTitle(title, for: .normal)
            button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            button.titleLabel?.font = font
            button.setTitleColor(viewModel.buttonTitleDefaultColor, for: .normal)
            button.rx.tap.map({ (_) -> Int in
                return button.tag
            }).bind(to: viewModel.selectedIndex).disposed(by: disposeBag)
            return button
        })
        stackView = UIStackView(arrangedSubviews: buttons)
        buttons.forEach { (button) in
            if button.tag != 0 {
                NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: buttons.first, attribute: .width, multiplier: 1, constant: 0).isActive = true
            }
        }
    }
    
    private func setUpStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    
    private func setUpSelectedLineView(size: CGSize) {
        selectedLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: selectedLineView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width).isActive = true
        NSLayoutConstraint(item: selectedLineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: selectedLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height).isActive = true
        
    }
}
