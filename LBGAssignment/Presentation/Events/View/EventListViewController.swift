//
//  EventListViewController.swift
//  LBGAssignment
//
//  Created by mac on 18/02/23.
//

import UIKit
import Combine

class EventListViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    static func loadVC(with viewModel: EventListViewModel, coodinator: Coordinator) -> EventListViewController {
        let vc = EventListViewController.instantiate(storyboard: .main) as! EventListViewController
        vc.viewModel = viewModel
        vc.coordinator = coodinator
        return vc
    }
    
    ///tableview object connect to IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    ///ActivityIndicator object connect to IBOutlet
    @IBOutlet weak var activityIndicater: UIActivityIndicatorView!
    
    ///View Model
    var viewModel: EventListViewModel!
    
    ///Coordinator
    var coordinator: Coordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Events"
        self.setUpTableView()
        bindUIwithViewModel()
        
        viewModel.getEvents()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI Helper
    ///  Set up setUpTableView
    func setUpTableView() {
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0.01))
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerClass(EventViewCell.self)
    }
    
    func bindUIwithViewModel() {
        bindDataSource()
        bindActivityIndicator()
        bindErrorHandle()
    }
    
    func bindDataSource() {
        viewModel?.$events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.updateUI()
            }.store(in: &cancellables)
    }
    
    func bindActivityIndicator() {
        viewModel?.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loading in
                loading ? self?.activityIndicater.startAnimating() : self?.activityIndicater.stopAnimating()
            }.store(in: &cancellables)
    }
    
    func bindErrorHandle() {
        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let err = error {
                    self?.showErrorText(err)
                }
            }.store(in: &cancellables)
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

// MARK: UITableViewDelegate,UITableViewDataSource
extension EventListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EventViewCell.self, indexPath: indexPath)
        let locData = self.viewModel.getItemAtIndex(indexPath.row)
        cell.event = locData
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let event = self.viewModel.getItemAtIndex(indexPath.row) else { return }
        coordinator.navigateToEventDetails(event)
    }
}
