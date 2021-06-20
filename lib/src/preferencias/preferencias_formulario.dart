import 'package:shared_preferences/shared_preferences.dart';

class PreferenciaFormulario {
  static final PreferenciaFormulario _instancia =
      PreferenciaFormulario.internal();
  factory PreferenciaFormulario() {
    return _instancia;
  }
  PreferenciaFormulario.internal();
  SharedPreferences? _prefs;
  iniciarPreferencias() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get nombres {
    return _prefs?.getString('nombres') ?? 'Sin información';
  }

  set nombres(String valor) {
    _prefs?.setString('nombres', valor);
  }

  String get apellidos {
    return _prefs?.getString('apellidos') ?? 'Sin información';
  }

  set apellidos(String valor) {
    _prefs?.setString('apellidos', valor);
  }

  String get descripcion {
    return _prefs?.getString('descripcion') ?? 'Sin información';
  }

  set descripcion(String valor) {
    _prefs?.setString('descripcion', valor);
  }

  String get email {
    return _prefs?.getString('email') ?? 'Sin información';
  }

  set email(String valor) {
    _prefs?.setString('email', valor);
  }

  String get telefono {
    return _prefs?.getString('telefono') ?? 'Sin información';
  }

  set telefono(String valor) {
    _prefs?.setString('telefono', valor);
  }

  String get linkhv {
    return _prefs?.getString('linkhv') ?? '';
  }

  set linkhv(String valor) {
    _prefs?.setString('linkhv', valor);
  }

  String get linkfotoperfil { 
    return _prefs?.getString('linkfotoperfil') ?? 'https://i.pinimg.com/236x/f1/f5/15/f1f5153cabe32239c85842fb4d0ba3c8--ps.jpg';
  }

  set linkfotoperfil(String valor) { 
    _prefs?.setString('linkfotoperfil', valor);
  }
   int get autoincreArchivos {
    return _prefs?.getInt('autoincreArchivos') ?? 1;
  } 

  set autoincreArchivos(int valor) {
    _prefs?.setInt('autoincreArchivos', valor+1);
  }
}
