//
//  HomeListVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/24.
//

import UIKit

class HomeListVC: LZBaseVC {
    
    var navigator:UINavigationController?
    
    
    private lazy var collectionLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    private lazy var collectionView = UICollectionView(frame: CGRect(x: 10*PionWidth, y: 0, width: ScreenW-20*PionWidth, height: ScreenH - (STATUSBAR_HEIGHT+40*PionHeight+46*PionHeight)), collectionViewLayout: collectionLayout).then {
        $0.backgroundColor = UIColor.RGB(r: 240, g: 240, b: 240)
        $0.isScrollEnabled = true
        $0.delegate=self
        $0.dataSource=self
        $0.showsVerticalScrollIndicator = false
        $0.register(LZHomeListViewCell.self, forCellWithReuseIdentifier: "LZHomeListViewCell")
        
        $0.mj_header=URefreshHeader(refreshingBlock: {[weak self] in
            self?.beiginRequest(withRefush: true)
        })
        $0.mj_footer=URefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            self?.beiginRequest(withRefush: false)
        })
    }
    
    var sortId:String = "1"
    
    private var listVideos:[LZListVideoM] = [LZListVideoM]()
    private var page:Int=1
    private var size:Int=20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup()  {
        
        for item in [1,2,3,4,5,6,7,8,9] {
            var vmodel = LZListVideoM()
            vmodel.name="哈哈哈\(item)"
            vmodel.sortId="\(item)"
            vmodel.videoUrl=""
            vmodel.viewCount="\(120+item)"
            vmodel.imageUrl="https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3014660954,742786405&fm=26&gp=0.jpg"
            listVideos.append(vmodel)
        }
        self.view.backgroundColor = UIColor.RGB(r: 240, g: 240, b: 240)
        self.view.addSubview(collectionView)
        collectionView.reloadData()
        beiginRequest(withRefush: true)
        hiddenTopBar=true
        
    }
    
    private func beiginRequest(withRefush refush:Bool)  {
        var params:Dictionary<String,Any> = Dictionary<String,String>()
        page = refush ? 1 : page+1
        params["page"] = page
        params["size"] = size
        LZRequestManager.homeApi.getResponse(target: .getHomeListInfo(params)).subscribe {[weak self] (data) in
            if refush{
//                self?.listVideos.removeAll()
                self?.refush()
            }else{
                self?.loadMore()
            }
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension HomeListVC{
    private func refush()  {
        collectionView.mj_header?.endRefreshing()
    }
    
    private func loadMore()  {
        collectionView.mj_footer?.endRefreshing()
        if listVideos.count < page*size{
            collectionView.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}

extension HomeListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVideos.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LZHomeListViewCell=collectionView.dequeueReusableCell(withReuseIdentifier: "LZHomeListViewCell", for: indexPath) as! LZHomeListViewCell
        let tempModel = listVideos[indexPath.row]
        cell.updateInfo(withIcons: tempModel.imageUrl, withNames: tempModel.name, withViewCount: tempModel.viewCount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigator?.pushViewController(LZVideoDetailVC(), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tempWidth=(ScreenW-20*PionWidth-10*PionWidth)/2
        
        if indexPath.row % 2 == 0{
            return CGSize(width: ScreenW-20*PionWidth-10*PionWidth-(tempWidth), height: 170*PionHeight)
        }else{
            return CGSize(width: tempWidth, height: 170*PionHeight)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0*PionWidth
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0*PionWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width:0 , height: 0*PionHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenW-20*PionWidth, height: 10*PionHeight)
        
    }
}
