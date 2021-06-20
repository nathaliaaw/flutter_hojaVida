import 'package:hojavida/src/preferencias/preferencias_formulario.dart';
import 'package:rxdart/rxdart.dart';

class FormularioBloc {
  static final prefs = PreferenciaFormulario();
  final _nombresController = BehaviorSubject<String>.seeded(prefs.nombres);
  final _apellidosController = BehaviorSubject<String>.seeded(prefs.apellidos);
  final _descripcionController =
      BehaviorSubject<String>.seeded(prefs.descripcion);
  final _emailController = BehaviorSubject<String>.seeded(prefs.email);
  final _telefonoController = BehaviorSubject<String>.seeded(prefs.telefono);
  final _linkhvController = BehaviorSubject<String>.seeded(prefs.linkhv);
  final _linkfotoperfilController =
      BehaviorSubject<String>.seeded(prefs.linkfotoperfil);

  Stream<String> get nombresStream => _nombresController.stream;
  Function(String) get changenombres => _nombresController.sink.add;

  Stream<String> get apellidosStream => _apellidosController.stream;
  Function(String) get changeapellidos => _apellidosController.sink.add;

  Stream<String> get descripcionStream => _descripcionController.stream;
  Function(String) get changedescripcion => _descripcionController.sink.add;

  Stream<String> get emailStream => _emailController.stream;
  Function(String) get changeemail => _emailController.sink.add;

  Stream<String> get telefonoStream => _telefonoController.stream;
  Function(String) get changetelefono => _telefonoController.sink.add;

  Stream<String> get linkhvStream => _linkhvController.stream;
  Function(String) get changelinkhv => _linkhvController.sink.add;

  Stream<String> get linkfotoperfilStream => _linkfotoperfilController.stream;
  Function(String) get changelinkfotoperfil =>
      _linkfotoperfilController.sink.add;

String get nombres => _nombresController.value;
String get apellidos => _apellidosController.value;
String get descripcion => _descripcionController.value;
String get email => _emailController.value;
String get telefono => _telefonoController.value;
String get linkhv => _linkhvController.value;
String get linkfotoperfil => _linkfotoperfilController.value;

  Stream<bool> get validarboton => CombineLatestStream.combine7(
      nombresStream,
      apellidosStream,
      descripcionStream,
      emailStream,
      telefonoStream,
      linkhvStream,
      linkfotoperfilStream,
      (n, p, d, e, t, l, f) => true);


  dispose() {
    _nombresController.close();
    _apellidosController.close();
    _descripcionController.close();
    _emailController.close();
    _telefonoController.close();
    _linkhvController.close();
    _linkfotoperfilController.close();
  }
}
