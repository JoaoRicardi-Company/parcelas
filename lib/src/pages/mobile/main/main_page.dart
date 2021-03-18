import 'package:flutter/material.dart';

class MobileMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final TextEditingController terrenoController = TextEditingController();
//   final TextEditingController entradaController = TextEditingController();
//   final TextEditingController prazoController = TextEditingController();
//   final TextEditingController taxaController = TextEditingController();
//
//   var taxaMensal = 0.0;
//   var valorParcela = 0.0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           inputWithLabel(
//               controller: terrenoController,
//               label: "Valor do terreno",
//               hint: r"R$"
//           ),
//           inputWithLabel(
//               controller: entradaController,
//               label: "Valor da entrada",
//               hint: r"R$"
//           ),
//           inputWithLabel(
//               controller: prazoController,
//               label: "Prazo ( em meses )",
//               hint: "12"
//           ),
//           inputWithLabel(
//               controller: taxaController,
//               label: "Taxa Anual ( em porcentagem )",
//               hint: "1.00 %"
//           ),
//
//           Text(taxaMensal.toStringAsFixed(6), style: TextStyle(fontSize: 40),),
//
//           Text(valorParcela.toStringAsFixed(6), style: TextStyle(fontSize: 40),),
//
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           FloatingActionButton(
//             tooltip: 'Increment',
//             child: Icon(Icons.add),
//             onPressed: getMonthTax,
//           ),
//           FloatingActionButton(
//             tooltip: 'Increment',
//             onPressed: getParcelaValue,
//             child: Icon(Icons.access_alarm),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget inputWithLabel({ String label, TextEditingController controller, String hint}){
//     return Container(
//       width: 400,
//       height: 150,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: TextStyle(fontSize: 40),),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//                 hintText: hint,
//                 border: UnderlineInputBorder()
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   double getMonthTax(){
//     try{
//       double taxaAnual = double.parse(taxaController.text);
//
//       print("taxa anul inicial ===> $taxaAnual");
//       taxaAnual = taxaAnual/100;
//
//       print("taxa anul corrigida ===> $taxaAnual");
//       double exponencial = 1/12;
//
//       taxaAnual = taxaAnual + 1;
//
//       print("taxa anul mais 1 ===> $taxaAnual");
//       double outraTaxa = pow(taxaAnual, exponencial);
//
//
//
//       setState(() {
//         taxaMensal = outraTaxa - 1;
//       });
//
//
//
//     }catch(e){
//       print("ERRORORORO" + e.toString());
//     }
//
//   }
//
//   double getParcelaValue(){
//     try {
//       double valorDoTerreno = double.parse(terrenoController.text);
//       double valorEntrada = double.parse(entradaController.text);
//       double messes = double.parse(prazoController.text);
//
//       double saldoFinanciado = valorDoTerreno - valorEntrada;
//
//       double taxaMesal = double.parse(taxaMensal.toStringAsFixed(6));
//
//       double divisorComN = pow((1 + taxaMesal), -messes);
//
//       double menosUm = (1 - divisorComN) / taxaMesal;
//
//
//       setState(() {
//         valorParcela = saldoFinanciado / menosUm;
//       });
//     }catch(e){
//       print("ERRORORORO" + e.toString());
//     }
//
//   }
//
//
//
//
//
// }
