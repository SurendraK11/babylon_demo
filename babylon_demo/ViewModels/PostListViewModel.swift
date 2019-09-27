//
//  PostListViewModel.swift
//  babylon_demo
//
//  Created by Surendra.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation
import CoreData
import RxRelay
import RxDataSources

class PostListViewModel {
    
    var isLoading = BehaviorRelay<Bool>(value: false)
    var showError = BehaviorRelay<Error?>(value: nil)
    var allUserSection =  BehaviorRelay<[SectionData]>(value: [])
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionData>(configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ContentTableViewCell.self)", for: indexPath) as! ContentTableViewCell
        cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? .white : UIConstants.ColorConstant.whitishGrayColor
        cell.setup(usingViewModel: ContentCellViewModel(title: item.title))
        return cell
    })
    
    var fetchRequestController: NSFetchedResultsController<User>?
    
    let dataLoader: DataLoading
    
    init(withDataLoader dataLoader: DataLoading) {
        self.dataLoader = dataLoader
    }
    
    func fetchData() {
        if AppUserDefaults().dataDownloaded {
            self.initializeFetchRequestController(withComplitionHandler: { (error) in
                guard (error == nil) else {
                    self.showError.accept(error!)
                    return
                }
                self.prepareSectionData()
            })
        } else {
            isLoading.accept(true)
            dataLoader.loadData(withSavingDataHandler: PersistentDataSaver(), completionQueue: DispatchQueue.main) {[weak self] (error) in
                self?.isLoading.accept(false)
                guard (error == nil) else {
                    self?.showError.accept(error!)
                    return
                }
                AppUserDefaults().dataDownloadSuccessfully()
                self?.initializeFetchRequestController(withComplitionHandler: { (error) in
                    guard (error == nil) else {
                        self?.showError.accept(error!)
                        return
                    }
                    self?.prepareSectionData()
                })
            }
        }
    }
    
    // MARK: - Private functions
    private func initializeFetchRequestController(withComplitionHandler complitionHandler: (Error?) -> ()) {
        let fetchRequest = User.fetchRequest() as NSFetchRequest<User>
        let sort = NSSortDescriptor(key: #keyPath(User.username), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        fetchRequest.sortDescriptors = [sort]
        
        do {
            fetchRequestController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            try fetchRequestController?.performFetch()
            complitionHandler(nil)
        } catch let error  {
            complitionHandler(error)
        }
    }
    
    private func prepareSectionData() {
        if let users = fetchRequestController?.fetchedObjects {
            var sections = [SectionData]()
            for user in users {
                sections.append(SectionData(header: user.username, items: user.posts.allObjects as! [Post]))
                
            }
            allUserSection.accept(sections)
        }
    }
}
