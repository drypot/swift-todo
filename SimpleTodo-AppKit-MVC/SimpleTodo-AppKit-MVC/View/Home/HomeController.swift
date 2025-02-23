//
//  HomeController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/17/25.
//

import AppKit

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
            subjectListController.homeController = self
            subjectListController.repository = repository
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: subjectListController)
            splitViewItem.canCollapse = false
            splitViewItem.minimumThickness = 200
            addSplitViewItem(splitViewItem)
        }

        do {
            todoListController.homeController = self
            todoListController.repository = repository
            let splitViewItem = NSSplitViewItem(sidebarWithViewController: todoListController)
            splitViewItem.canCollapse = false
            splitViewItem.minimumThickness = 200
            addSplitViewItem(splitViewItem)
        }

        do {
            todoDetailController.homeController = self
            todoDetailController.repository = repository
            let splitViewItem = NSSplitViewItem(viewController: todoDetailController)
            splitViewItem.canCollapse = false
            splitViewItem.minimumThickness = 400
            addSplitViewItem(splitViewItem)
        }
    }

}

protocol HomeControllerProtocol: AnyObject {
    func reloadTodoList()
    func reloadTodoDetail()
}

extension HomeController: HomeControllerProtocol {

    func reloadTodoList() {
        todoListController.reloadData()
    }

    func reloadTodoDetail() {
        todoDetailController.reloadData()
    }
}
