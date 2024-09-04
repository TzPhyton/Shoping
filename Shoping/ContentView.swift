//
//  ContentView.swift
//  Shoping
//
//  Created by Enrique on 3/09/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Compras.fecha, ascending: true),
                          NSSortDescriptor(keyPath: \Compras.fecha, ascending: true)],
        animation: .default)
    private var compras: FetchedResults<Compras>
    
    static var fechaFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    var fecha = Date()

    @State private var mostrar: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(compras, id: \.id) {compra in
                    HStack{
                        Button(action: {
                            compra.comprado.toggle()
                            try! self.moc.save()
                        }) {
                            Image(systemName: compra.comprado ?  "checkmark.rectangle.fill":"checkmark.rectangle.fill")
                                .font(.headline.bold())
                                .foregroundColor(compra.comprado ? .green: .gray)
                        }
                        VStack(alignment: .leading){
                            
                            Text(compra.articulos ?? "")
                                .font(.headline.bold())
                                .foregroundStyle(.primary)
                            
                            Text("\(compra.fecha ?? self.fecha, formatter: Self.fechaFormatter)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }.strikethrough(compra.comprado ? true: false)
                        Spacer()
                        if compra.comprado {
                            Text("Comprado")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }.navigationBarTitle("compras")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            self.mostrar.toggle()
                        }){
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: self.$mostrar, content: {
                    AgregarArticulos().environment(\.managedObjectContext, self.moc)
                })
                }
            }
        }

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
