import 'package:digimon/constants/app_colors.dart';
import 'package:digimon/controller/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController searchController;
  CustomSearchField({super.key, required this.searchController});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  @override
  Widget build(BuildContext context) {
    DataCubit dataCubit = context.read<DataCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextField(
                controller: widget.searchController,
                onSubmitted: (value) {
                  dataCubit.searchDigimon(value);
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'DIGIMON NAME',
                  hintStyle: GoogleFonts.bubblegumSans(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: AppColors.secondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryRed,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey, size: 18),
                    onPressed: () {
                      if (widget.searchController.text.isEmpty) return;
                      widget.searchController.clear();
                      dataCubit.clearSearch();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.primaryRed, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppColors.secondaryColor,
              ),
              onPressed: () {
                if (widget.searchController.text.isEmpty) return;
                dataCubit.searchDigimon(widget.searchController.text);
                FocusScope.of(context).unfocus();
              },
              child: Image.asset('images/search.png', width: 24, height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
