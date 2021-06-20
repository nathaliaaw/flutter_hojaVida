import 'package:flutter/material.dart';
import 'package:hojavida/src/pages/formulario_page.dart';
import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';

class HojaVidaPage extends StatefulWidget {
  HojaVidaPage({Key? key}) : super(key: key);

  @override
  _HojaVidaPageState createState() => _HojaVidaPageState();
}

class _HojaVidaPageState extends State<HojaVidaPage> {
  //  final prefs =PreferenciaFormulario();
  final _url = 'https://flutter.dev';
  Color colorFondo = HexColor("#E6D7C2");
  @override
  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciaFormulario();
    return Scaffold(body: _cuerpo());
  }

  _cuerpo() {
    // const Color(0xffaabbcc).toHex();
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          color: colorFondo,
          // width: size.width,
          height: size.height,
          child: Row(children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 25),
                  child: Container(
                    color: HexColor("#BB4B3C"),
                    width: size.width * 0.30,
                  ),
                ),
                _columna1()
              ],
            ),
            _columna2(),
          ])),
    );
  }

  _columna2() {
    final prefs = PreferenciaFormulario();
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.checklist_sharp),
                  onPressed: () {
                    Navigator.pushNamed(context, 'formulario');
                  })
            ],
          ),
        ),
        Container(
          width: size.width * 0.5,
          child: Container(
            margin: EdgeInsets.only(top: 110),
            child: Column(
              children: [
                Text(
                  prefs.apellidos,
                  style: TextStyle(fontSize: 25, color: Colors.green[900]),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  prefs.nombres,
                  style: TextStyle(fontSize: 50, color: Colors.green[900]),
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  prefs.descripcion,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, color: Colors.green[900]),
                )
                // Text('Plazas Moncada',style: TextStyle(fontSize: 15,color: Colors.green),),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _columna1() {
    final prefs = PreferenciaFormulario();
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          'Hoja de vida',
          style: TextStyle(
              fontSize: 20,
              color: Colors.deepOrange[200],
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Diseño Industrial',
          style: TextStyle(
            fontSize: 15,
            color: Colors.deepOrange[200],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: colorFondo,
                  radius: 80.0,
                  child: CircleAvatar(
                    radius: 75.0,
                    backgroundImage: NetworkImage(prefs.linkfotoperfil),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'CONTACTAME',
                  style: TextStyle(fontSize: 15, color: Colors.deepOrange[200]),
                ),
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.deepOrange[200],
                  size: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 15, color: Colors.deepOrange[200]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  prefs.email,
                  style: TextStyle(fontSize: 15, color: Colors.deepOrange[200]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Telefono',
                  style: TextStyle(fontSize: 15, color: Colors.deepOrange[200]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  prefs.telefono,
                  style: TextStyle(fontSize: 15, color: Colors.deepOrange[200]),
                ),
                SizedBox(
                  height: 100,
                ),
                TextButton(
                    // color: Colors.black87,
                    // minWidth: size.width * 0.8,
                    onPressed: _launchURL,
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Ver hoja de vida',
                            style: TextStyle(
                                fontSize: 15, color: Colors.deepOrange[200]),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL() async {
    final prefs = PreferenciaFormulario();
    print(prefs.linkhv);
    print('************************************555555555555555555555***');
    await canLaunch(prefs.linkhv)
        ? await launch(
            prefs.linkhv,
            // forceSafariVC: true,
            // forceWebView: true,
            // enableJavaScript: true,
          )
        : throw 'Could not launch ' + prefs.linkhv;
  }

  // Future<void> _launchURL() async {
  //   final prefs = PreferenciaFormulario();
  //   var url =prefs.linkhv;
  //  if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       enableDomStorage: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


}
