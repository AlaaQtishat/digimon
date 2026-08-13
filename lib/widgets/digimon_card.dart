import 'package:digimon/constants/app_colors.dart';
import 'package:digimon/model/digimon_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigimonCard extends StatelessWidget {
  DigimonModel data;
  bool isSelected = false;
  DigimonCard({super.key, required this.data, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.primaryRed.withOpacity(0.77)
                : AppColors.primaryYellow.withOpacity(0.9),
            blurRadius: 42,
            spreadRadius: 1,
            offset: const Offset(0, 30),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            data.name.toUpperCase(),
            style: GoogleFonts.bubblegumSans(
              fontSize: 32,
              color: AppColors.primaryColor,
            ),
          ),
          Image.network(
            data.img,
            height: 200,
            width: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: Colors.grey, size: 40),
                    SizedBox(height: 8),
                    Text(
                      'No Internet',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              );
            },

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryRed),
              );
            },
          ),
          Text(
            data.level.toUpperCase(),
            style: GoogleFonts.bubblegumSans(
              fontSize: 32,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
