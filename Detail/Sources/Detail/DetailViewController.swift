//
//  DetailViewController.swift
//  Detail
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import UIKit

public class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    @IBOutlet weak var titleDetailLabel: UILabel!
    
    @IBAction func onTapClose(_ sender: Any) {
        viewModel.onTapClose()
    }

    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: Bundle.module)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        titleDetailLabel.text = viewModel.titleString
    }
}
