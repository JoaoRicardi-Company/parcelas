import 'dart:math';
class ParcelaValue {
   double valorTerreno;
   double valorEntrada;
   int prazoMeses;
   double jurosAnual;
   double jurosMensal;
   double valorFinanciado;
   ErrorState errorState;
   double valorParcela;

   void setValorFinanciado(){
     var terreno = valorTerreno ?? 0.0;
     var entrada = valorEntrada ?? 0.0;
     this.valorFinanciado =  terreno - entrada;
   }

   void getParcelValue(){
     try {

       double divisorComN = pow((1 + this.jurosMensal), - this.prazoMeses);

       double menosUm = (1 - divisorComN) / this.jurosMensal;

       this.valorParcela =  this.valorFinanciado/menosUm;

     }catch(e){
       print("ERRORORORO" + e.toString());
       this.valorParcela =  0.0;
     }
   }



   void getMonthTax(){
     try{
       var taxa = 0.0;

       taxa = this.jurosAnual/10;

       double exponencial = 1/12;

       taxa = taxa + 1;

       double outraTaxa = pow(taxa, exponencial);

       this.jurosMensal = outraTaxa - 1;



     }catch(e){
       print("ERRORORORO" + e.toString());
     }

   }

}


class ErrorState {
  String message;
}