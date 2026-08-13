import 'package:digimon/controller/cubit/data_cubit.dart';
import 'package:digimon/controller/cubit/data_state.dart';
import 'package:digimon/widgets/digimon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digimon/widgets/custom_page_controller.dart';
import 'package:digimon/widgets/custom_search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DataCubit>().fetchDigimons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'DIGIMON',
            style: GoogleFonts.bubblegumSans(
              color: const Color(0xFF6B700E),
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Column(
          children: [
            const SizedBox(height: 10),
            CustomSearchField(),
            const SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFFDB2515),
                backgroundColor: Colors.white,
                onRefresh: () async {
                  await context.read<DataCubit>().fetchDigimons();
                },
                child: BlocBuilder<DataCubit, DataState>(
                  builder: (context, state) {
                    if (state is DataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    } else if (state is DataError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else if (state is DataLoaded) {
                      final digimons = state.data;

                      if (digimons.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NO DIGIMON FOUND',
                              style: GoogleFonts.bubblegumSans(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 20),
                            Image.asset(
                              "images/sad_digimon.png",
                              fit: BoxFit.fitHeight,
                              height: 150,
                            ),
                          ],
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 24,
                              childAspectRatio: 0.85,
                            ),
                        itemCount: digimons.length,
                        itemBuilder: (context, index) {
                          final digimon = digimons[index];
                          final isSelected = state.selectedName == digimon.name;

                          return GestureDetector(
                            onTap: () {
                              context.read<DataCubit>().selectCard(
                                digimon.name,
                              );
                            },
                            child: DigimonCard(
                              data: digimon,
                              isSelected: isSelected,
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
            const CustomPageController(),

            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
