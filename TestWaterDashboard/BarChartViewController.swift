//
//  BarChartViewController.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/7/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawChart()
    }
    
    func drawChart() {
        self.setup(barLineChartView: barView)
                
                barView.delegate = self
                
                barView.drawBarShadowEnabled = false
                barView.drawValueAboveBarEnabled = false
                
                barView.maxVisibleCount = 60
                
                let xAxis = barView.xAxis
                xAxis.labelPosition = .bottom
                xAxis.labelFont = .systemFont(ofSize: 10)
                xAxis.granularity = 1
                xAxis.labelCount = 7
                xAxis.valueFormatter = DayAxisValueFormatter(chart: barView)
                
                let leftAxisFormatter = NumberFormatter()
                leftAxisFormatter.minimumFractionDigits = 0
                leftAxisFormatter.maximumFractionDigits = 1
//                leftAxisFormatter.negativeSuffix = " $"
//                leftAxisFormatter.positiveSuffix = " $"
                
                let leftAxis = barView.leftAxis
                leftAxis.labelFont = .systemFont(ofSize: 10)
                leftAxis.labelCount = 8
                leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
                leftAxis.labelPosition = .outsideChart
                leftAxis.spaceTop = 0.15
                leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
                
//                let rightAxis = barView.rightAxis
//                rightAxis.enabled = true
//                rightAxis.labelFont = .systemFont(ofSize: 10)
//                rightAxis.labelCount = 8
//                rightAxis.valueFormatter = leftAxis.valueFormatter
//                rightAxis.spaceTop = 0.15
//                rightAxis.axisMinimum = 0
                
                let l = barView.legend
                l.horizontalAlignment = .left
                l.verticalAlignment = .bottom
                l.orientation = .horizontal
                l.drawInside = false
                l.form = .circle
                l.formSize = 9
                l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
                l.xEntrySpace = 4
        //        barView.legend = l

                let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                          font: .systemFont(ofSize: 12),
                                          textColor: .white,
                                          insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                          xAxisValueFormatter: barView.xAxis.valueFormatter!)
                marker.chartView = barView
                marker.minimumSize = CGSize(width: 80, height: 40)
                barView.marker = marker
        
        self.setDataCount(12, range: UInt32(1400))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
            let start = 1
            
            let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
                let mult = range + 1
                let val = Double(arc4random_uniform(mult))
                if arc4random_uniform(100) < 25 {
                    return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
                } else {
                    return BarChartDataEntry(x: Double(i), y: val)
                }
            }
            
            var set1: BarChartDataSet! = nil
            if let set = barView.data?.dataSets.first as? BarChartDataSet {
                set1 = set
                set1.replaceEntries(yVals)
                barView.data?.notifyDataChanged()
                barView.notifyDataSetChanged()
            } else {
                set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
                set1.colors = ChartColorTemplates.material()
                set1.drawValuesEnabled = false
                
                let data = BarChartData(dataSet: set1)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.9
                barView.data = data
            }
            
    //        chartView.setNeedsDisplay()
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

extension BarChartViewController: ChartViewDelegate  {
    func setup(barLineChartView barView: BarLineChartViewBase) {
        barView.chartDescription?.enabled = false
                
        barView.dragEnabled = true
        barView.setScaleEnabled(true)
        barView.pinchZoomEnabled = false
        
        // ChartYAxis *leftAxis = barView.leftAxis;
        
        let xAxis = barView.xAxis
        xAxis.labelPosition = .bottom
        
        barView.rightAxis.enabled = false
    }
}
