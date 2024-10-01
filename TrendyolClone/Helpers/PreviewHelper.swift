//
//  PreviewHelper.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 29.09.2024.
//

import Foundation

import Foundation
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
  
  var viewControllerBuilder: () -> UIViewController
  
  init(_ viewControllerBuilder: @escaping () -> UIViewController) {
    self.viewControllerBuilder = viewControllerBuilder
  }
  
  func makeUIViewController(context: Context) -> some UIViewController {
    viewControllerBuilder()
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
   // Nothing to do here
  }
 
}
