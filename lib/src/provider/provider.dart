import 'package:flutter/material.dart';
import 'package:hojavida/src/bloc/formulario_bloc.dart';

class Provider extends InheritedWidget {
  final FormuBloc = FormularioBloc();
  Provider({Key? key, required Widget child}) : super(key: key, child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static FormularioBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.FormuBloc;
  }
}
