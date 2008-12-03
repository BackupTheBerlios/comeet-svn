// JavaScript Document

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function trim(str) {
	str = str.replace(/^\s+/, '');
	for (var i = str.length - 1; i >= 0; i--) {
		if (/\S/.test(str.charAt(i))) {
			str = str.substring(0, i + 1);
			break;
		}
	}
	return str;
}

function validarForma() { 
	var forma = document.forms["frmLogin"];
	if (forma) {
		var mensaje = "";
		if (trim(forma.krd.value).length == 0) {
			mensaje += "* Ingrese el nombre de usuario.\n";
		}
		if (forma.drd.value == "") {
			mensaje += "* Ingrese la contraseña.\n";
		}
		if (mensaje.length > 0) {
			mensaje = "Por favor realice las siguientes operaciones:\n\n" + mensaje;
		}
		return mensaje;
	}
	return "";
}

isIE=document.all;
isNN=!document.all&&document.getElementById;
isN4=document.layers;
isHot=false;
var tempX = 0;
var tempY = 0;

//alert(isN4);
function ddInit(e){
  
  hotDog=isIE ? event.srcElement : e.target;  
  topDog=isIE ? "BODY" : "HTML";
  
  //capa = 
   
  
 
  while (hotDog.id.indexOf("Mensaje")==-1&&hotDog.tagName!=topDog){
    hotDog=isIE ? hotDog.parentElement : hotDog.parentNode;
  }  
  size=hotDog.id.length;
  capa = (hotDog.id.substring(size-1,size)); //returns "exce"
  whichDog=isIE ? document.all.theLayer : document.getElementById("capa"+capa); 
  if (hotDog.id.indexOf("Mensaje")!=-1){
  	 
    offsetx=isIE ? event.clientX : e.clientX;
    offsety=isIE ? event.clientY : e.clientY;
    nowX=parseInt(whichDog.style.left);
    nowY=parseInt(whichDog.style.top);
    ddEnabled=true;
    document.onmousemove=dd;
  }
}

function dd(e){
  
  if (!ddEnabled) return;
  whichDog.style.left=isIE ? nowX+event.clientX-offsetx : nowX+e.clientX-offsetx; 
  whichDog.style.top=isIE ? nowY+event.clientY-offsety : nowY+e.clientY-offsety;
  return false;  
}

function ddN4(layer){
	
 isHot=true;
 // if (!isN4) return;
  if (document.layers) isN4=document.layers
   	else if (document.all)  isN4= document.all[layer];
  		else if (document.getElementById)  isN4= document.getElementById(layer); 

  N4 = document.getElementById(layer); 
  
  //alert (document.all);		
 if (document.all) 
  	alert ("hay documento ");
 // N4 = isN4;
 // alert (document.layers);
   //alert ("va...");
  // alert (N4); 
  window.captureEvents(Event.MOUSEDOWN|Event.MOUSEUP);
   N4.onmousedown=function(e){
   tempX = e.pageX;
   tempY = e.pageY;   	
   
    
  }
  
  isN4.onmousemove=function(e){
  	
    if (isHot){
      if (document.layers){ document.layers[layer].left = e.pageX-tempX;}
	  else if (document.all){document.all[layer].style.left=e.pageX-tempX;}
	  else if (document.getElementById){document.getElementById(layer).style.left=e.pageX-tempX; }
	  // Set ver 
	 if (document.layers){document.layers[layer].top = e.pageY-tempY;}
	 else if (document.all){document.all[layer].style.top=e.pageY-tempY;}
	 else if (document.getElementById){document.getElementById(layer).style.top=e.pageY-tempY}

	 // N4.moveBy( e.pageX-tempX,e.pageY-tempY);
      return false;
    }
  }
  N4.onmouseup=function(){
   // N4.releaseEvents(Event.MOUSEMOVE);
  }
}

function hideMe(layer){
	
  if (document.layers) document.layers[layer].visibility = 'hide';
   	else if (document.all)  	document.all[layer].style.visibility = 'hidden';
  		else if (document.getElementById) document.getElementById(layer).style.visibility = 'hidden'; 
}

function showMe(layer){
  if (document.layers) document.layers[layer].visibility = 'show';
   	else if (document.all)  	document.all[layer].style.visibility = 'visible';
  		else if (document.getElementById) document.getElementById(layer).style.visibility = 'visible';   	
}

document.onmousedown=ddInit;
document.onmouseup=Function("ddEnabled=false");

function loginTrue()
{
	document.formulario.submit();
}

function enviar() {
	var mensaje = validarForma();
	if (mensaje.length == 0) {
		document.frmLogin.submit();	
	} else {
		alert(mensaje);
	}
}

function limpiar() {
	document.frmLogin.krd.value = "";
	document.frmLogin.drd.value = "";	
}
