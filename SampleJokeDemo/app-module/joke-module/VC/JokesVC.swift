//
//  PopularArticlesVC.swift
//  Sample
//
//  Created by Prabhat Pandey on 23/05/23.
//

import UIKit

let kEstimatedNewsRableRowHeight: CGFloat = 200.0

class JokesVC: UIViewController {
    
    var jokestableView = UITableView()
    var dataSource = JokeDataSource()
    var timer = Timer()
    
    lazy var viewModel : JokeViewModel = {
        let viewModel = JokeViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemTeal
        view.addSubview(jokestableView)
        setUpIntials()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    
    //new function
    @objc func timerAction() {
        print("timer fired!")
        // Fetch jokes if network available
        Utils.isConnectedToNetwork() ? fetchJokes() : showAlertWithMessgae(message: kNoNetworkErrorMessgae)
//        timer.invalidate()
    }
    
    //MARK:- UI setu methods
    func setUpIntials() {
        
        self.jokestableView.register(JokeTableViewCell.self, forCellReuseIdentifier: kJokeCellID)
        // Setup UI
        self.jokestableView.translatesAutoresizingMaskIntoConstraints = false
        self.jokestableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.jokestableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.jokestableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.jokestableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // Setup UI
        self.jokestableView.rowHeight = UITableView.automaticDimension
        self.jokestableView.estimatedRowHeight = kEstimatedNewsRableRowHeight
        //Setup datasource
        self.jokestableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.jokestableView.reloadData()
        }
        // Fetch jokes if network available
        Utils.isConnectedToNetwork() ? fetchJokes() : showAlertWithMessgae(message: kNoNetworkErrorMessgae)
    }
    
    func fetchJokes() {
        Spinner.useContainerView(view)
        Spinner.show("Please wait loading popular jokes ....")
        self.viewModel.fetchJokes({[weak self] result in
            Spinner.hide()
            switch result {
            case .failure(let error):
                self?.showAlertWithMessgae(message: error.localizedDescription)
            default:
                NSLog("sucess")
            }
        })
    }
    
    //MARK:- Alert
    func showAlertWithMessgae(message:String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: kOkButtonTitle, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}
