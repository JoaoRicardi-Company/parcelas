import 'package:calculo_de_parcelas/src/parcela_value.dart';
import 'package:calculo_de_parcelas/src/presentation/custom_views/header/hoh_header.dart';
import 'package:calculo_de_parcelas/src/presentation/pages/main/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final Bloc bloc =  Bloc();
  bool seeOthersResults = true;

  TextEditingController terrenoController =  MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  TextEditingController entradaController =  MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  TextEditingController prazoController = TextEditingController();
  TextEditingController jurosController = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HoHHeader(),
      body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            menu(),
        StreamBuilder<ParcelaValue>(
            stream: bloc.state,
            initialData: null,
            builder: (context, snapshot) {
                return parcelasInputs(
                  context: context,
                  parcelaValue: snapshot.data
                );
              }
            ),
            StreamBuilder<ParcelaValue>(
              stream: bloc.state,
              initialData: null,
              builder: (context, snapshot) {
                return snapshot.data != null ?
                resultados(
                    snapshot.data
                ) : Container(
                  width: 45,
                  height: 45,
                  color: Colors.black,
                );
              }
            )
          ],
        )

    );
  }

  Widget resultados(ParcelaValue parcelaValue){
    var meses = parcelaValue.prazoMeses ?? 0;
    var parcela = parcelaValue.valorParcela == null ? 0.0 : parcelaValue.valorParcela;
    var jurosAnual = parcelaValue.jurosAnual == null ? 0.0 : parcelaValue.jurosAnual *10;
    return  Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24
      ),
      child: Container(
        width: (MediaQuery.of(context).size.width - 286)/2,
        height: double.infinity,
        child: Column(
          children: [
            Text('Resultado :',
              style: GoogleFonts.montserrat(
                  color: Color(0xFF0667b1),
                  fontSize: 42,
                  fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Terreno de numero ',
                  style: GoogleFonts.montserrat(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 24,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  child: TextField(),
                ),
                Text(' de ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 24,
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  child: TextField(),
                ),
                Text(' mˆ2 ',
                  style: GoogleFonts.montserrat(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48,),
            Text('Valor financiado :',
              style: GoogleFonts.montserrat(
                  color: Color(0xFF0667b1),
                  fontSize: 24,
                  fontWeight: FontWeight.w200
              ),
            ),
            SizedBox(height: 8,),
            Text(r'R$ ' + parcelaValue.valorFinanciado.toString().replaceAll(".", ","),
              style: GoogleFonts.montserrat(
                color: Color(0xFF0667b1),
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 48,),
            Text('Prazo do financiamento :',
              style: GoogleFonts.montserrat(
                color: Color(0xFF0667b1),
                fontSize: 24,
                fontWeight: FontWeight.w200
              ),
            ),
            SizedBox(height: 8,),
            Text('$meses meses',
              style: GoogleFonts.montserrat(
                  color: Color(0xFF0667b1),
                  fontSize: 24,
                  fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 48,),
            Text('Parcelas de :',
              style: GoogleFonts.montserrat(
                  color: Color(0xFF0667b1),
                  fontSize: 24,
                  fontWeight: FontWeight.w200
              ),
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(r'R$ ' + parcela.toStringAsFixed(2).replaceAll(".", ","),
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF0667b1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(' com taxas de ',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF0667b1).withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
                Text(' ${jurosAnual.toStringAsFixed(2).replaceAll(".", ",")}% a.m.',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF0667b1),
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
            SizedBox(height: 48,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Outros resultados :',
            //       style: GoogleFonts.montserrat(
            //           color: Color(0xFF0667b1),
            //           fontSize: 24,
            //           fontWeight: FontWeight.w700
            //       ),
            //     ),
            //     SizedBox(width: 120,),
            //     Icon(Icons.remove_red_eye_outlined,
            //       color: Color(0xFF0667b1),
            //     )
            //   ],
            // ),
            // SizedBox(height: 48,),
            // Container(
            //   width: (MediaQuery.of(context).size.width - 286)/2,
            //   height: 200,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //       itemBuilder: (_, index){
            //         return Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //             height: 200,
            //             width: 200,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(16),
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black.withOpacity(0.6),
            //                   offset: Offset(1,1),
            //                   blurRadius: 1
            //                 )
            //               ]
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.only(
            //                     left: 12,
            //                     top: 18,
            //                     bottom: 8
            //                   ),
            //                   child: Text('Parcelas de :',
            //                     style: GoogleFonts.montserrat(
            //                         color: Color(0xFF0667b1),
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w400
            //                     ),
            //                   ),
            //                 ),
            //                 Text(r'R$ 2598,00',
            //                   style: GoogleFonts.montserrat(
            //                       color: Color(0xFF0667b1),
            //                       fontSize: 24,
            //                       fontWeight: FontWeight.w700
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 12,
            //                       top: 6,
            //                       bottom: 4
            //                   ),
            //                   child: Text('Prazo ',
            //                     style: GoogleFonts.montserrat(
            //                         color: Color(0xFF0667b1),
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w400
            //                     ),
            //                   ),
            //                 ),
            //                 Text('60',
            //                   style: GoogleFonts.montserrat(
            //                       color: Color(0xFF0667b1),
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.w600
            //                   ),
            //                 ),
            //                 Padding(
            //                   padding: const EdgeInsets.only(
            //                       left: 12,
            //                       top: 6,
            //                       bottom: 4
            //                   ),
            //                   child: Text('Taxa de  ',
            //                     style: GoogleFonts.montserrat(
            //                         color: Color(0xFF0667b1),
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w400
            //                     ),
            //                   ),
            //                 ),
            //                 Text('12% a.a.',
            //                   style: GoogleFonts.montserrat(
            //                       color: Color(0xFF0667b1),
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.w600
            //                   ),
            //                 ),
            //
            //               ],
            //             ),
            //           ),
            //         );
            //       }
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget parcelasInputs({BuildContext context, ParcelaValue parcelaValue}){

    double jurosMensal = parcelaValue == null ? 0.0 : parcelaValue.jurosMensal ?? 0.00;

    jurosMensal = (jurosMensal *100);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 8
      ),
      child: Container(
        width: (MediaQuery.of(context).size.width - 325)/2,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF0667b1),
          borderRadius: BorderRadius.circular(
            32
          ),
          boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 1,
                offset: Offset(1,1)
              )
            ]
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12
            ),
            child: Column(
              children: [
                SizedBox(height: 16,),
                Text('Calcular parcelas',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 32,),
                inputField(
                  controller: terrenoController,
                  onChange: (value) {
                    bloc.setTerrenoValue(terrenoController.text);
                  },
                  label: "Valor do terreno",
                  hint: "100.000,00",
                  moneyPrefix: true,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24
                  ),
                  child: inputField(
                    controller: entradaController,
                    onChange: (value) => bloc.setEntradaValue(value),
                    label: "Valor da entrada",
                    hint: "10.000,00",
                    moneyPrefix: true,
                  ),
                ),
                optionslist(
                  context: context,
                  values: [5, 10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95],
                  sufix: "%"
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 24
                  ),
                  child: inputField(
                    controller: prazoController,
                    onChange: (value) => bloc.setPrazoValue(value),
                    label: "Prazo em meses",
                    hint: "60",
                    moneyPrefix: false,
                  ),
                ),
                optionslist(
                    context: context,
                    values: [1,2,3,4,5,6,7,8,9,10],
                    sufix: "Anos"
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 24
                  ),
                  child: inputField(
                    controller: jurosController,
                    onChange: (value) => bloc.setJurosValue(value),
                    label: "Taxa de juros ( ao ano )",
                    hint: "12,5%",
                    moneyPrefix: false,
                  ),
                ),
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Taxa ao mês : ${jurosMensal.toStringAsFixed(4).replaceAll(".",",")}',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      )

                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionslist({BuildContext context, List<dynamic> values, String sufix}){

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: ListView.builder(
        itemCount: values.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.3
                ),
                borderRadius: BorderRadius.circular(4)
              ),
              width: 120,
              height: 32,
              child: Center(
                child: Text(
                  "${values[index]} $sufix",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ),
            ),
          );
        }
      )
    );
  }

  Widget inputField({
    String label,
    String hint,
    bool moneyPrefix,
    TextEditingController controller,
    Function(String) onChange,
}){
    return Container(
      child:TextField(
          onChanged: onChange,
          controller: controller,
          style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w400
          ),
          decoration: InputDecoration(
            prefix: Text(moneyPrefix ? r'R$' : "",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w400
              ),
            ),
            labelText: label,
            labelStyle: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300
            ),
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(
                color: Colors.white.withOpacity(0.6),
                fontSize: 28,
                fontWeight: FontWeight.w300
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2
              ),
            ),
          ),
        )
    );
  }

  Widget menu(){
    return Padding(
      padding: EdgeInsets.only(
        left: 16
      ),
      child: Container(
        width: 270,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.payments_outlined,
                    color: Color(0xFF0667b1),
                  ),
                ),
                Text('Calcular parcelas',
                  style: GoogleFonts.montserrat(
                    color: Color(0xFF0667b1),
                    fontSize: 24,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
