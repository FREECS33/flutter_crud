import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud/presentation/screens/post_model_screen.dart';
import 'package:flutter_crud/presentation/screens/update_model_screen.dart';
import '../../data/repository/model_repository.dart';
import '../cubit/model_cubit.dart';
import '../cubit/model_state.dart';

class ModelListView extends StatelessWidget {
  const ModelListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModelCubit(
        modelRepository: RepositoryProvider.of<ModelRepository>(context),
      )..fetchAllModels(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Model List'),
        ),
        body: const ModelListScreen(),
      ),
    );
  }
}

class ModelListScreen extends StatelessWidget {
  const ModelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modelCubit = BlocProvider.of<ModelCubit>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            modelCubit.fetchAllModels();
          },
          child: const Text('Fetch Models'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateModelScreen(),
              ),
            );
          },
          child: const Text('Add Model'),
        ),
        Expanded(
          child: BlocBuilder<ModelCubit, ModelState>(
            builder: (context, state) {
              if (state is ModelLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ModelSuccess) {
                final models = state.models;
                return ListView.builder(
                  itemCount: models.length,
                  itemBuilder: (context, index) {
                    final model = models[index];
                    return ListTile(
                      title: Text(model.marca),
                      subtitle: Text(model.modelo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateModelScreen(
                                        model: model,
                                      ),
                                    ));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Confirmación"),
                                        content: const Text(
                                            "Estas seguro de eliminar este elemento?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text("Eliminar")),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Cancelar'),
                                          ),
                                        ],
                                      );
                                    });
                                if (confirm ?? false) {
                                  await modelCubit.deleteModel(model.idModel);
                                  modelCubit.fetchAllModels();
                                }
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                );
              } else if (state is ModelError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(
                  child: Text('Press the button to fetch models'));
            },
          ),
        ),
      ],
    );
  }
}
