//
//  ViewController.swift
//  CardStyleLifecycle
//
//  Created by Giftbot on 2019/08/02.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import os.log
import UIKit

final class MainViewController: UIViewController {
  
  // MARK: ViewController Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    os_log(.default, log: .main, "viewWillAppear")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    os_log(.default, log: .main, "viewDidAppear")
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    os_log(.default, log: .main, "viewWillDisappear")
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    os_log(.default, log: .main, "viewDidDisappear")
  }
  
  // MARK: Segue
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let naviController = segue.destination as? UINavigationController,
      let settingVC = naviController.topViewController as? SettingViewController
      else { return }
    let isDarkMode = traitCollection.userInterfaceStyle == .dark
    settingVC.isDarkMode = isDarkMode
  }
}

