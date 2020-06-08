//
//  ViewController.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/7/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }

    
    func fetchData() {
        Request.fetchWaterData.execute(success: { (res, data: WaterDataModel) in
            print(data.current)
            print(data.greenPoints)
            print(data.saving)
            print(data.quality)
            DataManager.shared.setData(data: data)
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error)
        })
    }
    
    
    @IBAction func chartsTap(_ sender: Any) {
        let alert = UIAlertController(title: "Select Chart", message: "", preferredStyle: .actionSheet)
        let pieAction = UIAlertAction(title: "Pie Charts", style: .default) { (_) in
            let pieController = self.storyboard?.instantiateViewController(identifier: "PieChartViewController") as! PieChartViewController
            self.navigationController?.show(pieController, sender: nil)
        }
        let barAction = UIAlertAction(title: "Bar Charts", style: .default) { (_) in
            let barController = self.storyboard?.instantiateViewController(identifier: "BarChartViewController") as! BarChartViewController
            self.navigationController?.show(barController, sender: nil)
        }
        let lineAction = UIAlertAction(title: "Line Charts", style: .default) { (_) in
            let lineController = self.storyboard?.instantiateViewController(identifier: "LineGraphViewController") as! LineGraphViewController
            self.navigationController?.show(lineController, sender: nil)
        }
        alert.addAction(pieAction)
        alert.addAction(barAction)
        alert.addAction(lineAction)
        self.present(alert, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.waterData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.waterData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = DataManager.shared.waterData[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "waterCell")!
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.detail
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let qualityTitle = section == 1 ? "Inflow Quality" : "Outflow Quality"
        return section == 0 ? "Data" : qualityTitle
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}
