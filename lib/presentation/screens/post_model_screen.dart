import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/model.dart';
import '../cubit/model_cubit.dart';
import '../cubit/model_state.dart';

class CreateModelScreen extends StatefulWidget {
  const CreateModelScreen({super.key});

  @override
  _CreateModelScreenState createState() => _CreateModelScreenState();
}

class _CreateModelScreenState extends State<CreateModelScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _capacidadController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Model'),
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
                        final model = Model(
                          idModel: 0,
                          marca: _marcaController.text,
                          modelo: _modeloController.text,
                          capacidadAgua: double.parse(_capacidadController.text),
                          tipo: _tipoController.text,
                        );
                        BlocProvider.of<ModelCubit>(context).createModel(model);
                      }
                    },
                    child: const Text('Create Model'),
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
