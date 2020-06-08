//
//  WaterDataModel.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/8/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

class WaterDataModel: Codable {
    var greenPoints: Int = 0
    var saving: Int = 0
    var current: [String: Int] = [:]
    var quality: [WaterQuality] = []
}
