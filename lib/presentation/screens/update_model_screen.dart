import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/model.dart';
import '../cubit/model_cubit.dart';
import '../cubit/model_state.dart';

class UpdateModelScreen extends StatefulWidget {
  final Model model;

  const UpdateModelScreen({super.key, required this.model});

  @override
  _UpdateModelScreenState createState() => _UpdateModelScreenState();
}

class _UpdateModelScreenState extends State<UpdateModelScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _capacidadController;
  late TextEditingController _tipoController;

  @override
  void initState() {
    super.initState();
    _marcaController = TextEditingController(text: widget.model.marca);
    _modeloController = TextEditingController(text: widget.model.modelo);
    _capacidadController = TextEditingController(text: widget.model.capacidadAgua.toString());
    _tipoController = TextEditingController(text: widget.model.tipo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Model'),
      ),
      body: BlocConsumer<ModelCubit, ModelState>(
        listener: (context, state) {
          if (state is ModelSuccess) {
            Navigator.pop(context);
          }
          if (state is ModelError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _marcaController,
                    decoration: const InputDecoration(labelText: 'Marca'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a brand';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _modeloController,
                    decoration: const InputDecoration(labelText: 'Modelo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a model';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _capacidadController,
                    decoration: const InputDecoration(labelText: 'Capacidad de Agua'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter water capacity';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _tipoController,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a type';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final updatedModel = Model(
                          idModel: widget.model.idModel,
                          marca: _marcaController.text,
                          modelo: _modeloController.text,
                          capacidadAgua: double.parse(_capacidadController.text),
                          tipo: _tipoController.text,
                        );
                        BlocProvider.of<ModelCubit>(context).updateModel(updatedModel);
                      }
                    },
                    child: const Text('Update Model'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
