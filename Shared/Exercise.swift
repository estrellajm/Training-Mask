//
//  Exercise.swift
//  Training Mask
//
//  Created by Jose Estrella on 9/24/21.
//

import Foundation
import UIKit

struct Exercise: Identifiable {
    var id: String
    var inhale, hold, exhale, breaths_per_set, sets: Int
    var title: String
    var description: String
    var image: String
}
