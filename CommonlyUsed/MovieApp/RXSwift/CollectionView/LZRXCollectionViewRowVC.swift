//
//  LZRXCollectionViewVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/26.
//

import UIKit
import RxSwift

class LZRXCollectionViewRowVC: LZBaseVC {
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT),collectionViewLayout: layout).then {
        $0.backgroundColor = .white
        $0.register(LZRXCollectionCell.self, forCellWithReuseIdentifier: "LZRXCollectionCell")
        $0.delegate=self
        $0.showsVerticalScrollIndicator = false
        
        // 点击事件
        $0.rx.itemSelected.map {[weak self] (indexPath) in
            return (indexPath,self!.dataSource[indexPath.row])
        }.subscribe(onNext:{(indexPath,info) in
            ToastView.instance.showToast(content: "点击了\(indexPath.row)==>>\(info)")
        }).disposed(by: disposeBag)
        
        
        //绑定滚动
        $0.rx.contentOffset.map { (point)  in
            // 一般使用纵轴偏移量的多一些
            //return point.y
            let tempOffsetY = abs(point.y)+40
            //根据偏移量 计算颜色值
            let bgColor = UIColor.RGB(r: Int((tempOffsetY/300)*1.0*255), g: Int((tempOffsetY/200)*1.0*255), b: Int((tempOffsetY/100)*1.0*255))
            return bgColor!
        }.bind(to: customTabbar.rx.backgroundColor).disposed(by: disposeBag)
        self.view.addSubview($0)
    }
    
    //数据
    private var dataSource:[String]=["1","2","3","4","5","6","7","8","9","10"]
    //管道
    private var response:BehaviorSubject<[String]> = BehaviorSubject(value: []).asObserver()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo = "tableView-row"
        setup()
    }
    private func setup()  {
        
        //绑定数据
        response.bind(to: collectionView.rx.items){(collectionView, row, element) in
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LZRXCollectionCell",
                                            for: indexPath) as! LZRXCollectionCell
            cell.textInfo.text=element
            cell.backgroundColor = .randomColor
            return cell
        }.disposed(by: disposeBag)
        
        response.onNext(dataSource)
    }
}


extension LZRXCollectionViewRowVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // 设置Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //此处的bug:横向像素可能除不尽,导致横向宽度加起来和大于屏幕宽度,造成横向排列错乱 :也可使用((ScreenW-20*PionWidth-10*PionWidth)/2).rounded() 可能精度差一点,不影响视觉
        let tempWidth=(ScreenW-20*PionWidth-10*PionWidth)/2
        return CGSize(width: tempWidth.rounded(), height: 170*PionHeight)
        
        
        //let tempWidth=(ScreenW-20*PionWidth#imageLiteral(resourceName: "simulator_screenshot_8293B9B1-CF3E-4C56-8F69-016EE564E68C.png")-10*PionWidth)/2
        //if indexPath.row % 2 == 0{
        //    return CGSize(width: ScreenW-20*PionWidth-10*PionWidth-(tempWidth), height: 170*PionHeight)
        //}else{
        //    return CGSize(width: tempWidth, height: 170*PionHeight)
        //}
    }
    
    //竖向滚动表示:行cell之间的间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*PionWidth
    }
    
    //竖向滚动表示:行cell之间的列间距 注意:和Cell设置大小时的冲突,一般使用设置Cell 大小就行了。特殊应用场景,在cell自适应大小的时候使用
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0*PionWidth
    }
    
    //foot的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width:0 , height: 0*PionHeight)
    }
    
    //header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenW-20*PionWidth, height: 10*PionHeight)
    }
    
}

class LZRXCollectionCell: UICollectionViewCell {
    
    lazy var textInfo = UILabel().then {
        $0.font=UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.RGB(r: 10, g: 10, b: 10)
        $0.textAlignment = .center
        self.addSubview($0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textInfo.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
