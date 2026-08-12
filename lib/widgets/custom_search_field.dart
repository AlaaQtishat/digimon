import 'package:digimon/controller/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatefulWidget {
  CustomSearchField({super.key});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                context.read<DataCubit>().searchDigimon(value);
                FocusScope.of(context).unfocus();
              },

              decoration: InputDecoration(
                hintText: 'DIGIMON NAME',
                hintStyle: GoogleFonts.bubblegumSans(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFFDB2515), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF0084C6), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey, size: 18),
                  onPressed: () {
                    searchController.clear();
                    context.read<DataCubit>().fetchDigimons();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xFFDB2515), width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<DataCubit>().searchDigimon(searchController.text);
              FocusScope.of(context).unfocus();
            },
            child: Image.asset('images/search.png', width: 24, height: 24),
          ),
        ],
      ),
    );
  }
}
