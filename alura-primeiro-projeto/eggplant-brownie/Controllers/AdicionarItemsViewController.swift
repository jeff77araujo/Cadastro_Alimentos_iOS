//
//  AdicionarItemsViewController.swift
//  eggplant-brownie
//
//  Created by Jefferson Oliveira de Araujo on 29/01/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

protocol AdicionarItemsViewControllerDelegate {
    func addItemList(_ item: Item)
}

class AdicionarItemsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var caloriasTextField: UITextField!
    
    // MARK: Atributos
    
    var delegate: AdicionarItemsViewControllerDelegate?
    
    init(delegate: AdicionarItemsViewControllerDelegate) {
        super.init(nibName: "AdicionarItemsViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) { super.init(coder: coder) }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    
    @IBAction func addItem(_ sender: Any) {
        guard let nome = nomeTextField.text else { return }
        guard let caloriasText = caloriasTextField.text, let calorias = Double(caloriasText) else { return }
        let item = Item(nome: nome, calorias: calorias)
        delegate?.addItemList(item)
        navigationController?.popViewController(animated: true)
    }
}
