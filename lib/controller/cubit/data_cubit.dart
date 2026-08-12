// import 'package:digimon/api/digimon_api.dart';
// import 'package:digimon/model/digimon_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'data_state.dart';
//
// class DataCubit extends Cubit<DataState> {
//   final DigimonApi digimonApi;
//   DataCubit(this.digimonApi) : super(const DataLoading());
//
//   List<DigimonModel> _allDigimons = [];
//   List<DigimonModel> _displayedDigimons = [];
//   List<DigimonModel> _searchedDigimons = [];
//   bool _isSearching = false;
//   void setSearching(bool value) {
//     _isSearching = value;
//   }
//
//   int _currentPage = 1;
//   final int _itemsPerPage = 10;
//   String? _selectedDigimonName;
//
//   int get currentPage => _currentPage;
//   int get lastPage => (_allDigimons.length / _itemsPerPage).ceil();
//
//   Future<void> fetchDigimons() async {
//     emit(const DataLoading());
//     try {
//       _allDigimons = await digimonApi.getDigimons();
//       _currentPage = 1;
//       _displayedDigimons = _allDigimons.take(_itemsPerPage).toList();
//       _searchedDigimons = _allDigimons;
//       emit(
//         DataLoaded(
//           data: _displayedDigimons,
//           selectedName: _selectedDigimonName,
//         ),
//       );
//     } catch (e) {
//       emit(DataError('Failed to fetch Digimons: $e'));
//     }
//   }
//
//   Future<void> nextPage() async {
//     if (state is DataLoading) return;
//
//     if (_currentPage < lastPage) {
//       emit(const DataLoading());
//       await Future.delayed(const Duration(milliseconds: 300));
//       _currentPage++;
//
//       _displayedDigimons = _allDigimons
//           .skip((_currentPage - 1) * _itemsPerPage)
//           .take(_itemsPerPage)
//           .toList();
//
//       emit(
//         DataLoaded(
//           data: _displayedDigimons,
//           selectedName: _selectedDigimonName,
//         ),
//       );
//     }
//   }
//
//   Future<void> previousPage() async {
//     if (state is DataLoading) return;
//     if (_isSearching) {}
//     if (_currentPage > 1) {
//       emit(const DataLoading());
//       await Future.delayed(const Duration(milliseconds: 300));
//       _currentPage--;
//
//       _displayedDigimons = _allDigimons
//           .skip((_currentPage - 1) * _itemsPerPage)
//           .take(_itemsPerPage)
//           .toList();
//
//       emit(
//         DataLoaded(
//           data: _displayedDigimons,
//           selectedName: _selectedDigimonName,
//         ),
//       );
//     }
//   }
//
//   void searchDigimon(String query) {
//     setSearching(true);
//     // if (query.isEmpty) {
//     //   _displayedDigimons = _allDigimons
//     //       .skip((_currentPage - 1) * _itemsPerPage)
//     //       .take(_itemsPerPage)
//     //       .toList();
//     // } else {
//     //   _displayedDigimons = _allDigimons.where((digimon) {
//     //     return digimon.name.toLowerCase().contains(query.toLowerCase());
//     //   }).toList();
//     // }
//     //
//     // emit(
//     //   DataLoaded(data: _displayedDigimons, selectedName: _selectedDigimonName),
//     // );
//
//     if (query.isEmpty) {
//       _searchedDigimons = _allDigimons
//           .skip((_currentPage - 1) * _itemsPerPage)
//           .take(_itemsPerPage)
//           .toList();
//     } else {
//       _searchedDigimons = _allDigimons
//           .where((digimon) {
//             return digimon.name.toLowerCase().contains(query.toLowerCase());
//           })
//           .take(_itemsPerPage)
//           .toList();
//     }
//     setSearching(false);
//   }
//
//   void selectCard(String name) {
//     _selectedDigimonName = name;
//
//     if (state is DataLoaded) {
//       emit(
//         DataLoaded(
//           data: _displayedDigimons,
//           selectedName: _selectedDigimonName,
//         ),
//       );
//     }
//   }
// }
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
      emit(DataError('Failed to fetch Digimons: $e'));
    }
  }

  Future<void> nextPage() async {
    if (state is DataLoading) return;

    if (_currentPage < lastPage) {
      emit(const DataLoading());
      await Future.delayed(const Duration(milliseconds: 300));
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
      await Future.delayed(const Duration(milliseconds: 300));
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

  void searchDigimon(String query) {
    if (query.isEmpty) {
      _activeDigimons = _allDigimons;
    } else {
      _activeDigimons = _allDigimons.where((digimon) {
        return digimon.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    _currentPage = 1;

    _displayedDigimons = _activeDigimons.take(_itemsPerPage).toList();

    emit(
      DataLoaded(data: _displayedDigimons, selectedName: _selectedDigimonName),
    );
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
}
