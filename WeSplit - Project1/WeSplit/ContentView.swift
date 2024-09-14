//
//  ContentView.swift
//  WeSplit
//
//  Created by Himanshu Gupta on 11/09/24.
//

import SwiftUI

struct ContentView: View {
    // State property wrapper allows mutating vars within the ContentView struct, including within computed properties like body
    
    // vars used by TextField must be String
    @State private var checkAmount = ""
    
    // challenge 3
    @State private var NumberOfPeople = ""
    // commented for challenge 3
    
    
    @State private var tipPercentage = 2
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // challenge 2
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        // challenge 3
        let peopleCount = Double(NumberOfPeople) ?? 1
       

        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    // $ allows two-way binding of the var checkAmount, so that it gets updated with user input
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    // challenge 3
                    TextField("Number of people", text: $NumberOfPeople)
                        .keyboardType(.numberPad)
                    // commented for challenge 3
                    // Picker("Number of people", selection: $numberOfPeople) {
                    //     ForEach(2 ..< 100) {
                    //         Text("\($0) people")
                    //     }
                    // }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                // challenge 2
                Section(header: Text("Total amount")) {
                    Text("₹\(grandTotal, specifier: "%.2f")")
                }
                
                // challenge 1
                Section(header: Text("Amount per person")) {
                    // totalPerPerson and not $totalPerPerson as there is no need to update the var here
                    Text("₹\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("DONE"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

