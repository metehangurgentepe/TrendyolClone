//
//  BottomSheet.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 27.09.2024.
//

import UIKit

class BottomSheetViewController: UIViewController {
    // MARK: - UI
    /// Main bottom sheet container view
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    /// View to to hold dynamic content
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Top bar view that draggable to dismiss
    private lazy var topBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sıralama"
        return label
    }()
    
    /// Dimmed background view
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private lazy var topBarLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    
    /// Maximum alpha for dimmed view
    private let maxDimmedAlpha: CGFloat = 0.8
    /// Minimum drag vertically that enable bottom sheet to dismiss
    private let minDismissiblePanHeight: CGFloat = 20
    /// Minimum spacing between the top edge and bottom sheet
    private var minTopSpacing: CGFloat = 80
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresent()
    }
    
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(dimmedView)
        NSLayoutConstraint.activate([
            // Set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Container View
        view.addSubview(mainContainerView)
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainContainerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: minTopSpacing)
        ])
        
        // Top draggable bar view
        mainContainerView.addSubview(topBarView)
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        topBarView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: topBarView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: topBarView.centerYAnchor, constant: 0),
            titleLabel.widthAnchor.constraint(equalToConstant: 120),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        topBarView.addSubview(topBarLine)
        NSLayoutConstraint.activate([
            topBarLine.leadingAnchor.constraint(equalTo: topBarView.leadingAnchor),
            topBarLine.trailingAnchor.constraint(equalTo: topBarView.trailingAnchor),
            topBarLine.centerYAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 0),
            topBarLine.heightAnchor.constraint(equalToConstant: 1)
        ])

        
        // Content View
        mainContainerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor, constant: -10),
            contentView.topAnchor.constraint(equalTo: topBarView.bottomAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDimmedView))
        dimmedView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        topBarView.addGestureRecognizer(panGesture)
    }

    @objc private func handleTapDimmedView() {
        dismissBottomSheet()
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // get drag direction
        let isDraggingDown = translation.y > 0
        guard isDraggingDown else { return }
        
        let pannedHeight = translation.y
        let currentY = self.view.frame.height - self.mainContainerView.frame.height
        // handle gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            self.mainContainerView.frame.origin.y = currentY + pannedHeight
        case .ended:
            // When user stop dragging
            // if fulfil the condition dismiss it, else move to original position
            if pannedHeight >= minDismissiblePanHeight {
                dismissBottomSheet()
            } else {
                self.mainContainerView.frame.origin.y = currentY
            }
        default:
            break
        }
    }

    private func animatePresent() {
        dimmedView.alpha = 0
        mainContainerView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.mainContainerView.transform = .identity
        }
        // add more animation duration for smoothness
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.2, animations: {  [weak self] in
            guard let self = self else { return }
            self.dimmedView.alpha = self.maxDimmedAlpha
            self.mainContainerView.frame.origin.y = self.view.frame.height
        }, completion: {  [weak self] _ in
            self?.dismiss(animated: false)
        })
    }
    
    // sub-view controller will call this function to set content
    func setContent(content: UIView) {
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        view.layoutIfNeeded()
    }
}

extension UIViewController {
    func presentBottomSheet(viewController: BottomSheetViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: false, completion: nil)
    }
}
