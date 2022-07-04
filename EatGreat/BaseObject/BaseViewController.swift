//
//  BaseViewController.swift
//  GogolookInterviewTest
//
//  Created by Book on 2022/4/19.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private var largeTitleColor:UIColor?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for view in self.navigationController?.navigationBar.subviews ?? [] {
             let subviews = view.subviews
             if subviews.count > 0, let label = subviews[0] as? UILabel {
                  label.textColor = largeTitleColor
             }
        }
    }
    
    func setNavigationBar(title: String?,
                          backgroundColor: UIColor = .white,
                          titleColor: UIColor = .black) {
        navigationItem.title = title
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        setNavigationBarAppearance(backgroundColor: backgroundColor, titleColor: titleColor)
    }
    
    func setNavigationBar(largeTitle: String, backgroundColor: UIColor, titleColor: UIColor) {
        navigationItem.title = largeTitle
        self.largeTitleColor = titleColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        setNavigationBarAppearance(backgroundColor: backgroundColor, titleColor: titleColor)
    }
    
    func setNavigationBar(isHiddenBottomLine: Bool, color: UIColor = UIColor.black.withAlphaComponent(0.15)) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let backgroundColor = navigationController?.navigationBar.backgroundColor
        
        if let appearance = navigationController?.navigationBar.standardAppearance.copy() {
            if isHiddenBottomLine {
                appearance.shadowColor = .clear
            } else {
                appearance.shadowColor = .separator
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            let navigationBarAppearence = UINavigationBarAppearance()
            navigationBarAppearence.configureWithOpaqueBackground()
            navigationBarAppearence.backgroundColor = backgroundColor
            if let attri = navigationController?.navigationBar.titleTextAttributes {
                navigationBarAppearence.titleTextAttributes = attri
            }
            if isHiddenBottomLine {
                navigationBarAppearence.shadowColor = .clear
            } else {
                navigationBarAppearence.shadowColor = .separator
            }
            navigationController?.navigationBar.standardAppearance = navigationBarAppearence
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence
        }
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    private func setNavigationBarAppearance(backgroundColor: UIColor,
                                            titleColor: UIColor) {
        if let appearance = navigationController?.navigationBar.standardAppearance.copy() {
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            let navigationBarAppearence = UINavigationBarAppearance()
            navigationBarAppearence.configureWithOpaqueBackground()
            navigationBarAppearence.backgroundColor = backgroundColor
            navigationBarAppearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
            navigationController?.navigationBar.standardAppearance = navigationBarAppearence
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence
        }
        
        navigationController?.navigationBar.setNeedsLayout()
    }
}
