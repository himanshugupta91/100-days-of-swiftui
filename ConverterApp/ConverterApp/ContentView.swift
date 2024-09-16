//
//  ContentView.swift
//  ConverterApp
//
//  Created by Himanshu Gupta on 16/09/24.
//

import SwiftUI

struct ContentView: View {
    // input unit value
    
    // Holds the value to be converted.
    
    @State private var inputValue: Double = 0
    //The unit of the input value. Dimension is a base class for different measurement units.
    
    @State private var inputUnit: Dimension = UnitDuration.hours
    // The unit to which the input value is converted.
    @State private var outputUnit: Dimension = UnitDuration.seconds
    // Tracks which conversion category is selected (e.g., temperature, length).
    @State private var selectedUnit = 2
    // Manages focus state of the input field.
    
    @FocusState private var inputIsFocused: Bool
    
    //An array of strings representing different types of conversions.
    let conversionTypes = ["Temprature","Length","Time","Volume"]
    
    
    //A computed property that provides arrays of measurement units for each conversion type.
    var units:[[Dimension]]{
        let tempUnits: [UnitTemperature] = [.celsius,.fahrenheit,.fahrenheit]
        let lengthUnits: [UnitLength] = [.meters,.kilometers,.feet,.yards,.miles]
        let timeUnits: [UnitDuration] = [.seconds,.minutes,.hours]
        let volumeUnits: [UnitVolume] = [.milliliters,.liters,.cups,.pints,.gallons]
        
        return [
        tempUnits,
        lengthUnits,
        timeUnits,
        volumeUnits,
        ]
    }
    // An instance of MeasurementFormatter used to format the converted values.
    
    let formatter: MeasurementFormatter
    
    // Initializes the formatter with specific options.
    init(){
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
    }
    
    // Computes the converted value and formats it as a string.
    var result: String{
        let outputMeasurement = Measurement(value: inputValue, unit: inputUnit).converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
        
    }
    
    
    
    var body: some View {
        //Provides a navigation context for the form.
        NavigationView{
            // A container that organizes form elements.
            Form{
                // top view Defines sections within the form.
                Section{
                    //Input field for the value to convert.
                    TextField("Input",value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                        
                }
                Section{
                    // section to
                    // A custom view for selecting units (defined later).
                    //Allows selection of conversion type.
                    unitPicker(title: "Convert from Unit", selection:$inputUnit)
                    unitPicker(title:"Convert to Unit", selection: $outputUnit)
                } header: {
                    Text("\(formatter.string(from: inputUnit)) to \(formatter.string(from:  outputUnit))")
                        .heavyRoundedFont()
                }
                // result section
                Section{
                    Text(result)
                } header: {
                    Text("result")
                        .heavyRoundedFont()
                }
                
                // which unit we want to convert
                
                Picker("Conversion", selection: $selectedUnit){
                    ForEach(0..<conversionTypes.count, id: \.self){
                        Text(conversionTypes[$0])
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 170)
            }
            .navigationTitle("Converter")
            //Adds a "DONE" button to dismiss the keyboard.

            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("DONE"){
                        inputIsFocused = false
                    }
                }
            }
            // Updates the units based on the selected conversion type.
            
            .onChange(of: selectedUnit){
                newUnits in
                inputUnit = units[newUnits][0]
                outputUnit = units[newUnits][1]
            }
            }
        }
    //A helper function to create a segmented picker for selecting units.
    
    private func unitPicker(title: String,selection: Binding<Dimension>) -> some View{
        Picker(title,selection: selection){
            ForEach(units[selectedUnit],id: \.self){
                Text(formatter.string(from: $0).capitalized)
            }
        }
        .pickerStyle(.segmented)
    }
}


#Preview {
    ContentView()
}
