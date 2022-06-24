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
