import 'package:flutter/material.dart';

Widget tresPuntos() { //este es para el icono de hamburguesa de 3 puntos
  return PopupMenuButton<String>(
    onSelected: handleClick,
    itemBuilder: (BuildContext context) {
      return ['Configuraciones'].map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }).toList();
    },
  );
}

void handleClick(String value) {
  switch (value) {
    case 'Configuraciones':
      //aca pondras la lógica al dar tap en configuraciones
      break;
  }
}

Icon convertirStringIcono(String icono){
  switch (icono) {
    case "favorite":
      return Icon(Icons.favorite);
      break;
    case "fastfood":
      return Icon(Icons.fastfood);
    default:
      return Icon(Icons.favorite_border);
  }
}

void mostrarAlerta(mensaje, context){
  showDialog(context: context,barrierDismissible: true,
  builder: (BuildContext context){
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(mensaje),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(mensaje+"\n\n"),
          Image.asset('assets/imagenes/alert.png',width: 100,height: 100,)
        ],
      ),
      actions: <Widget>[
        FlatButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
      ],
    );
  });
}