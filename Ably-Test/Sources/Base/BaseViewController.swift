//
//  BaseViewController.swift
//  Ably-Test
//
//  Created by SeungHyeon Wang on 2022/09/06.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
  
  // MARK: Properties
  
  private(set) var didSetupConstraints = false
  
  var disposeBag = DisposeBag()
  
  
  // MARK: Initialize
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }
  
  
  // MARK: Set Layout
  
  func setupConstraints() {
    
  }
  
}
