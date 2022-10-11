//
//  HomeViewController.swift
//  WanAndroidSwift
//  
//  Created by CoderSamz on 2022.
// 	
// 
    

import UIKit
import SwifterSwift
import Alamofire
import SwiftyJSON
import SVProgressHUD
import LLCycleScrollView
import MJRefresh

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var bannerView: LLCycleScrollView!
    var currentPage = 0
    var bannerList = [JSON]()
    
    var homeData = [HomeModel]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "首页"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        tableView.tableFooterView = UIView() // 去除tableView空白时的分隔线
        weak var weakSelf = self
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            weakSelf?.currentPage += 1
            weakSelf?.fetchData(with: weakSelf?.currentPage ?? 0)
        })
        // fetchData
        fetchData()
        bannerView = tableView.tableHeaderView! as? LLCycleScrollView
        bannerView.delegate = self
        fetchBannerUrls()
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
//        view.backgroundColor = UIColor.random
    }
    
    func fetchBannerUrls() {
        AF.request("https://www.wanandroid.com/banner/json", method: .get, parameters: nil).responseData(completionHandler: { response in

            switch response.result {
                case let .success(value):
                    

                    self.bannerList = JSON(value)["data"].arrayValue
                    var urls = [String]()
                    for item in self.bannerList {
                        urls.append(item["imagePath"].stringValue)
                    }
                    self.bannerView.imagePaths = urls

                case let .failure(error):
                    print(error)
            }
            
        })
    }
    
    func fetchData(with page: Int = 0) {
        SVProgressHUD.show(withStatus: "loading")
        print("https://www.wanandroid.com/article/list/\(page)/json")
        AF.request("https://www.wanandroid.com/article/list/\(page)/json", method: .get, parameters: nil).responseData(completionHandler: { response in

            switch response.result {
                case let .success(value):
                    
//                    debugPrint(JSON(value)["data"]["datas"])
                    
                    let data = JSON(value)["data"]["datas"].arrayValue
                    for item in data {
                        let model = HomeModel(
                            shareUser: item["shareUser"].stringValue,
                            title: item["title"].stringValue,
                            link: item["link"].stringValue,
                            publishTime: item["publishTime"].intValue,
                            niceDate: item["niceDate"].stringValue,
                            author: item["author"].stringValue
                        )
                        self.homeData.append(model)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        SVProgressHUD.dismiss()
                        self.tableView.mj_footer?.endRefreshing()
                    }
                case let .failure(error):
                    print(error)
            }
            
        })
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        let model = homeData[indexPath.row]
        cell.updateUI(model: model)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = homeData[indexPath.row]

        let webVC = WebViewController()
        webVC.requestURL = model.link
        self.parent?.navigationController?.pushViewController(webVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController: LLCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: LLCycleScrollView, didSelectItemIndex index: NSInteger) {
        let model = bannerList[index]

        let webVC = WebViewController()
        webVC.requestURL = model["url"].stringValue
        self.parent?.navigationController?.pushViewController(webVC, animated: true)

    }
}
