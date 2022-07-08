import 'package:app_ui/app_ui.dart';
import 'package:fitness/dashboard/dashboard.dart';
import 'package:fitness/home/home.dart';
import 'package:fitness/l10n/l10n.dart';
import 'package:fitness/weight_tracking/cubit/weight_tracking_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:measurements_repository/measurements_repository.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DashboardCubit>().state;
    final textScale = MediaQuery.of(context).textScaleFactor;
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.only(bottom: 140),
      children: [
        const SizedBox(height: 100),
        JumboLabel(l10n.motivationalLabel).paddedH(28),
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
        HeaderLabel(l10n.yourAreas).paddedH(32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardCard(
                    title: l10n.allStats,
                    subtitle: l10n.allStatsSubtitle,
                    color: AppColors.lightGrey,
                    onTap: () {
                      context.read<HomeCubit>().setPage(HomeSelection.activity);
                    },
                  ),
                  DashboardCard(
                    title: l10n.steps,
                    subtitle: l10n.stepsCount(state.steps),
                    emoji: '🚶‍♂️',
                    color: AppColors.blueBackground,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DashboardCard(
                    title: '🗓 ${DateFormat.MEd().format(state.selectedDate)}',
                    color: AppColors.blueBackground,
                  ),
                  DashboardCard(
                    title: l10n.weight,
                    value: state.weight.toStringAsFixed(1),
                    valueUnit: 'kg',
                    color: AppColors.yellowBackground,
                    onTap: () {
                      AppBottomSheet.present<void>(
                        context,
                        child: BlocProvider(
                          create: (context) => WeightTrackingCubit(
                            context.read<MeasurementsRepository>(),
                          ),
                          child: Builder(builder: (context) {
                            return WeightSelectionLayout(
                              initialWeight: state.weight,
                              onSubmitted: (value) {
                                context
                                    .read<WeightTrackingCubit>()
                                    .addWeight(value);
                              },
                              onChanged: (value) {},
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    title: l10n.workout,
                    subtitle: l10n.addSession,
                    emoji: '🏋️‍♂️',
                    color: AppColors.pinkBackground,
                  ),
                ],
              ),
            ),
          ],
        ).paddedH(24),
      ],
    );
  }
}

extension on Widget {
  Widget paddedH(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  Widget paddedV(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }
}
