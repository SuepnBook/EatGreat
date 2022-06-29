//
//  ProfileViewController.swift
//  EatGreat
//
//  Created by Book on 2022/6/29.
//

import UIKit

protocol ProfileViewControllerDelegate:AnyObject {
    func selectNext(vc:ProfileViewController)
}

class ProfileViewController: BaseViewController {
    
    weak var delegate:ProfileViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
