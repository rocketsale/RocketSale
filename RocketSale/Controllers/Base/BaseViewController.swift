//
//  BaseViewController.swift
//  RocketSale
//
//  Created by Ryan Luu on 5/14/19.
//  Copyright © 2019 RocketInc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Lifecycle
    
    // Custom initializers go here
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ...
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Layout
    
    private func makeGenericViewConstraints() {
        // ...
    }
    
    // MARK: User Interaction
    
    func onGenericButtonTapped() {
        // ...
    }
    
    // MARK: Generic Delegate Methods (i.e. TableViewDelegate or CollectionViewDelegate)
    
    func genericDelegate() {
        // ...
    }
    
    // MARK: Additional Helpers
    
    private func genericHelper() {
        // ...
    }

}
