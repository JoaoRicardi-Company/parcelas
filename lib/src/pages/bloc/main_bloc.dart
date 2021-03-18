import 'package:rxdart/rxdart.dart';
import 'dart:math';

class MainBloc{
  var values = [
    36,48,60
  ];

  final _searchStatus = BehaviorSubject<SearchStatus>.seeded(SearchStatus.EMPTY);
  Stream<SearchStatus> get searchStatus => _searchStatus.stream;
  Function(SearchStatus) get setSearchStatus => _searchStatus.sink.add;

  final _valorDoTerrno = BehaviorSubject.seeded("");
  Function(String) get setValorDoTerrno => _valorDoTerrno.sink.add;

  final _valorDaEntrada = BehaviorSubject.seeded("");
  Function(String) get setValorDaEntrada => _valorDaEntrada.sink.add;

  final _prazo = BehaviorSubject.seeded("");
  Function(String) get setPrazo => _prazo.sink.add;
  Stream<String> get prazo => _prazo.stream;

  final _taxaAnual = BehaviorSubject.seeded("");

  final _taxaMensalText = BehaviorSubject.seeded("");
  Stream<String> get taxaMensalText => _taxaMensalText.stream;

  final _valorFinanciado = BehaviorSubject.seeded("");
  Stream<String> get valorFinanciado => _valorFinanciado.stream;

  final _valorParcela = BehaviorSubject.seeded("");
  Stream<String> get valorParcela => _valorParcela.stream;

  final _taxaMensal = BehaviorSubject.seeded(0.00);

  final _suggestions = BehaviorSubject<List<Suggestion>>.seeded([]);
  Stream<List<Suggestion>> get suggestions => _suggestions.stream;


  void setTaxaAnual(String value){

      _taxaAnual.sink.add(value);

      var mensalTaxDouble = _getMonthTax(value);
      _taxaMensal.sink.add(mensalTaxDouble);

      var mensalTaxConverted = (mensalTaxDouble * 100).toStringAsFixed(4);

      _taxaMensalText.sink.add(mensalTaxConverted);

  }

  void _getSuggestions(){
    List<Suggestion>  suges = [];

    values.map((item){
      suges.add(Suggestion(
        taxaAA: item == 36 || item  == 48 ?  '6.0' : '9.0',
        taxaAm: _getMonthTax(item == 36 || item  == 48 ?  '6.0' : '9.0').toString(),
        prazo: item.toString(),
        parcelas: _getParcelValue(
          valorDoTerrenoText: _valorDoTerrno.value,
          valorDaEntrada: _valorDaEntrada.value,
          taxaMensal: _getMonthTax(item == 36 || item  == 48 ?  '6.0' : '9.0'),
          prazoText: item.toString()
        ).toStringAsFixed(2)
      ));
    }).toList();

    _suggestions.sink.add(suges);
  }

  void calculateValue(){
    _calculateValorFinanciado();
    _valorParcela.sink.add(_calculateMainParcela());
    _getSuggestions();

    _searchStatus.sink.add(SearchStatus.SUCESS);

  }

  String _calculateMainParcela(){
    return _getParcelValue(
      prazoText: _prazo.value,
      taxaMensal: _taxaMensal.value,
      valorDaEntrada: _valorDaEntrada.value,
      valorDoTerrenoText: _valorDoTerrno.value
    ).toStringAsFixed(2);
  }

  void _calculateValorFinanciado(){
    double valorDoTerreno = double.parse(_valorDoTerrno.value);
    double valorEntrada = double.parse(_valorDaEntrada.value);
    var fianciado = valorDoTerreno - valorEntrada;
    _valorFinanciado.sink.add(fianciado.toStringAsFixed(2));
  }

  double _getMonthTax(String tax){
    try{
      double taxaAnual = double.parse(tax);

      taxaAnual = taxaAnual/100;

      double exponencial = 1/12;

      taxaAnual = taxaAnual + 1;

      double outraTaxa = pow(taxaAnual, exponencial);

      return outraTaxa - 1;


    }catch(e){
      print("ERRORORORO" + e.toString());
    }

  }

  double _getParcelValue({
    String valorDoTerrenoText,
    String valorDaEntrada,
    String prazoText,
    double taxaMensal
  }){
    try {
      double valorDoTerreno = double.parse(valorDoTerrenoText);
      double valorEntrada = double.parse(valorDaEntrada);
      double meses = double.parse(prazoText);

      double saldoFinanciado = valorDoTerreno - valorEntrada;

      double divisorComN = pow((1 + taxaMensal), -meses);

      double menosUm = (1 - divisorComN) / taxaMensal;

      return saldoFinanciado/menosUm;

    }catch(e){
      print("ERRORORORO" + e.toString());
      return 0.0;
    }
  }


  dispose(){
    _searchStatus.close();
    _valorDoTerrno.close();
    _valorDaEntrada.close();
    _prazo.close();
    _taxaAnual.close();
    _taxaMensal.close();
    _taxaMensalText.close();
    _valorFinanciado.close();
    _valorParcela.close();
    _suggestions.close();
  }

}

enum SearchStatus {
  EMPTY,
  LOADING,
  SUCESS,
  ERROR

}

class Suggestion{
  final String parcelas;
  final String prazo;
  final String taxaAm;
  final String taxaAA;

  Suggestion({this.parcelas, this.prazo, this.taxaAA, this.taxaAm});
}

//   double getParcelaValue(){

//
//   }
//