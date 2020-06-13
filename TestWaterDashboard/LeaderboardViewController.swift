//
//  LeaderboardViewController.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/10/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var leaderBoard: [Leaderboard] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    
    func fetchData() {
        Request.fetchLeaderboard.execute(success: { [weak self] (res, data: [Leaderboard]) in
            DataManager.shared.leaderBoard = data
            self?.leaderBoard = DataManager.shared.leaderBoard.sorted { $0.score > $1.score }
            self?.tableView.reloadData()
        }, failure: { (error) in
            print(error)
        })
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

extension LeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoard.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memberScoreDetail = leaderBoard[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! LeaderboardCell
        cell.nameLabel.text = memberScoreDetail.name
        cell.usernameLabel.text = memberScoreDetail.username
        cell.pointsLabel.text = "\(memberScoreDetail.score)"
        cell.imageView?.image = cell.generateImageWithText(text: "\(memberScoreDetail.name.first ?? Character(""))")
        return cell
    }
}
