//
//  OSLogExtension.swift
//  CardStyleLifecycle
//
//  Created by Giftbot on 2019/08/03.
//  Copyright © 2019 Giftbot. All rights reserved.
//

import Foundation
import os

extension OSLog {
  private static let bundleID = Bundle.main.bundleIdentifier ?? ""
  static let main = OSLog(subsystem: bundleID, category: "Main")
  static let setting = OSLog(subsystem: bundleID, category: "Setting")
  static let delegate = OSLog(subsystem: bundleID, category: "Delegate")
}
