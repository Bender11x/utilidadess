import 'package:utilidades/src/models/converter_model.dart';

class ConverterController {
  //late indica que ConvertModel será inicializado posterioemente
  late ConverterModel _model;

  void setInputValue(String value){
    value = value.replaceAll(',', '.');
    final parsedValue = double.tryParse(value) ?? 0.0;
    _model = ConverterModel(
      inputValue: parsedValue, 
      fromUnit: _model.fromUnit, 
      toUnit: _model.toUnit
    );

  }

  void setUnits(Unit from, Unit to){
    _model = ConverterModel(
      inputValue: _model.inputValue, 
      fromUnit: from, 
      toUnit: to
    );
  }

  void InitializeModel(){
    _model = ConverterModel(
      inputValue: 0.0, 
      fromUnit: Unit.meter, 
      toUnit: Unit.centimeter
    );
  }

  String get result => _model.convert().toStringAsFixed(2);
}