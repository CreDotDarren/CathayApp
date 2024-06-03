//
//  HomePage.swift
//  CathayTestApp
//
//  Created by 李竺霖 on 2024/5/27.
//

import Foundation
import UIKit


class HomePage: UIViewController {
    @IBOutlet weak var homeScrollView: UIScrollView!
    @IBOutlet weak var bellBtn: UIButton!
    
    @IBOutlet weak var savingBtn: UIButton!
    @IBOutlet weak var fixedBtn: UIButton!
    @IBOutlet weak var digitalBtn: UIButton!
    
    @IBOutlet weak var functionCollection: UICollectionView!
    @IBOutlet weak var favoriteCollection: UICollectionView!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var usdBgView: UIView!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var khrBgView: UIView!
    @IBOutlet weak var khrLabel: UILabel!
    @IBOutlet weak var adScrollView: UIScrollView!
    @IBOutlet weak var adPageControl: UIPageControl!
    
    var refreshControl:UIRefreshControl!
    
    var userTotalClick : Bool = false
    let privacyString = "********"
    
    var reloadTimer : Timer?
    var secondInt : Int = 600
    var checkTimer : Bool = true
    
    
    var functionArray = [["title":"Transfer",
                          "imageName":"button00ElementMenuTransfer.png"],
                         ["title":"Payment",
                          "imageName":"button00ElementMenuPayment.png"],
                         ["title":"Utility",
                          "imageName":"button00ElementMenuUtility.png"],
                         ["title":"QR pay scan",
                          "imageName":"button01Scan.png"],
                         ["title":"My QR code",
                          "imageName":"button00ElementMenuQRcode.png"],
                         ["title":"Top up",
                          "imageName":"button00ElementMenuTopUp.png"]]
    
    var homeViewModel = HomeViewModel()
    
    var messagesModel = [NotificationMessageModel]()
    var favoriteModel = [FavoriteModel]()
    
    var savingsAmountModel = [AmountModel]()
    var fixedAmountModel = [AmountModel]()
    var digitalAmountModel = [AmountModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        registerCell()
        settingRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtil.showTabBar(status: true)
        
        // 隱藏 NavigationBar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 恢復 NavigationBar 狀態，避免影響其他頁面
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func reloadData() {
        
        homeViewModel.startEmptyNotificationList { model in
            self.messagesModel = model.result.messages ?? []
            
            self.bellBtn.setImage(self.messagesModel.count == 0 ? UIImage(named: "iconBell01Nomal.png") : UIImage(named: "iconBell02Active.png"), for: .normal)
        }
        
        homeViewModel.startBannerList { model in
            
            model.result.bannerList?.enumerated().forEach({  index , bannerModel in
                
                let imageView = UIImageView(frame: CGRect(x: (self.adScrollView.frame.width)*CGFloat(index),
                                                          y: 0,
                                                          width: self.adScrollView.frame.width,
                                                          height: 88))
                imageView.downloaded(from: bannerModel.linkUrl)
                
                self.adScrollView.addSubview(imageView)
            })
            
            self.adScrollView.contentSize = CGSize(width: self.adScrollView.frame.width * CGFloat(model.result.bannerList?.count ?? 0),
                                                   height: 88)
            self.adPageControl.numberOfPages =  model.result.bannerList?.count ?? 0
            self.reloadTimer = Timer.scheduledTimer( timeInterval: 3,
                                                     target: self,
                                                     selector: #selector(self.reloadSecond(_:)),
                                                     userInfo: nil,
                                                     repeats: true)
        }
        
        homeViewModel.startFavoriteList {[weak self] model in
            self?.favoriteModel = model.result.favoriteList ?? []
            
            self?.favoriteCollection.reloadData()
        }
        
        homeViewModel.startUSDSavings1 { [weak self] model in
            self?.savingsAmountModel.append(contentsOf: model.result.savingsList ?? [])
            self?.homeViewModel.startKHRSavings1 { model in
                self?.savingsAmountModel.append(contentsOf: model.result.savingsList ?? [])
         
                self?.setAmountLabel(amountModel: self?.savingsAmountModel ?? [])
            }
        }
        
        homeViewModel.startUSDFixed1 {[weak self] model in
            self?.fixedAmountModel.append(contentsOf: model.result.fixedDepositList ?? [])
            self?.homeViewModel.startKHRFixed1 { model in
                self?.fixedAmountModel.append(contentsOf: model.result.fixedDepositList ?? [])
            }
        }
        
        homeViewModel.startUSDDigital1 {[weak self] model in
            self?.digitalAmountModel.append(contentsOf: model.result.digitalList ?? [])
            self?.homeViewModel.startKHRDigital1 { model in
                self?.digitalAmountModel.append(contentsOf: model.result.digitalList ?? [])
            }
        }
    }
    
    @objc func reloadSecond(_ time:Timer) -> Void {
        let pageSumIndex = adScrollView.contentSize.width / adScrollView.frame.width
        let pageNowIndex = adScrollView.contentOffset.x / adScrollView.frame.width
        
        if pageNowIndex == pageSumIndex - 1{
            adPageControl.currentPage = 0
            
            adScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        else {
            adPageControl.currentPage = Int(pageNowIndex+1)
            
            adScrollView.setContentOffset(CGPoint(x: self.adScrollView.frame.width*(pageNowIndex+1), y: 0)  , animated: true)
        }
    }
    
    /// 註冊Collection cell
    func registerCell() {
        functionCollection .register(UINib(nibName:"FunctionCell", bundle:nil), forCellWithReuseIdentifier: "FunctionCell")
        favoriteCollection.register(UINib(nibName:"FunctionCell", bundle:nil), forCellWithReuseIdentifier: "FunctionCell")
    }
    
    /// 設定scroll view 下拉更新 refreshControl
    func settingRefreshControl () {
        refreshControl = UIRefreshControl()
        homeScrollView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(updateData), for: UIControl.Event.valueChanged)
    }
    
    @objc func updateData(){
        
        homeViewModel.startNotificationList{[weak self] model in
            self?.refreshControl.endRefreshing()
            
            self?.messagesModel = model.result.messages ?? []
            
            self?.bellBtn.setImage(self?.messagesModel.count == 0 ? UIImage(named: "iconBell01Nomal.png") : UIImage(named: "iconBell02Active.png"), for: .normal)
        }
        
        savingsAmountModel.removeAll()
        fixedAmountModel.removeAll()
        digitalAmountModel.removeAll()
        
        homeViewModel.startUSDSavings2 {[weak self] model in
            self?.savingsAmountModel.append(contentsOf: model.result.savingsList ?? [])
            self?.homeViewModel.startKHRSavings2 { model in
                self?.savingsAmountModel.append(contentsOf: model.result.savingsList ?? [])
                
                self?.setAmountLabel(amountModel: self?.savingsAmountModel ?? [])

            }
        }
        
        homeViewModel.startUSDFixed2 {[weak self] model in
            self?.fixedAmountModel.append(contentsOf: model.result.fixedDepositList ?? [])
            self?.homeViewModel.startKHRFixed2 { model in
                self?.fixedAmountModel.append(contentsOf: model.result.fixedDepositList ?? [])
            }
        }
        
        homeViewModel.startUSDDigital2 {[weak self] model in
            self?.digitalAmountModel.append(contentsOf: model.result.digitalList ?? [])
            self?.homeViewModel.startKHRDigital2 { model in
                self?.digitalAmountModel.append(contentsOf: model.result.digitalList ?? [])
            }
        }
    }
    
    @IBAction func touchBtn(sender: UIButton) {
        if sender == privacyBtn {
            userTotalClick = !userTotalClick
            
            getUSD_KHRAssetsString()
        }
        else if sender == bellBtn {
            CommonUtil.showTabBar(status: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let page = storyboard.instantiateViewController(withIdentifier: "NotificationPage") as! NotificationPage
            page.messagesModel = messagesModel
            navigationController?.pushViewController(page, animated: true)
        }
        else if sender == savingBtn {
            setAmountLabel(amountModel: savingsAmountModel)
        }
        
        else if sender == fixedBtn {
            setAmountLabel(amountModel: fixedAmountModel)
        }
        
        else if sender == digitalBtn {
            setAmountLabel(amountModel: digitalAmountModel)
        }
    }
    /// 設定USD資料，加上撇節號
    func setAmountLabel(amountModel : [AmountModel]) {
        usdLabel.text =  CommonUtil.getGroupSeparatorForString(number: Double("\(amountModel.filter { $0.curr == "USD" }.first.map { $0.balance } ?? 0.0)") ?? 0.0)
        khrLabel.text =  CommonUtil.getGroupSeparatorForString(number: Double("\(amountModel.filter { $0.curr == "USD" }.first.map { $0.balance } ?? 0.0)") ?? 0.0)
    }
}

// MARK: -是否用********取代數字
extension HomePage {
    /// 是否開啟隱私模式 --- USD
    func getUSD_KHRAssetsString() {
        
        if userTotalClick {
            usdLabel.text =  privacyString
            khrLabel.text = privacyString
        }
        else {
            setAmountLabel(amountModel: savingsAmountModel)
        }
    }
}

// MARK: - UICollectionViewDelegate、UICollectionViewDataSource
extension HomePage:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FunctionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FunctionCell",for: indexPath)as! FunctionCell
        
        if collectionView == functionCollection {
            let indexData = functionArray[indexPath.row]
            
            cell.functionLabel.text = indexData["title"]
            cell.functionImg.image = UIImage(named: indexData["imageName"] ?? "")
        }
        else {
            let indexData = favoriteModel[indexPath.row]
            
            cell.functionLabel.text = indexData.nickname
            
            cell.functionImg.image = UIImage(named: indexData.favoriteType.getImageName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == functionCollection {
            
            return functionArray.count
        }
        else {
            return favoriteModel.count
        }
    }
}

// MARK: - UIScrollViewDelegate
extension HomePage : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        adPageControl.currentPage =  Int(adScrollView.contentOffset.x / adScrollView.frame.size.width)
    }
}
