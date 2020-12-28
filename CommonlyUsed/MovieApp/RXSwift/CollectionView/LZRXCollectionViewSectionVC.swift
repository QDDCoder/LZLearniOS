//
//  LZRXCollectionViewSectionVC.swift
//  MovieApp
//
//  Created by 湛亚磊 on 2020/12/26.
//

import UIKit
import RxSwift
import RxDataSources
class LZRXCollectionViewSectionVC: LZBaseVC {
    
    
    // https://blog.csdn.net/qin_shi/article/details/80258693 待整理地址
    
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: CGRect(x: 10*PionWidth, y: NAVBAR_HEIGHT, width: ScreenW-20*PionWidth, height: ScreenH-NAVBAR_HEIGHT),collectionViewLayout: layout).then {
        $0.backgroundColor = .white
        $0.register(LZRXCollectionCell.self, forCellWithReuseIdentifier: "LZRXCollectionCell")
        $0.register(RXSwiftCollectionHeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerViewId")
        //高度代理
        $0.delegate=self
        
        //拖动使用
        $0.dropDelegate=self
        $0.dragDelegate=self
        //开启可拖动
        $0.dragInteractionEnabled = true
        //弹簧加载是一种导航和激活控件的方式，在整个系统中，当处于 dragSession 的时候，只要悬浮在cell上面，就会高亮，然后就会激活
        $0.isSpringLoaded=true
        //重排序节奏）可以调节集合视图重排序的响应性。 是 CollectionView 独有的属性（相对于UITableView），因为 其独有的二维网格的布局，因此在重新排序的过程中有时候会发生元素回流了，有时候只是移动到别的位置，不想要这样的效果，就可以修改这个属性改变其相应性
        $0.reorderingCadence = .slow
        
        
        //隐藏纵向滑动线
        $0.showsVerticalScrollIndicator = false
        
        //系统自动调整scrollView.contentInset保证滚动视图不被tabbar,navigationbar遮挡
        $0.contentInsetAdjustmentBehavior = .scrollableAxes
        
        // 点击事件
        $0.rx.itemSelected.map {[weak self] (indexPath) in
            return (indexPath,self!.dataSource[indexPath])
        }.subscribe(onNext:{(index,model) in
            ToastView.instance.showToast(content: "点击了===>>>\(index.section)===>>>\(model.name)")
        }).disposed(by: disposeBag)
        self.view.addSubview($0)
    }
    
    
    //设置数据绑定的中间件
    private var dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String,HomeCategoryModel>> { (_, collectionView, indexPath, item) -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LZRXCollectionCell", for: indexPath) as! LZRXCollectionCell
        cell.textInfo.text=item.name
        cell.backgroundColor = .randomColor
        cell.dragStateDidChange(.lifting)
        return cell
    }.then {
        // 设置sectionHeader
        $0.configureSupplementaryView={(model, collection, info, indexPath) -> UICollectionReusableView in
            let header = collection.dequeueReusableSupplementaryView(ofKind: info, withReuseIdentifier: "headerViewId", for: indexPath) as! RXSwiftCollectionHeadView
            header.titleLabel.text=model.sectionModels[indexPath.section].model
            header.backgroundColor = .randomColor
            return header
        }
        
        //设置可移动
        $0.canMoveItemAtIndexPath={(dataSourceIn,indexPath) -> Bool in
            return true
        }
    }

    //创造数据
    private var response:BehaviorSubject<[SectionModel<String, HomeCategoryModel>]>?
    private var dataModel=[SectionModel(model: "我的频道", items:
        [
            HomeCategoryModel(withName: "关注", withJump: UIViewController.self),
            HomeCategoryModel(withName: "推荐", withJump: UIViewController.self),
            HomeCategoryModel(withName: "视频", withJump: UIViewController.self),
            HomeCategoryModel(withName: "热点", withJump: UIViewController.self),
            HomeCategoryModel(withName: "北京", withJump: UIViewController.self),
            HomeCategoryModel(withName: "新时代", withJump: UIViewController.self),
            HomeCategoryModel(withName: "图片", withJump: UIViewController.self),
            HomeCategoryModel(withName: "头条号", withJump: UIViewController.self),
            HomeCategoryModel(withName: "娱乐", withJump: UIViewController.self),
            HomeCategoryModel(withName: "问答", withJump: UIViewController.self),
            HomeCategoryModel(withName: "体育", withJump: UIViewController.self),
            HomeCategoryModel(withName: "科技", withJump: UIViewController.self),
            HomeCategoryModel(withName: "懂车帝", withJump: UIViewController.self),
            HomeCategoryModel(withName: "财经", withJump: UIViewController.self),
            HomeCategoryModel(withName: "军事", withJump: UIViewController.self),
            HomeCategoryModel(withName: "国际", withJump: UIViewController.self),
        ]),
        SectionModel(model: "频道推荐", items:
        [
            HomeCategoryModel(withName: "健康", withJump: UIViewController.self),
            HomeCategoryModel(withName: "冬奥", withJump: UIViewController.self),
            HomeCategoryModel(withName: "特产", withJump: UIViewController.self),
            HomeCategoryModel(withName: "房产", withJump: UIViewController.self),
            HomeCategoryModel(withName: "小说", withJump: UIViewController.self),
            HomeCategoryModel(withName: "时尚", withJump: UIViewController.self),
            HomeCategoryModel(withName: "历史", withJump: UIViewController.self),
            HomeCategoryModel(withName: "育儿", withJump: UIViewController.self),
            HomeCategoryModel(withName: "直播", withJump: UIViewController.self),
            HomeCategoryModel(withName: "搞笑", withJump: UIViewController.self),
            HomeCategoryModel(withName: "数码", withJump: UIViewController.self),
            HomeCategoryModel(withName: "美食", withJump: UIViewController.self),
            HomeCategoryModel(withName: "养生", withJump: UIViewController.self),
            HomeCategoryModel(withName: "电影", withJump: UIViewController.self),
            HomeCategoryModel(withName: "手机", withJump: UIViewController.self),
            HomeCategoryModel(withName: "旅游", withJump: UIViewController.self),
            HomeCategoryModel(withName: "宠物", withJump: UIViewController.self),
            HomeCategoryModel(withName: "情感", withJump: UIViewController.self),
        ]
    )]
    
    private var dragingIndexPath:IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInfo = "tableView-section"
        setData()
    }
    private func setData()  {
        //创造数据
        response = BehaviorSubject(value:dataModel)
        
        //绑定数据
        response!.asObserver().bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }

    
}
extension LZRXCollectionViewSectionVC: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    

    // 设置Cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = dataModel[indexPath.section].items[indexPath.row].name.ga_widthForComment(fontSize: 14, height: 20*PionHeight)
        return CGSize(width: width+20*PionWidth, height: 30*PionHeight)
    }
    
    //竖向滚动表示:行cell之间的间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10*PionWidth
    }
    
    //竖向滚动表示:行cell之间的列间距 注意:和Cell设置大小时的冲突,一般使用设置Cell 大小就行了。特殊应用场景,在cell自适应大小的时候使用
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10*PionWidth
    }
    
    //foot的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width:0 , height: 0*PionHeight)
    }
    
    //header的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenW-20*PionWidth, height: 40*PionHeight)
    }
}
// cell 拖动
extension LZRXCollectionViewSectionVC:UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        // 交换目标indexPath
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        switch coordinator.proposal.operation {
        case .move:
            let items = coordinator.items
            // 交换的发起item和indexPath
            if let item = items.first, let sourceIndexPath = item.sourceIndexPath {
                //执行批量更新
                collectionView.performBatchUpdates({
                    let tempItemp = self.dataModel[destinationIndexPath.section].items[sourceIndexPath.row]
                    self.dataModel[destinationIndexPath.section].items.remove(at: sourceIndexPath.row)
                    self.dataModel[destinationIndexPath.section].items.insert(tempItemp, at: destinationIndexPath.row)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                    response?.onNext(dataModel)
                })
                //将项目动画化到视图层次结构中的任意位置
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            break
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if dragingIndexPath?.section != destinationIndexPath?.section {
            return UICollectionViewDropProposal(operation: .forbidden)
        }else{
            if session.localDragSession != nil {
                if collectionView.hasActiveDrag {
                    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                } else {
                    return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
                }
            } else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
    }
}

extension LZRXCollectionViewSectionVC:UICollectionViewDragDelegate{
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard indexPath.section != 1 else {
            return []
        }
        let item = self.dataModel[indexPath.section].items[indexPath.row].name
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        //开始拖动 的indexPath
        dragingIndexPath = indexPath
        return [dragItem]
    }
}



//头部
class RXSwiftCollectionHeadView: UICollectionReusableView{
    lazy var titleLabel = UILabel().then {
        $0.textColor = UIColor.RGB(r: 10, g: 10, b: 10)
        $0.font=UIFont.systemFont(ofSize: 28)
        $0.textAlignment = .center
        self.addSubview($0)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
