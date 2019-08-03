//
//  SecondViewController.swift
//  CardStyleLifecycle
//
//  Created by Giftbot on 2019/08/02.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import os.log
import UIKit

final class SettingViewController: UIViewController {
  
  @IBOutlet private weak var stateLabel: UILabel!
  @IBOutlet private weak var isDarkModeOn: UISwitch!
  
  private var state: String = "" {
    didSet { stateLabel.text = "\(state)" }
  }
  private var userInterfaceStyle: UIUserInterfaceStyle {
    return isDarkMode ? .dark : .light
  }
  var isDarkMode: Bool = false
  
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("\n")
    
    isDarkModeOn.isOn = isDarkMode
    overrideUserInterfaceStyle = userInterfaceStyle

    // 1) 디스미스 제스처를 통한 디스미스 비활성화
//    isModalInPresentation = true
    
    // 2) 디스미스 제스처 이벤트 제어
    navigationController?.presentationController?.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    os_log(.default, log: .setting, "viewWillAppear")
    state = "View Will Appear"
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    os_log(.default, log: .setting, "viewDidAppear")
    state = "View Did Appear"
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    os_log(.default, log: .setting, "viewWillDisappear")
    state = "View Will Disappear"
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    os_log(.default, log: .setting, "viewDidDisappear")
    state = "View Did Disappear"
  }
  
  
  // MARK: Events
  
  @IBAction private func cancelChanges(_ sender: Any) {
    dismiss(animated: true)
  }
  
  @IBAction private func saveChanges(_ sender: Any) {
    let style: UIUserInterfaceStyle = isDarkModeOn.isOn ? .dark : .light
    presentingViewController?.overrideUserInterfaceStyle = style
    dismiss(animated: true)
  }
  
  private func confirmDismiss() {
    let alertController = UIAlertController(
      title: nil, message: nil, preferredStyle: .actionSheet
    )
    let saveAction = UIAlertAction(title: "Save...", style: .default) {
      self.saveChanges($0)
    }
    let discardAction = UIAlertAction(
      title: "Discard Changes", style: .destructive
    ) { _ in
      self.dismiss(animated: true)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    [saveAction, discardAction, cancelAction].forEach {
      alertController.addAction($0)
    }
    present(alertController, animated: true)
  }
}


// MARK: - UIAdaptivePresentationControllerDelegate

extension SettingViewController: UIAdaptivePresentationControllerDelegate {
  func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
    os_log(.default, log: .delegate, "ShouldDismiss")
    return true
    
    // 3) 데이터가 변경된 경우, 디스미스 제스처를 통한 디스미스 방지
  }
  
  // isModalInPresentation이 true거나 ShouldDismiss가 false일 경우 호출됨
  func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
    os_log(.default, log: .delegate, "DidAttemptToDismiss")
    
    // 4) 디스미스 제스처로 디스미스를 시도했다가 실패한 경우 후처리하기
  }
  
  func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
    os_log(.default, log: .delegate, "WillDismiss")
  }
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    os_log(.default, log: .delegate, "DidDismiss")
  }
}
