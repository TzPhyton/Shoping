//
//  AgregarArticulos.swift
//  Shoping
//
//  Created by Enrique on 3/09/24.
//

import SwiftUI

struct AgregarArticulos: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss

    @State private var articulos: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Articulos...", text: self.$articulos)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    let agregar = Compras(context: self.moc)
                    agregar.articulos = self.articulos
                    agregar.fecha = Date()
                    agregar.id = UUID()
                    
                    try! self.moc.save()
                    dismiss()
                    
                }) {
                    Text("Agregar")
                }.disabled(self.articulos.count > 0 ? false: true)
            }.navigationTitle("Agregar Articulos")
        }
    }
}

#Preview {
    AgregarArticulos()
}
