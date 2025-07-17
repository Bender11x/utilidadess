import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:utilidades/src/controllers/converter_controller.dart';
import 'package:utilidades/src/models/converter_model.dart';

class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  final controller = ConverterController();
  final inputController = TextEditingController();
  Unit selectFrom = Unit.meter;
  Unit selectTo = Unit.centimeter;
  String result = '';
  
  @override
  void initState(){
    super.initState();
    controller.InitializeModel();
  }

  void convert(){
    setState(() {
      controller.setInputValue(inputController.text);
      controller.setUnits(selectFrom, selectTo);
      result = controller.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          TextField(
            controller: inputController,
            decoration: InputDecoration(labelText: "Valor"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: unitDropdown(
                  selectFrom,
                  (u) => setState(() => selectFrom = u)
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward),
              SizedBox(width: 10),
              Expanded(
                child: unitDropdown(
                  selectTo,
                  (u) => setState(() => selectTo = u)
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: convert, child: Text("CONVERTER")),
          SizedBox(height: 20),
          Text("Resultado: $result", style: TextStyle(fontSize: 18),)
        ],
      ),
    );
  }

  DropdownButton<Unit> unitDropdown(
    Unit currentValue,
    ValueChanged<Unit> onChanged,
  ){
    return DropdownButton<Unit>(
      value: currentValue,
      onChanged: (Unit? newValue){
        if(newValue != null) onChanged(newValue);
      },
      isExpanded: true,
      items: Unit.values.map((unit){
        return DropdownMenuItem<Unit>(
          value: unit,
          child: Text(ConverterModel.getUnitName(unit)),
        );
      }).toList(),
    );
  }
  
}