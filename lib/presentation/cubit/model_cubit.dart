import 'package:bloc/bloc.dart';
import '../../data/models/model.dart';
import '../../data/repository/model_repository.dart';
import 'model_state.dart';

class ModelCubit extends Cubit<ModelState> {
  final ModelRepository modelRepository;

  ModelCubit({required this.modelRepository}) : super(ModelInitial());


  Future<void> createModel(Model model) async {
    try {
      emit(ModelLoading());
      await modelRepository.createModel(model);
      final models = await modelRepository.getAllModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> getModel(int id) async {
    try {
      emit(ModelLoading());
      final model = await modelRepository.getModel(id);
      emit(ModelSuccess(models: [model]));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> updateModel(Model model) async {
    try {
      emit(ModelLoading());
      await modelRepository.updateModel(model);
      final models = await modelRepository.getAllModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> deleteModel(int id) async {
    try {
      emit(ModelLoading());
      await modelRepository.deleteModel(id);
      final models = await modelRepository.getAllModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }

  Future<void> fetchAllModels() async {
    try {
      emit(ModelLoading());
      final models = await modelRepository.getAllModels();
      emit(ModelSuccess(models: models));
    } catch (e) {
      emit(ModelError(message: e.toString()));
    }
  }
}