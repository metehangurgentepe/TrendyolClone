//
//  CategoryViewModel.swift
//  TrendyolClone
//
//  Created by Metehan Gürgentepe on 2.10.2024.
//

import Foundation
import UIKit


struct CategoryButtonModel{
    let title: String
    let image: UIImageView?
    let leftOrRight: LeftOrRight
}

enum LeftOrRight{
    case left
    case right
}
