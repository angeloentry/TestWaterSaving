//
//  DataManager.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/8/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

class DataManager {
    private init() {
        waterData = []
        pieModel = PieModel()
    }
    static let shared = DataManager()
    var waterData: [[DetailTuple]]
    var pieModel: PieModel
    
    typealias DetailTuple = (title: String, detail: String)
    func setData(data: WaterDataModel)  {
        let waterModel = data
        let waterDataArr = [
            ("Current Month Inflow", "\(waterModel.current["inflow"] ?? 0)"),
            ("Current Month Outflow", "\(waterModel.current["outflow"] ?? 0)"),
            ("GreenPoints This Year", "\(waterModel.greenPoints)"),
            ("Savings This Year", "\(waterModel.saving)")
        ]
        let qualityData = waterModel.quality.compactMap { (quality) -> [DetailTuple]? in
            return [("O2", "\(quality.oxygen)"), ("pH", "\(quality.pH)"), ("NaCl", "\( quality.NaCl)"), ("Biosolids", "\(quality.biosolids)")]
        }
        waterData = [waterDataArr] + qualityData
    }
}
