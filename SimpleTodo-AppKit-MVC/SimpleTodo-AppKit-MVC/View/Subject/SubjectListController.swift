//
//  SubjectListController.swift
//  SimpleTodo-AppKit-MVC
//
//  Created by Kyuhyun Park on 2/18/25.
//

import Cocoa

class SubjectListController: NSViewController {

    let scrollView = NSScrollView()
    let tableView = NSTableView()

    var repository: Repository!
    var homeControllerDelegate: HomeControllerDelegate!

    var items: [Subject] {
        return repository.subjects
    }

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupScrollView()
        setupTable()
        setupFields()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.hasVerticalScroller = true

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupTable() {
        scrollView.documentView = tableView

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.usesAutomaticRowHeights = true
        tableView.selectionHighlightStyle = .regular
        tableView.allowsMultipleSelection = true
        tableView.headerView = nil

        tableView.dataSource = self
        tableView.delegate = self

        let titleColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("title"))
        titleColumn.title = "Title"
//        titleColumn.width = 180
        tableView.addTableColumn(titleColumn)
    }

    private func setupFields() {
        let addButton = NSButton(title: "Add Row", target: self, action: #selector(addRow))
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)

        let deleteButton = NSButton(title: "Delete Row", target: self, action: #selector(deleteSelectedRows))
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            deleteButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 8),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    override func keyDown(with event: NSEvent) {

        // specialKey 는 macOS 13, 2022 이상에서만 지원한다고 한다.
        // 구 버전을 지원하려면 keyCode 를 써야하는데 버추얼키 정의 테이블이 없어서 숫자를 외워야 한다.

        switch event.specialKey {
        case .delete:
            deleteSelectedRows()
        default:
            super.keyDown(with: event)
        }
    }

    @objc func addRow() {
        repository.addNewSubject(withTitle: "New Subject")
        tableView.reloadData()
    }

    @objc func deleteSelectedRows() {
        let selectedRows = tableView.selectedRowIndexes
        guard !selectedRows.isEmpty else { return }

        let sortedIndexes = selectedRows.sorted(by: >)

        for index in sortedIndexes {
            repository.removeSubject(at: index)
        }

        tableView.removeRows(at: selectedRows, withAnimation: .effectFade)
    }

}

extension SubjectListController: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }

}

extension SubjectListController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let id = tableColumn!.identifier
        let cell: NSTableCellView

        if let cachedCell = tableView.makeView(withIdentifier: id, owner: self) as? NSTableCellView {
            cell = cachedCell
        } else {
            cell = NSTableCellView()
            cell.identifier = id

            let textField = NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isEditable = true
            textField.isBordered = false
            textField.drawsBackground = false
            textField.delegate = self // 필드 편집된 후 노티를 받으려면.

            cell.addSubview(textField)
            cell.textField = textField

            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
                textField.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            ])
        }

        let subject = items[row]

        switch id.rawValue {
        case "title":
            cell.textField?.stringValue = subject.title
        default:
            break
        }

        return cell
    }

}

extension SubjectListController: NSTextFieldDelegate {

    func controlTextDidBeginEditing(_ notification: Notification) {
        guard let textField = notification.object as? NSTextField else { return }
        textField.drawsBackground = true
    }

    func controlTextDidEndEditing(_ notification: Notification) {
        guard let textField = notification.object as? NSTextField else { return }

        let row = tableView.row(for: textField)
        let column = tableView.column(for: textField)

        // 마지막 row 가 편집중인 상태에서 삭제될 수 있다.
        // 해서 row 의 items.count 범위를 확인해야 한다.
        guard 0..<items.count ~= row, column >= 0 else { return }

        let columnID = tableView.tableColumns[column].identifier

        // Update cell

        switch columnID.rawValue {
        case "title":
            var subject = repository.subjects[row]
            subject.title = textField.stringValue
            repository.updateSubject(at: row, subject: subject)
        default:
            break
        }
        tableView.reloadData(forRowIndexes: IndexSet(integer: row), columnIndexes: IndexSet(integer: column))

        // Restore color

        textField.drawsBackground = false

        // Select next cell

        guard
            let textMovementInt = notification.userInfo?["NSTextMovement"] as? Int,
            let textMovement = NSTextMovement(rawValue: textMovementInt) else { return }

        var nextRow = row
        var nextColumn = column

        switch textMovement {
        case .tab, .return:
            nextColumn += 1
            if nextColumn >= tableView.numberOfColumns {
                nextRow += 1
                nextColumn = 0
                if nextRow == items.count {
                    addRow()
                }
            }
        case .backtab:
            nextColumn -= 1
            if nextColumn < 0 {
                nextRow -= 1
                nextColumn = tableView.numberOfColumns - 1
                if nextRow < 0 {
                    nextRow = items.count - 1
                }
            }
        default:
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableView.selectRowIndexes(IndexSet(integer: nextRow), byExtendingSelection: false)
            self?.tableView.editColumn(nextColumn, row: nextRow, with: nil, select: true)
        }
    }

}
