import 'package:flutter/material.dart';
import 'package:utm_vinculacion/modules/database/provider.database.dart';
import 'package:utm_vinculacion/routes/route.names.dart';
import 'package:utm_vinculacion/widgets/components/header.dart';
import 'package:utm_vinculacion/widgets/components/tres_puntos.dart';

import 'model.food.dart';

class Recetas extends StatefulWidget {
   
  final DBProvider dbProvider = DBProvider.db;

  @override
  _RecetasState createState() => _RecetasState();
}

class _RecetasState extends State<Recetas> {

  @override
  void initState() {
    widget.dbProvider.getComidas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(      
      body: Column(
        children: [
          getHeader(context, size, "RECETAS"),
          listaContenido(),
        ],
      )
    );
  }

  Widget listaContenido(){
    return Expanded(
      child: ListView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Mis recetas",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      Navigator.pushNamed(context, ADDPLATOS);
                    }
                  )
                ],
              ),
              StreamBuilder(
                stream: widget.dbProvider.comidaStream,
                builder: (BuildContext context, AsyncSnapshot<List<Comida>> snapshot){
                  
                  if(!snapshot.hasData) return CircularProgressIndicator();
                  if(snapshot.data.isEmpty) return sinDatos();

                  final List<Widget> widgets = new List<Widget>();

                  widgets.addAll(snapshot.data.map((item)=>ListTile(
                    onTap: (){
                      //Aca mando los datos de la comida que desea ver y los muestros en info comida
                      Comida comida = item;
                      Navigator.pushNamed(context, INFO_COMIDA, arguments: comida);
                    },
                    leading: Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: item.urlImagen != null?Image.asset(item.urlImagen):Container()
                    ),
                    title: Text(item.nombre),
                    subtitle: Text(
                      item.preparacion,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Opciones"),
                              content: Text("Seleccione una acción"),
                              actions: [
                                FlatButton.icon(
                                  icon: Icon(Icons.edit),
                                  label: Text("Editar"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(ADDPLATOS, arguments:{
                                      "model_data": item
                                    });
                                  }
                                ),
                                FlatButton.icon(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  label: Text("Eliminar", style: TextStyle(color: Colors.red)),
                                  onPressed: (){
                                    widget.dbProvider.eliminarComida(item);
                                    Navigator.of(context).pop();
                                  }
                                ),

                              ],
                            );
                          }
                        );
                      },
                    ),
                  )).toList());

                  return Column(
                      children: widgets,
                    );
                },
              ),
            ],
        ),
    );
  }
}