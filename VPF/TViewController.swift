//
//  TViewController.swift
//  VPF
//
//  Created by PHN Tech 2 on 29/05/23.
//

import UIKit

class TViewController: UIViewController {
    let myView = UIView()
    let fromLabel = UILabel()
    let toLabel = UILabel()
    let progressBar = UISlider()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        myView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myView.backgroundColor = .gray
        
        
        view.addSubview(fromLabel)
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.leftAnchor.constraint(equalTo: myView.leftAnchor, constant: 10).isActive = true
        fromLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
        fromLabel.text = "00:00"
        
        
        //toLabel.text = "R"
        
        view.addSubview(toLabel)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -10).isActive = true
        toLabel.rightAnchor.constraint(equalTo: myView.rightAnchor, constant: -10).isActive = true
        
        //fromLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        toLabel.text = "00:00"
        
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.leftAnchor.constraint(equalTo: fromLabel.rightAnchor, constant: 5).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: myView.bottomAnchor, constant: -5).isActive = true
        progressBar.rightAnchor.constraint(equalTo: toLabel.leftAnchor, constant: -10).isActive = true
        
        
    }

}
