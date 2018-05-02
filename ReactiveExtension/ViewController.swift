//
//  ViewController.swift
//  ReactiveExtension
//
//  Created by Akasaaa on 2018/04/30.
//  Copyright © 2018年 Akasaaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapNum(_ sender: UIButton) {
        viewModel.input(num: sender.tag)
    }
    @IBAction func didTapOperator(_ sender: UIButton) {
        guard let op = Operator(rawValue: sender.tag) else { return }
        viewModel.input(operator: op)
    }
    @IBAction func didTapEqual(_ sender: UIButton) {
        viewModel.equal()
    }
    @IBAction func didTapClear(_ sender: UIButton) {
        viewModel.clear()
    }
}
