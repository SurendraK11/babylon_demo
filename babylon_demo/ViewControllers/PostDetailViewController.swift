//
//  PostDetailViewController.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PostDetailViewController: UIViewController {
    @IBOutlet private var postTitle: UILabel!
    @IBOutlet private var author: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    private let post: Post
    private let viewModel: PostDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(withPost post: Post, viewModel: PostDetailViewModel) {
        self.post = post
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // just to make sure no issues in releasing of view controller
        debugPrint("deinit - PostDetailViewController")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Detail"
        
        registerTableViewCell()
        setupTableViewDelegate()
        bindViewWithViewModel()
        viewModel.allComments.accept(post.comments.allObjects as! [Comment])
    }
    
}

extension PostDetailViewController {
    private func registerTableViewCell() {
        let contentTableViewCellNib: UINib = UINib(nibName: "\(ContentTableViewCell.self)", bundle: nil)
        tableView.register(contentTableViewCellNib, forCellReuseIdentifier: "\(ContentTableViewCell.self)")
    }
    
    private func setupTableViewDelegate() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
    }
    
    private func bindViewWithViewModel() {
        viewModel.allComments
            .asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "\(ContentTableViewCell.self)",
                    cellType: ContentTableViewCell.self)) { row, comment, cell in
                        cell.contentView.backgroundColor = (row % 2 == 0) ? .white : UIConstants.ColorConstant.whitishGrayColor
                        cell.setup(usingViewModel: ContentCellViewModel(title: comment.body))
            }
            .disposed(by: disposeBag)
        
        
        viewModel.allComments
            .asObservable()
            .subscribe { [weak self] (_) in
                self?.author.text = self?.post.auther.username
                self?.postTitle.text = self?.post.title
            }.disposed(by: disposeBag)
        
    }
    
}

extension PostDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
