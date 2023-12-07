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

struct testView: View {
    @State private var bottomSheetShown = false
    
    var body: some View {
        GeometryReader { geometry in
            Color.green
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.7,
                minHeight: geometry.size.height * 0.5
            ) {
                Color.blue
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
                .frame(
                    width: 20,
                    height: 4
                )
            Spacer()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.indicator.padding(5)
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.3
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(vm: ItemViewModel())
//            .previewInterfaceOrientation(.portrait)
//    }
//}
