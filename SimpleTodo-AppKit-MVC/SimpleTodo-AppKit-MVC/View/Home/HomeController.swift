//
//  HomeController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import AppKit

protocol HomeControllerDelegate: AnyObject {

}

class HomeController: NSSplitViewController {

    let padding = 20.0

    var subjectListController = SubjectListController()
    var todoListController = TodoListController()
    var todoDetailController = TodoDetailController()

    // loadView() 를 오버라이드해도 되는 경우가 있지만
    // NSSplitViewController 의 경우 이런 저런 사전작업을 하는 것 같다.
    // loadView() 를 처음부터 만드는 대신 viewDidLoad() 를 쓰기로 한다.

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            subjectListController.homeControllerDelegate = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: subjectListController)
            splitViewItem.canCollapse = false
            addSplitViewItem(splitViewItem)
        }

        do {
            todoListController.homeControllerDelegate = self
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: todoListController)
            splitViewItem.canCollapse = false
            addSplitViewItem(splitViewItem)
        }

        do {
            todoDetailController.homeControllerDelegate = self
            let splitViewItem = NSSplitViewItem(viewController: todoDetailController)
            addSplitViewItem(splitViewItem)
        }

        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

}

extension HomeController: HomeControllerDelegate {

}
