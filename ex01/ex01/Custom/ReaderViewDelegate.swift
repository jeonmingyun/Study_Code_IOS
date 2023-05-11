//
//  ReaderViewDelegate.swift
//  ex01
//
//  Created by jjglobal on 2023/04/24.
//
enum ReaderStatus {
    case success(_ code: String?)
    case fail
    case stop(_ isButtonTap: Bool)
}

protocol ReaderViewDelegate: AnyObject {
    func readerComplete(status: ReaderStatus)
}
