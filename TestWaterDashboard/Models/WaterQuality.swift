//
//  WaterQuality.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/8/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

class WaterQuality: Codable {
    var type: String = ""
    var oxygen: Double = 0
    var pH: Double = 0
    var NaCl: Double = 0
    var biosolids: Double = 0
}
