import 'dart:io';

import 'package:amecanico/3-Controlador/ImagenControlador.dart';
import 'package:amecanico/3-Controlador/clientesC.dart';
import 'package:flutter/material.dart';
import '../../1-Modelo/Cliente.dart';
import '../../1-Modelo/Coche.dart';

//throw error
class IngresarCarro extends StatefulWidget {
  final Cliente cliente;
  final bool seGuardara;
  const IngresarCarro(
      {super.key, required this.cliente, required this.seGuardara});

  @override
  State<IngresarCarro> createState() => _IngresarCarroState();
}

class _IngresarCarroState extends State<IngresarCarro> {
  ImageService imagenC = ImageService();
  File? imagen;

  TextEditingController marca = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController anio = TextEditingController();
  TextEditingController motor = TextEditingController();
  TextEditingController vin = TextEditingController();
  TextEditingController km = TextEditingController();
  TextEditingController placas = TextEditingController();
  TextEditingController color = TextEditingController();

  FocusNode marcaFocus = FocusNode();
  FocusNode modeloFocus = FocusNode();
  FocusNode anioFocus = FocusNode();
  FocusNode motorFocus = FocusNode();
  FocusNode vinFocus = FocusNode();
  FocusNode kmFocus = FocusNode();
  FocusNode placasFocus = FocusNode();
  FocusNode colorFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    imagenC.iniciar();
  }

  //aqui esto ponerlo en otro archivo donde esten los metodos del crud de coche

  void agregarCoche() {
    imagenC.guardarImagen().then(
      (value) {
        print('path$value');
        if (value != null) {
          print(value.path);
        }
        Coche coche = Coche(
          marca: marca.text,
          modelo: modelo.text,
          anio: anio.text,
          motor: motor.text,
          vin: vin.text,
          kilometraje: km.text,
          placa: placas.text,
          imagen: value == null ? '' : value.path,
          color: color.text,
        );

        if (widget.seGuardara) {
          print('opcion 1');
          // Ccliente().agregarCocheACliente(widget.cliente, coche);
          Navigator.pop(context);
        } else {
          print('opcion 2');
          widget.cliente.coches.add(coche);
          Navigator.pop(context, coche);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresa el vehiculo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Cliente: ${widget.cliente.nombre}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Imagen del coche'),
                        //aqui hacer un metodo aparte para obtener imagen si la imagen existe
                        content: imagen != null
                            ? Image.file(imagen!)
                            : const Text('No hay imagen'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300],
                      //igual aqui hacer metodo para saber si la ijmagen existe
                      image: imagen != null
                          ? DecorationImage(
                              image: FileImage(imagen!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    //aqui tambien
                    child: imagen != null
                        ? null
                        : Icon(
                            Icons.camera_alt_rounded,
                            size: 70,
                            color: Colors.grey[700],
                          ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      imagen == null
                          ? const SizedBox()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //esto hacer en un crud de imagen
                                      imagen = null;
                                      imagenC.imagenX = null;
                                      setState(() {});
                                    },
                                    child: const Text('Limpiar imagen'),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            //crud de imagen
                            imagenC.tomarImagen().then((value) {
                              imagen = value;
                              setState(() {});
                            });
                          },
                          child: const Text('Tomar foto'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            //crud de imagen c
                            imagenC.imagenDeGaleria().then((value) {
                              imagen = value;
                              setState(() {});
                            });
                          },
                          child: const Text(
                            'Seleccionar foto de galeria',
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              focusNode: marcaFocus,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(modeloFocus);
              },
              controller: marca,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Marca',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: modeloFocus,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(anioFocus);
                    },
                    controller: modelo,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Modelo',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    focusNode: anioFocus,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(motorFocus);
                    },
                    controller: anio,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Año',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: motorFocus,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(vinFocus);
              },
              controller: motor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Motor',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: vinFocus,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(kmFocus);
              },
              controller: vin,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vin',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: kmFocus,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(placasFocus);
              },
              controller: km,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kilometraje',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: placasFocus,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(colorFocus);
                // agregarCoche();
              },
              controller: placas,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placas',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onSubmitted: (value) {
                agregarCoche();
                FocusScope.of(context).unfocus();
              },
              focusNode: colorFocus,
              controller: color,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Color',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarCoche,
        child: const Icon(Icons.done),
      ),
    );
  }
}
