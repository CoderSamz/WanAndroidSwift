//
//  LabViewController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit
import SnapKit

class LabViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero)
    let categies = ["动画Animation", "蓝牙Core Bluetooth"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LabCell")
        tableView.tableFooterView = UIView() // 消除tableView底部多余横线
        updateUI()
    }
    
    func updateUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

// MARK: - UITablViewDatasource
extension LabViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabCell", for: indexPath)
        cell.textLabel?.text = categies[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension LabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 1:
                let bluetoothVC = BluetoothViewController(nibName: "BluetoothViewController", bundle: nil)
                self.parent?.navigationController?.pushViewController(bluetoothVC, animated: true)
                
            default:
                break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


