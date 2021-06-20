import 'dart:convert';

import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
import 'package:hojavida/src/provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;


class ServicioFirebase {
  Future<String> cargarArchivo(var archivo,int tipoArchivo) async {

    final prefs= PreferenciaFormulario();
    prefs.autoincreArchivos=prefs.autoincreArchivos;
    int consecutivo=prefs.autoincreArchivos;
    // consecutivo=consecutivo++;
    final url = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/semillero-2b625.appspot.com/o?name=Upload/semillero/'+ consecutivo.toString());

    final tipoImagen = mime(archivo.path)!.split('/');

    final subidaImagen = http.MultipartRequest(
      'POST',
      url,
    );

    final img = await http.MultipartFile.fromPath('file', archivo.path,
        contentType: MediaType(tipoImagen[0], tipoImagen[1]));

    subidaImagen.files.add(img);

    final peticion = await subidaImagen.send();

    final respuesta = await http.Response.fromStream(peticion);

    final datos = json.decode(respuesta.body);

    String urlenvio= 'https://firebasestorage.googleapis.com/v0/b/semillero-2b625.appspot.com/o/Upload%2Fsemillero%2F$consecutivo?alt=media&token=${datos['downloadTokens']}';
    if(tipoArchivo==1){
      prefs.linkfotoperfil=urlenvio;
    }
    else{
      prefs.linkhv=urlenvio;
    }

    return urlenvio;
  }
}