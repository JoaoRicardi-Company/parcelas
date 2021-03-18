
import 'package:calculo_de_parcelas/src/pages/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebMainPage extends StatefulWidget {
  @override
  _WebMainPageState createState() => _WebMainPageState();
}

class _WebMainPageState extends State<WebMainPage> {

  MainBloc bloc = MainBloc();
  final TextEditingController terrenoController = TextEditingController();
  final TextEditingController entradaController = TextEditingController();
  final TextEditingController prazoController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();

  _cleanAllFields(){
    terrenoController.clear();
    entradaController.clear();
    prazoController.clear();
    taxaController.clear();

    bloc.setPrazo('');
    bloc.setValorDaEntrada('');
    bloc.setValorDoTerrno('');
    bloc.setTaxaAnual('');
  }

  _getParcelValue(){
    bloc.setSearchStatus(SearchStatus.LOADING);

    bloc.calculateValue();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/nova.png'
                              )
                          )
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: MediaQuery.of(context).size.height/4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/hoh.png'
                              )
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height*3/4,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 32,right: 32
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16,),
                      inputField(
                        context: context,
                        label: "Valor do terreno ",
                        subtitle: "( Em reais ) :",
                        hint: '100.000,00',
                        prefix: r'R$',
                        controller: terrenoController,
                        onChange: bloc.setValorDoTerrno
                      ),
                      inputField(
                        context: context,
                        label: "Valor da entrada ",
                        subtitle: "( Em reais ) :",
                        hint: '100.000,00',
                        prefix: r'R$',
                        controller: entradaController,
                        onChange: bloc.setValorDaEntrada
                      ),
                      inputField(
                        context: context,
                        label: "Prazo ",
                        subtitle: " ( Em meses ) :",
                        hint: '60',
                        prefix: '',
                        controller: prazoController,
                        onChange: bloc.setPrazo
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          inputField(
                            context: context,
                            label: "Taxa anual ",
                            subtitle: "( Em porcentagem ) :",
                            hint: '12.00',
                            prefix: '%',
                            controller: taxaController,
                            onChange: bloc.setTaxaAnual
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Taxa mensal',
                                style: GoogleFonts.roboto(
                                    fontSize: 28,
                                    color: Colors.black.withOpacity(0.75)
                                ),
                              ),
                              StreamBuilder<String>(
                                stream: bloc.taxaMensalText,
                                initialData: '00.00',
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data,
                                    style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: Colors.black.withOpacity(0.75)
                                    ),
                                  );
                                }
                              ),
                            ],
                          )
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: _cleanAllFields,
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Limpar campos',
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        color: Colors.blue
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ),
                            SizedBox(width: 16,),
                            Expanded(
                              child: InkWell(
                                onTap: _getParcelValue,
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Calcular parcelas',
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder<SearchStatus>(
                stream: bloc.searchStatus,
                initialData: SearchStatus.EMPTY,
                builder: (context, snapshot) {
                  return Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height*3/4,
                    child: getStatus(snapshot.data),
                  );
                }
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getStatus(SearchStatus status){
    switch(status){
      case SearchStatus.EMPTY:
        return emptyState();
        break;
      case SearchStatus.LOADING:
        return loadingState();
        break;
      case SearchStatus.SUCESS:
        return searchState();
        break;
      case SearchStatus.ERROR:

        break;
    }
  }

  Widget searchState(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32,),
        Icon(
          Icons.check_circle,
          size: 120,
          color: Colors.green,
        ),
        SizedBox(height: 48,),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Valor financiado :',
                    style: GoogleFonts.roboto(
                        fontSize: 26,
                        color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                  SizedBox(height: 12,),
                  StreamBuilder<String>(
                    stream: bloc.valorFinanciado,
                    initialData: '',
                    builder: (context, snapshot) {
                      return Text(
                        r'R$ ' + '${snapshot.data.replaceAll(".", ",")}',
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      );
                    }
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Quantidade parcelas :',
                    style: GoogleFonts.roboto(
                        fontSize: 26,
                        color: Colors.black.withOpacity(0.6)
                    ),
                  ),
                  SizedBox(height: 12,),
                  StreamBuilder<String>(
                    stream: bloc.prazo,
                    initialData: '0',
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black
                        ),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 80,),
        Expanded(
          child: Container(
            width: 650,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Parcelas de :',
                      style: GoogleFonts.roboto(
                          fontSize: 26,
                          color: Colors.black.withOpacity(0.6)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                        left: 8
                      ),
                      child: StreamBuilder<String>(
                        stream: bloc.valorParcela,
                        initialData: '',
                        builder: (context, snapshot) {
                          return Text(
                            r'R$ ' + snapshot.data.replaceAll(".", ","),
                            style: GoogleFonts.roboto(
                                fontSize: 54,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          );
                        }
                      ),
                    ),
                    StreamBuilder<String>(
                      stream: bloc.taxaMensalText,
                      initialData: '',
                      builder: (context, snapshot) {
                        return Text(
                          '( taxa a.m. '+ snapshot.data + ' )',
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black.withOpacity(0.75)
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/4,
            child: StreamBuilder<List<Suggestion>>(
              stream: bloc.suggestions,
              initialData: [],
              builder: (context, snapshot) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index){
                    return optionContainer(
                        snapshot.data[index]
                    );
                  }
                );
              }
            ),
          ),
        )
      ],
    );
  }

  Widget emptyState(){
    return Center(
      child: Text(
        'Ainda não há pesquisas',
        style: GoogleFonts.roboto(
            fontSize: 34,
            color: Colors.black.withOpacity(0.75)
        ),
      ),
    );
  }

  Widget loadingState(){
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.black.withOpacity(0.6),
      )
    );
  }

  Widget inputField({
    BuildContext context,
    String label,
    String subtitle,
    String hint,
    String prefix,
    TextEditingController controller,
    Function(String) onChange
  }){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
              children: [
                Text(
                  label,
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.black
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.75)
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Container(
              width: 400,
              child: TextField(
                onChanged: onChange,
                controller: controller,
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.black.withOpacity(0.68)
                ),
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.roboto(
                        fontSize: 24,
                        color: Colors.black.withOpacity(0.5)
                    ),
                    prefixText: prefix,
                    border: UnderlineInputBorder()
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget optionContainer(Suggestion suggestion){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parcelas de :',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7)
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24,
                    ),
                    child: Text(
                      r'R$ ' + suggestion.parcelas,
                      style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16
                ),
                child: Row(
                  children: [
                    Text(
                      'Prazo :',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.7)
                      ),
                    ),
                    SizedBox(width: 12,),
                    Text(
                      suggestion.prazo + ' meses',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Taxa mensal (a.a)',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.7)
                    ),
                  ),
                  SizedBox(width: 12,),
                  Text(
                    suggestion.taxaAA +' %',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}