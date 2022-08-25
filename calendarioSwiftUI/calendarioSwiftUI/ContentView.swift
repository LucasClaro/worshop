//
//  ContentView.swift
//  calculadora
//
//  Created by Gustavo Yamauchi on 24/08/22.
//

import SwiftUI

enum Mes: String, CaseIterable {
    case Janeiro, Fevereiro, Março, Abril, Maio, Junho, Julho, Agosto, Setembro, Outubro, Novembro, Dezembro
    
    
    
    var final: Int {
        switch self {
        case .Janeiro, .Março, .Maio, .Julho, .Agosto, .Outubro, .Dezembro:
            return 31
        case .Abril, .Junho, .Setembro, .Novembro :
            return 30
        case .Fevereiro:
            return  28
        }
    }
}

struct ContentView: View {
    @State var inicio = 1
    @State var final = 31
    @State var ano = 2023
    @State var mes = 0
    
    var body: some View {
//        GeometryReader { geometry in
//
//        }
        VStack{
            Text("\(Mes.allCases[mes].rawValue) - \(ano)")
            ForEach(0...4, id: \.self){ semana in
                HStack {
                    ForEach(1...7, id: \.self) { dia in
                        ZStack{
                            if calcDia(dia: dia, semana: semana) >= inicio && calcDia(dia: dia, semana: semana) - inicio + 1 <= final{
                                Circle().foregroundColor(.gray).opacity(0.5)
                                Text("\(calcDia(dia: dia, semana: semana) - inicio + 1)")
                            } else {
                                Circle().foregroundColor(.gray).opacity(0.3)
                            }
                        }
                    }
                }.frame(width: 400, height: 50, alignment: .center)
            }
            
            HStack {
                Button(action: {
                    
                    
                    if mes == 0{
                        mes = 11
                        ano -= 1
                    } else {
                        mes = mes - 1
                    }
                    final = Mes.allCases[mes].final
                    
                    inicio = inicio - final + 28
                    
                    
                    if inicio < 0 {
                        inicio += 7
                    }
                    
                    
                }, label: {
                    Text("<")
                })
                
                Button(action: {
                    inicio = inicio + final - 28
                    
                    if inicio > 7 {
                        inicio -= 7
                    }
                    
                    
                    if mes == Mes.allCases.count - 1 {
                        mes = 0
                        ano += 1
                    } else {
                        mes += 1
                    }
                    final = Mes.allCases[mes].final
                    
                }, label: {
                    Text(">")
                })
            }
        }
        
    }
    
    
    func calcDia(dia: Int, semana: Int) -> Int{
        return ((semana * 7) + dia)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 13 Pro Max")
        }
    }
}
