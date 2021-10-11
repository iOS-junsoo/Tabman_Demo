//
//  ViewController.swift
//  Tabman_Demo
//
//  Created by 준수김 on 2021/10/11.
//

import UIKit
import Tabman
import Pageboy

class ViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    let titleData: [String] = ["총 확진자 수", "전일 대비 증감수", "사망자 수"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        let vc3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController3") as! ViewController3
        let vc4 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController4") as! ViewController4
        
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
        
        bar.backgroundView.style = .blur(style: .regular) //bar 배경스타일 변경
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0) //bar item 위치변경
        bar.buttons.customize { (button) in
            button.tintColor = .white
            button.selectedTintColor = .black
        }// 버튼 색 변경
        bar.indicator.weight = .heavy //인디케이터 굵기
        bar.indicator.tintColor = .red //인디케이터 색
        bar.indicator.overscrollBehavior = .compress //오버스크롤 스타일 
        
    }
}

extension ViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = titleData[index]
        item.image = UIImage(named: "page")
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        item.badgeValue = "New" //벳지추가
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
