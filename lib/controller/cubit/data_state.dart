import 'package:digimon/model/digimon_model.dart';
import 'package:equatable/equatable.dart';

sealed class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataLoading extends DataState {
  const DataLoading();
}

class DataLoaded extends DataState {
  final List<DigimonModel> data;
  final String? selectedName;

  const DataLoaded({required this.data, this.selectedName});

  @override
  List<Object?> get props => [data, selectedName];
}

class DataError extends DataState {
  final String message;

  const DataError(this.message);

  @override
  List<Object> get props => [message];
}
