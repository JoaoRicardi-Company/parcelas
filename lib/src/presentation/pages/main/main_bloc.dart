import 'package:calculo_de_parcelas/src/parcela_value.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:math';

class Bloc {

  ParcelaValue _parcelaValue = ParcelaValue();

  //inputs
  final _state = BehaviorSubject<ParcelaValue>.seeded(null);
  Stream<ParcelaValue> get state => _state.stream;

  final _terrenoValue = BehaviorSubject.seeded("");
  Stream<String> get  terrenoValue => _terrenoValue.stream;
  void setTerrenoValue(String newValue) {
    _parcelaValue.valorTerreno = double.parse(reformat(newValue));

    _terrenoValue.sink.add(newValue);
    updateValues();
  }

  final _entradaValue = BehaviorSubject.seeded("");
  Stream<String> get  entradaValue => _entradaValue.stream;

  void setEntradaValue(String newValue) {
    _parcelaValue.valorEntrada = double.parse(reformat(newValue)) *10;
    _parcelaValue.setValorFinanciado();

    _state.sink.add(_parcelaValue);
    _entradaValue.sink.add(newValue);
    updateValues();
  }

  final _prazoValue = BehaviorSubject.seeded("");
  Stream<String> get  prazoValue => _prazoValue.stream;
  void setPrazoValue(String value){
    var converted = int.tryParse(value);
    _prazoValue.sink.add(value);
    _parcelaValue.prazoMeses = converted;
    _state.sink.add(_parcelaValue);
    updateValues();
  }

  final _jurosValue = BehaviorSubject.seeded("");
  Stream<String> get  jurosValue => _jurosValue.stream;


  void setJurosValue(String value){

    _jurosValue.sink.add(value);

    _parcelaValue.jurosAnual = double.tryParse(reformat(value));
    _parcelaValue.getMonthTax();
    _parcelaValue.getParcelValue();
    _state.sink.add(_parcelaValue);
    updateValues();

  }

  void updateValues(){
    if(_parcelaValue.valorParcela != null){
      _parcelaValue.getMonthTax();
      _parcelaValue.getParcelValue();
      _parcelaValue.setValorFinanciado();
    }
  }



  String reformat(String value) {
    String currentValue = '';
    List<String> values = value.split(",");

    if(values.length >= 2){
      var first =  values[0].replaceAll(".", "");
       currentValue = first + '.' + values[1];
    }

    return currentValue;
  }


}