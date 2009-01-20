function IsNumeric(sText) {
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;

   if (sText.length == 0) {
       return true;
   }

   if (sText.length != 14) {
       return false;
   }
 
   for (i = 0; i < sText.length && IsNumber == true; i++)  {
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1)  {
         IsNumber = false;
      }
   }

   return IsNumber;
}

function ValidateForm(form) {

   if (!IsNumeric(form.numRadicado.value)) {
      alert('Por favor, ingrese un valor númerico de 14 dígitos en el campo Número de Radicado');
      form.numRadicado.focus(); 
      return false; 
   } 
 
   return true;
 
} 

