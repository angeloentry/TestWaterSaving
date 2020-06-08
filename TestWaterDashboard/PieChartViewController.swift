//
//  PieChartViewController.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/7/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit
import Charts




typealias DataPoint = (legend: String, percent: Double)
class PieChartViewController: UIViewController {
    @IBOutlet weak var pieSourceView: PieChartView!
    @IBOutlet weak var pieUsagePlacesView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPieData()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func fetchPieData() {
        Request.fetchPieData.execute(success: { [weak self] (res, data: PieModel) in
            DataManager.shared.pieModel = data
            let pieData = DataManager.shared.pieModel
            self?.drawChart(with: pieData.sources, on: self?.pieSourceView, title: "Water Sources")
            self?.drawChart(with: pieData.places, on: self?.pieUsagePlacesView, title: "Used At")
        }, failure: { (error) in
            print(error)
        })
    }
    
    func drawChart(with dataPoints: [String: Double], on view: PieChartView?, title: String) {
        guard let pieView = view else { return }
        setup(pieChartView: pieView, title: title)
        let dataEntries = dataPoints.compactMap { (key, value) -> PieChartDataEntry? in
            guard value != 0 else { return nil }
            return PieChartDataEntry(value: value, label: key)
        }
        
        let valueNotFound = PieChartDataEntry(value: 100, label: "No Data Found")
        let finalEntries = dataEntries.count > 0 ? dataEntries : [valueNotFound]
        let dataSet = PieChartDataSet(entries: finalEntries, label: title)
        let pieChartData = PieChartData(dataSet: dataSet)
        
        dataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]
        
        let pFormatter = NumberFormatter()
               pFormatter.numberStyle = .percent
               pFormatter.maximumFractionDigits = 1
               pFormatter.multiplier = 1
               pFormatter.percentSymbol = " %"
               
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        pieChartData.setValueFont(.systemFont(ofSize: 11, weight: .regular))
        pieChartData.setValueTextColor(.black)
        
        let legend = pieView.legend
        legend.xEntrySpace = 10
        legend.font = NSUIFont.systemFont(ofSize: 15)
        legend.textColor = .black
    
        pieView.data = pieChartData
        pieView.entryLabelColor = .black
        pieView.highlightValues(nil)
        
        pieView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PieChartViewController: ChartViewDelegate {
    func setup(pieChartView chartView: PieChartView, title: String) {
            chartView.usePercentValuesEnabled = true
            chartView.drawSlicesUnderHoleEnabled = false
            chartView.holeRadiusPercent = 0.58
            chartView.transparentCircleRadiusPercent = 0.61
            chartView.chartDescription?.enabled = false
            chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)

            chartView.drawCenterTextEnabled = true

            let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.lineBreakMode = .byTruncatingTail
            paragraphStyle.alignment = .center

            let centerText = NSMutableAttributedString(string: title)
            centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 20)!,
                                      .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
            chartView.centerAttributedText = centerText;

            chartView.drawHoleEnabled = true
            chartView.rotationAngle = 0
            chartView.rotationEnabled = true
            chartView.highlightPerTapEnabled = true

            let l = chartView.legend
//            l.horizontalAlignment = .right
//            l.verticalAlignment = .top
//            l.orientation = .vertical
            l.drawInside = false
            l.xEntrySpace = 7
            l.yEntrySpace = 0
            l.yOffset = 0
    //        chartView.legend = l
        }
}
