//
//  ItemDao.swift
//  eggplant-brownie
//
//  Created by Jefferson Oliveira de Araujo on 05/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import Foundation

class ItemDao {
    
    func save(_ itens: [Item]) {
        do {
        let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let path = recuperaDiretorio() else { return }
            try dados.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Item] {
        guard let path = recuperaDiretorio() else { return [] }
        do {
            let dados = try Data(contentsOf: path)
            let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! [Item]
            return itensSalvos
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = diretorio.appendingPathComponent("itens")
        
        return path
    }
}
