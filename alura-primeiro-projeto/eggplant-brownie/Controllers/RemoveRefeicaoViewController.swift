//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Jefferson Oliveira de Araujo on 04/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let botaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        let botaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        
        alert.addAction(botaoCancelar)
        alert.addAction(botaoRemover)
        controller.present(alert, animated: true, completion: nil)
    }
}
