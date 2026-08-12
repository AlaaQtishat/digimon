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
                ? const Color(0xFFDB2515).withOpacity(0.77)
                : const Color(0xFF646A0D).withOpacity(0.9),
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
            style: GoogleFonts.bubblegumSans(fontSize: 32, color: Colors.black),
          ),
          Image.network(data.img, height: 200, width: 200, fit: BoxFit.cover),
          Text(
            data.level.toUpperCase(),
            style: GoogleFonts.bubblegumSans(fontSize: 32, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
