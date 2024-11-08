import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonAzul({
    Key? key, // El parámetro 'key' ahora es opcional.
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor:
            Colors.blue.withOpacity(0.5), // Para emular highlightElevation
        backgroundColor: Colors.blue, // Fondo azul
        shape: StadiumBorder(), // Forma del botón con bordes redondeados
      ),
      onPressed: () => this.onPressed(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
