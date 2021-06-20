import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hojavida/src/bloc/formulario_bloc.dart';
import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
// import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
import 'package:hojavida/src/provider/provider.dart';
import 'package:hojavida/src/servicios/serviciosFirebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FormulaPage extends StatefulWidget {
  FormulaPage({Key? key}) : super(key: key);

  @override
  _FormulaPageState createState() => _FormulaPageState();
}

class _FormulaPageState extends State<FormulaPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();
  String rutaImagen = '';
  OutlineInputBorder borderInput =
      OutlineInputBorder(borderRadius: BorderRadius.circular(20));
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cuerpo(),
    );
  }

  _cuerpo() {
    _borrardatos();
    final bloc = Provider.of(context);
    return SafeArea(
        child: ListView(children: [
      Container(
        padding: EdgeInsets.all(20),
        // color: Colors.greenAccent,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              Text('Formulario de Datos', style: TextStyle(fontSize: 30)),
              _espacio(),
              _nombre(bloc),
              _espacio(),
              _apellidos(bloc),
              _espacio(),
              _descripcion(bloc),
              _espacio(),
              _email(bloc),
              _espacio(),
              _telefono(bloc),
              _espacio(),
              _cargarArchivos(bloc),
              _espacio(),
              _botonDatos(bloc)
            ],
          ),
        ),
      ),
    ]));
  }

  _espacio() {
    return SizedBox(
      height: 12,
    );
  }

  _borrardatos() {
    final prefs = PreferenciaFormulario();
    prefs.nombres = '';
    prefs.apellidos = '';
    prefs.descripcion = '';
    prefs.email = '';
    prefs.telefono = '';
  }

  _nombre(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.nombresStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            initialValue: bloc.nombres=='Sin información'?'':bloc.nombres,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
                border: borderInput,
                errorText: snapshot.error?.toString()),
            onChanged: bloc.changenombres,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el nombre';
              }
              return null;
            },
          );
        });
  }

  _apellidos(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.apellidosStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            initialValue:  bloc.apellidos=='Sin información'?'':bloc.apellidos,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Apellido',
                hintText: 'Ingrese su apellido',
                border: borderInput,
                errorText: snapshot.error?.toString()),
            onChanged: bloc.changeapellidos,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el apellido';
              }
              return null;
            },
          );
        });
  }

  _descripcion(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.descripcionStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            initialValue:bloc.descripcion=='Sin información'?'':bloc.descripcion,
            keyboardType: TextInputType.text,
            maxLines: 8,
            decoration: InputDecoration(
                labelText: 'Descripcion',
                hintText: 'Ingrese su descripcion del perfil',
                border: borderInput,
                errorText: snapshot.error?.toString()),
            onChanged: bloc.changedescripcion,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese la descripción';
              }
              return null;
            },
          );
        });
  }

  _email(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            initialValue:bloc.email=='Sin información'?'':bloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Ingrese su email',
                border: borderInput,
                errorText: snapshot.error?.toString()),
            onChanged: bloc.changeemail,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el correo';
              }
              return null;
            },
          );
        });
  }

  _telefono(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.telefonoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return TextFormField(
            initialValue: bloc.telefono=='Sin información'?'':bloc.telefono,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Teléfono',
                hintText: 'Ingrese su teléfono',
                border: borderInput,
                errorText: snapshot.error?.toString()),
            onChanged: bloc.changetelefono,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el telefono';
              }
              return null;
            },
          );
        });
  }

  _linkhv(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.linkhvStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return IconButton(
              icon: Icon(
                Icons.archive_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                bloc.changelinkhv;
              });
        });
  }

  _linkfotoperfil(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.linkfotoperfilStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                _bottonVentana(context, bloc);
              });
        });
  }

  _botonDatos(FormularioBloc bloc) {
    return StreamBuilder(
        stream: bloc.validarboton,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ElevatedButton(
              onPressed: snapshot.hasData ? () => _ingresardata(bloc) : null,
              child: Text("Registrar"));
        });
  }

  _ingresardata(FormularioBloc bloc) {
    final prefs = new PreferenciaFormulario();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      Navigator.pushNamed(context, 'hojaVida');
    }
    prefs.nombres = bloc.nombres;
    prefs.apellidos = bloc.apellidos;
    prefs.descripcion = bloc.descripcion;
    prefs.email = bloc.email;
    prefs.telefono = bloc.telefono;
    // prefs.linkhv = bloc.linkhv;
    // prefs.linkfotoperfil = bloc.linkfotoperfil;
    // print('*********************************');
    // print(prefs.linkhv);
    // print('*********************************');

    // Navigator.pushNamed(context, 'hojaVida');
  }

  void _bottonVentana(BuildContext ctx, FormularioBloc bloc) {
    showModalBottomSheet(
        // isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => getImage(1, bloc),
                        icon: Icon(Icons.photo_size_select_actual),
                      ),
                      Text('Galeria')
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => getImage(2, bloc),
                          icon: Icon(Icons.camera_alt)),
                      Text('Camara')
                    ],
                  ),
                ],
              ),
            ));
  }

  _cargarArchivos(FormularioBloc bloc) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                color: Colors.black87,
                minWidth: size.width * 0.8,
                onPressed: () => _bottonVentana(context, bloc),
                child: Container(
                  child: Row(
                    children: [
                      _linkfotoperfil(bloc),
                      Text(
                        'Cargar foto',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          ],
        ),
        _espacio(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                color: Colors.black87,
                minWidth: size.width * 0.8,
                onPressed: () {
                  setState(() {
                    _cargarArchivosCualquiera();
                  });
                },
                child: Container(
                  child: Row(
                    children: [
                      _linkhv(bloc),
                      Text(
                        'Cargar hoja de vida',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Future getImage(int imagen, FormularioBloc bloc) async {
    // final prefs= PreferenciaFormulario();
    final pickedFile1;
    if (imagen == 1) {
      pickedFile1 = await picker.getImage(source: ImageSource.gallery);
    } else {
      pickedFile1 = await picker.getImage(source: ImageSource.camera);
    }
    final pickedFile = pickedFile1;

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        rutaImagen = pickedFile.path;
        _image = File(pickedFile.path);
        final servicio = ServicioFirebase();
        servicio.cargarArchivo(_image, 1);
        bloc.changelinkfotoperfil;
        Navigator.pop(context);
      } else {
        print('No image selected.');
      }
    });
  }

  void _cargarArchivosCualquiera() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path as String);
      final servicio = ServicioFirebase();
      servicio.cargarArchivo(file, 2);
    } else {
      print('No file selected.');
    }
  }
}
