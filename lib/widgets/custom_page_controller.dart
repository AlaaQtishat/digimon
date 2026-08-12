import 'package:digimon/controller/cubit/data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPageController extends StatelessWidget {
  const CustomPageController({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPage = context.watch<DataCubit>().currentPage;
    int lastPage = context.watch<DataCubit>().lastPage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            IconButton(
              onPressed: currentPage > 1
                  ? () {
                      context.read<DataCubit>().previousPage();
                    }
                  : null,
              icon: const Icon(Icons.arrow_back_rounded),
              color: const Color(0xFF4A5568),
            ),
            const SizedBox(width: 12),
            VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1.5,
              width: 1,
              indent: 8,
              endIndent: 8,
            ),
            Expanded(
              child: Center(
                child: Text(
                  '$currentPage',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            VerticalDivider(
              color: Colors.grey.shade300,
              thickness: 1.5,
              width: 1,
              indent: 8,
              endIndent: 8,
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: currentPage < lastPage
                  ? () {
                      context.read<DataCubit>().nextPage();
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward_rounded),
              color: const Color(0xFF4A5568),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
