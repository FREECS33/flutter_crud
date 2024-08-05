import 'package:equatable/equatable.dart';
import '../../data/models/model.dart';

abstract class ModelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ModelInitial extends ModelState {}

class ModelLoading extends ModelState {}

class ModelSuccess extends ModelState {
  final List<Model> models;

  ModelSuccess({required this.models});

  @override
  List<Object?> get props => [models];
}

class ModelError extends ModelState {
  final String message;

  ModelError({required this.message});

  @override
  List<Object?> get props => [message];
}