//
//  ContentView.swift
//  workshopSwUI
//
//  Created by Lucas Claro on 23/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm : ItemViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach (Array(vm.itens.enumerated()), id: \.element) { id, item in
                    HStack {
                        Image(systemName: item.Comprado ? "checkmark.square" : "square")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.black, .green)
                            .onTapGesture(perform: { vm.comprarDescomprar(id: id) })
                        Text(item.Nome)
                            .onTapGesture {
                                vm.mostrando = item
                            }
                            .sheet(item: $vm.mostrando) { item in
                                Text(item.Nome)
                            }
                        Spacer()
                    }
                    .font(.system(size: 30))
                    .padding()
                }
                Spacer()
            }
            .navigationTitle("Compras")
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink(destination: AddView(vm: vm), isActive: $vm.criando) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
}

struct AddView: View {
    
    @ObservedObject var vm : ItemViewModel
    @State var texto : String = ""
    
    var body: some View {
        TextField("Item name", text: $texto)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationTitle("Novo Item")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: { vm.addItem(nome: texto)}) {
                        Text("Salvar")
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: ItemViewModel())
            .previewInterfaceOrientation(.portrait)
    }
}
