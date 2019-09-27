//
//  PostsViewController.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa
import RxDataSources


final class PostsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    
    private var viewModel: PostListViewModel
    private let spinnerView = Bundle.main.loadNibNamed("\(SpinnerView.self)", owner: self, options: nil)?.first as? SpinnerView
    private let disposeBag = DisposeBag()
    
    init(withViewModel viewModel: PostListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"

        setupTableView()
        bindViewWithViewModel()
        
        viewModel.fetchData()
    
    }
    
    // MARK: - Private functions

    private func setupTableView() {
        registerTableViewCell()
        setupTableViewDelegate()
        titleForHeaderInSection()
        setupTableViewCellConfiguration()
        setupTableViewCellTapHandling()
        
    }

}

// extenstion to setup tableview for rx
extension PostsViewController {
    
    private func bindViewWithViewModel() {
        viewModel.isLoading.asObservable().subscribe(onNext: { [weak self] (loading) in
            if let strongSelf = self {
                if loading {
                    strongSelf.spinnerView?.showSpinner(inVeiw: strongSelf.view, withInformation: "Data is loading, please wait...")
                } else {
                    strongSelf.spinnerView?.hideSpinner()
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.showError.asObservable().subscribe(onNext: { [weak self] (error) in
            if let _ = error {
                self?.showError(error!, completionHandler: nil)
            }
        }).disposed(by: disposeBag)
    }
    
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
    
    private func setupTableViewCellConfiguration() {
        _ = viewModel.allUserSection
                .asObservable()
                .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
                .disposed(by: disposeBag)
    }
    
    private func titleForHeaderInSection() {
        viewModel.dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
    }
    
    private func setupTableViewCellTapHandling() {
        tableView
            .rx
            .modelSelected(Post.self)
            .subscribe(onNext: { [unowned self] post in
                
                self.navigationController?.pushViewController(PostDetailViewController(withPost: post, viewModel: PostDetailViewModel(allComments: BehaviorRelay<[Comment]>(value: []))), animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension PostsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let user = viewModel.fetchRequestController?.fetchedObjects?[section] else {
            return nil
        }
        let headerView = sectionHeaderView()
        headerView.text = user.username
        return headerView
    }
    

    //Mark: - Private method

    private func sectionHeaderView() -> UILabel {
        let headerView = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: tableView.frame.width, height: 35)))
        headerView.textColor = .white
        headerView.font = .boldSystemFont(ofSize: 20)
        headerView.backgroundColor = .gray
        return headerView
    }
}
