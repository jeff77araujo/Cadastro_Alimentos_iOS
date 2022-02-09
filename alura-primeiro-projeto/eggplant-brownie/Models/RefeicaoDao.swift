//
//  RefeicaoDao.swift
//  eggplant-brownie
//
//  Created by Jefferson Oliveira de Araujo on 05/02/22.
//  Copyright © 2022 Alura. All rights reserved.
//

import Foundation

class RefeicaoDao {
        
    func save(_ refeicoes: [Refeicao]) {
        guard let path = recuperaCaminho() else { return }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Refeicao] {
        guard let path = recuperaCaminho() else { return [] }
        do {
            let dados = try Data(contentsOf: path)
            guard let refeicoesSalvas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? [Refeicao] else { return [] }
            return refeicoesSalvas
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = diretorio.appendingPathComponent("itens")
        
        return path
    }
}
