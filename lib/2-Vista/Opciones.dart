import 'package:amecanico/2-Vista/Reporte/AgregarReporte.dart';
import 'package:amecanico/Test/testl.dart';
import 'package:flutter/material.dart';

class Opciones extends StatelessWidget {
  const Opciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EjemploFormulario()),
                  );
                },
                child: Text('Opcion 1')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AfinMayCom()),
                  );
                },
                child: Text('Opcion 2')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Prueba01()),
                  );
                },
                child: Text('Opcion 3')),
          ],
        ),
      ),
    );
  }
}
