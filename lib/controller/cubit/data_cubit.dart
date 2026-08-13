import 'package:digimon/api/digimon_api.dart';
import 'package:digimon/model/digimon_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this.digimonApi) : super(const DataLoading());
  final DigimonApi digimonApi;

  List<DigimonModel> _allDigimons = []; //all digimons fetched from API.

  List<DigimonModel> _activeDigimons =
      []; //might be =_allDigimons or searched digimons.

  List<DigimonModel> _displayedDigimons = []; //only 10

  int _currentPage = 1;
  final int _itemsPerPage = 10;
  String? _selectedDigimonName;

  int get currentPage => _currentPage;
  int get lastPage => _activeDigimons.isEmpty
      ? 1
      : (_activeDigimons.length / _itemsPerPage).ceil();

  Future<void> fetchDigimons() async {
    emit(const DataLoading());
    try {
      _allDigimons = await digimonApi.getDigimons();
      _activeDigimons = _allDigimons;
      _currentPage = 1;
      _displayedDigimons = _activeDigimons.take(_itemsPerPage).toList();
      emit(
        DataLoaded(
          data: _displayedDigimons,
          selectedName: _selectedDigimonName,
        ),
      );
    } catch (e) {
      final cleanMessage = e.toString().replaceAll('Exception: ', '');
      print("--- [DataCubit] Error fetching Digimons: $e ---");
      emit(DataError(cleanMessage));
    }
  }

  Future<void> searchDigimon(String query) async {
    if (query.isEmpty) {
      _activeDigimons = _allDigimons;
    } else {
      try {
        emit(const DataLoading());
        _activeDigimons = await digimonApi.searchBynameAndLevel(query);
      } catch (e) {
        final cleanMessage = e.toString().replaceAll('Exception: ', '');
        print("--- [DataCubit] Error searching Digimons: $e ---");
        emit(DataError(cleanMessage));
        return;
      }
    }
    _currentPage = 1;
    _displayedDigimons = _activeDigimons.take(_itemsPerPage).toList();

    emit(
      DataLoaded(data: _displayedDigimons, selectedName: _selectedDigimonName),
    );
  }

  Future<void> nextPage() async {
    if (state is DataLoading) return;
    if (_currentPage != 0 && _currentPage < lastPage) {
      emit(const DataLoading());
      // await Future.delayed(const Duration(milliseconds: 300));
      _currentPage++;

      _displayedDigimons = _activeDigimons
          .skip((_currentPage - 1) * _itemsPerPage)
          .take(_itemsPerPage)
          .toList();

      emit(
        DataLoaded(
          data: _displayedDigimons,
          selectedName: _selectedDigimonName,
        ),
      );
    }
  }

  Future<void> previousPage() async {
    if (state is DataLoading) return;

    if (_currentPage > 1) {
      emit(const DataLoading());
      // await Future.delayed(const Duration(milliseconds: 300));
      _currentPage--;

      _displayedDigimons = _activeDigimons
          .skip((_currentPage - 1) * _itemsPerPage)
          .take(_itemsPerPage)
          .toList();

      emit(
        DataLoaded(
          data: _displayedDigimons,
          selectedName: _selectedDigimonName,
        ),
      );
    }
  }

  void selectCard(String name) {
    _selectedDigimonName = name;

    if (state is DataLoaded) {
      emit(
        DataLoaded(
          data: _displayedDigimons,
          selectedName: _selectedDigimonName,
        ),
      );
    }
  }

  void clearSearch() {
    if (_activeDigimons.length == _allDigimons.length) return;
    _activeDigimons = _allDigimons;
    _currentPage = 1;
    _displayedDigimons = _activeDigimons.take(_itemsPerPage).toList();

    emit(
      DataLoaded(data: _displayedDigimons, selectedName: _selectedDigimonName),
    );
  }
}
