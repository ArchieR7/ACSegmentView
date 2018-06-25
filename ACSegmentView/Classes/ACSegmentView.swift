//
//  ACSegmentView.swift
//  ACSegmentView
//
//  Created by Archie on 2018/6/23.
//

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
            setUpView(index: 0)
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
            button.addTarget(self, action: #selector(ACSegmentView.clickButton(_:)), for: .touchUpInside)
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
    
    @objc private func clickButton(_ sender: UIButton) {
        setUpView(index: sender.tag)
    }
    
    private func setUpView(index: Int) {
        guard let viewModel = viewModel else { return }
        var targetButton: UIButton?
        selectedLineViewCenterX?.isActive = false
        buttons.forEach({ (button) in
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
        viewModel.delegate?.segmentView(didSelectIndexAt: index)
    }
}
