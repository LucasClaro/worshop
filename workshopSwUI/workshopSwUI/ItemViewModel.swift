//
//  ItemViewModel.swift
//  workshopSwUI
//
//  Created by Lucas Claro on 24/08/22.
//

import Foundation

class ItemViewModel : ObservableObject {
    @Published var itens: [Item]
    @Published var criando: Bool = false
    @Published var mostrando: Item? = nil
    
    init() {
        itens = [Item]()
    }
    
    func addItem(nome : String) {
        itens.append(Item(id: itens.count, Nome: nome, Comprado: false))
        criando = false
    }
    
    func comprarDescomprar(id : Int) {
        itens[id].Comprado.toggle()
    }
}
