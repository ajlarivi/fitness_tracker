import 'package:app_ui/app_ui.dart';
import 'package:fitness/dashboard/dashboard.dart';
import 'package:fitness/home/home.dart';
import 'package:fitness/l10n/l10n.dart';
import 'package:fitness/steps/steps.dart';
import 'package:fitness/weight_tracking/weight_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:drop_shadow/drop_shadow.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    final textScale = MediaQuery.of(context).textScaleFactor;
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.only(bottom: 200),
      children: [
        const Gap(100),
        JumboLabel(l10n.dashboardTitle).paddedH(28),
        SizedBox(
          height: 70 * textScale,
          child: HorizontalCalendarListView(
            startDate: state.startDate,
            selectedDate: state.selectedDate,
            onTap: (date) {
              context.read<DashboardCubit>().selectDate(date);
            },
          ),
        ).paddedV(16),
        Row(
          children: [
            DashboardCard(
                title: '${DateFormat.MEd().format(state.selectedDate)}',
                color: Theme.of(context).colorScheme.primaryContainer
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 150),
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.medication,
                size: 48,
              ),
            ),
          ],
        )

      ],
    );
  }
}
