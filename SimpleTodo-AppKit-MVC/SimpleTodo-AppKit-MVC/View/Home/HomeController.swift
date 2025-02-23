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

    var subjectListController = SubjectListController()
    var todoListController = TodoListController()
    var todoDetailController = TodoDetailController()

    var repository: Repository!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRepository()
        setupSplitView()


        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    private func setupRepository() {
        repository = Repository()
        repository.load()
    }

    private func setupSplitView() {
        do {
            subjectListController.homeControllerDelegate = self
            subjectListController.repository = repository
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: subjectListController)
            splitViewItem.canCollapse = false
            splitViewItem.minimumThickness = 200
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
    }

}

extension HomeController: HomeControllerDelegate {

}
