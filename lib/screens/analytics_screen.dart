import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bg(context),
      padding: AppTheme.screenPadding,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),

          // 📊 Hero Bento Grid: Efficiency + Distance + Chart
          LayoutBuilder(builder: (ctx, constraints) {
            final isWide = constraints.maxWidth > 700;
            return isWide
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 4, child: _efficiencyCard(ctx)),
                    const SizedBox(width: 16),
                    Expanded(flex: 6, child: Column(children: [_summaryCard(ctx), const SizedBox(height: 16), _weeklyChartCard(ctx)])),
                  ])
                : Column(children: [_efficiencyCard(ctx), const SizedBox(height: 16), _summaryCard(ctx), const SizedBox(height: 16), _weeklyChartCard(ctx)]);
          }),
          const SizedBox(height: 24),

          // 🚗 Recent Trips List
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Recent Trips', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
            Text('View All', style: AppTheme.bodyBold.copyWith(color: AppTheme.primary(context), fontSize: 14)),
          ]),
          const SizedBox(height: 12),
          _tripItem(context, Icons.directions_car, 'Downtown Commute', '12.4 km • 24 min', '88 Efficiency', 'Today, 08:30 AM'),
          const SizedBox(height: 12),
          _tripItem(context, Icons.shopping_bag, 'Weekend Errands', '4.2 km • 15 min', '74 Efficiency', 'Yesterday, 04:15 PM'),
          const SizedBox(height: 12),
          _tripItem(context, Icons.hiking, 'Mountain Trip', '65.0 km • 1h 12m', '91 Efficiency', 'Aug 18, 10:00 AM'),
          const SizedBox(height: 24),

          // 🔋 Insights Card: Charging Optimization
          Container(
            padding: AppTheme.cardPadding,
            decoration: BoxDecoration(color: AppTheme.primaryLight(context).withOpacity(0.15), borderRadius: BorderRadius.circular(24)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Optimize your charging routine.', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
              const SizedBox(height: 8),
              Text('Based on your driving patterns, charging during off-peak hours (11 PM - 6 AM) could reduce your energy costs by up to 22% monthly.', style: AppTheme.body.copyWith(color: AppTheme.textSec(context))),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary(context), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: AppTheme.pillRadius),
                textStyle: AppTheme.bodyBold.copyWith(fontSize: 14)),
                child: const Text('Set Charging Schedule')),
              const SizedBox(height: 20),
              ClipRRect(borderRadius: AppTheme.smallRadius,
                child: Image.asset('assets/images/charging_station.png', width: double.infinity, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(height: 180, width: double.infinity, color: AppTheme.primaryLight(context).withOpacity(0.2),
                    child: const Center(child: Text('🔌', style: TextStyle(fontSize: 40)))))),
            ]),
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  // 🔧 HELPER: Efficiency Score Card
  Widget _efficiencyCard(BuildContext c) {
    return Container(padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(children: [
        Text('Efficiency Score', style: AppTheme.h3.copyWith(color: AppTheme.text(c))),
        const SizedBox(height: 4), Text('Optimised driving performance', style: AppTheme.caption),
        const SizedBox(height: 20),
        Stack(alignment: Alignment.center, children: [
          SizedBox(width: 140, height: 140, child: CircularProgressIndicator(value: 0.85, strokeWidth: 8,
            backgroundColor: AppTheme.border(c), color: AppTheme.primary(c))),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text('85', style: AppTheme.h1.copyWith(color: AppTheme.text(c), fontSize: 32)),
            const SizedBox(height: 4), Text('EXCELLENT', style: AppTheme.label.copyWith(color: AppTheme.textSec(c))),
          ]),
        ]),
        const SizedBox(height: 20), const Divider(height: 1), const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(children: [Text('Braking', style: AppTheme.caption), const SizedBox(height: 4), Text('92%', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c)))]),
          Column(children: [Text('Speed', style: AppTheme.caption), const SizedBox(height: 4), Text('78%', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c)))]),
        ]),
      ]),
    );
  }

  // 🔧 HELPER: Total Distance Summary Card
  Widget _summaryCard(BuildContext c) {
    return Container(padding: AppTheme.cardPadding,
      decoration: const BoxDecoration(color: Colors.black, borderRadius: AppTheme.cardRadius),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('TOTAL DISTANCE', style: AppTheme.label.copyWith(color: Colors.white70)),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: const [
          Text('1,248', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(width: 4), Text('km', style: TextStyle(fontSize: 20, color: Colors.white70)),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white24, borderRadius: AppTheme.pillRadius),
            child: Row(children: [const Icon(Icons.trending_up, size: 16, color: Colors.white), const SizedBox(width: 4),
              Flexible(child: Text('12% more than last month', 
                style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)), // ✅ Fixed Colors.white90
                maxLines: 2, overflow: TextOverflow.ellipsis)),
            ]),
          )),
          const SizedBox(width: 12),
          Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: AppTheme.pillRadius),
            child: const Text('View Detailed Insights', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis),
          )),
        ]),
      ]),
    );
  }

  // 🔧 HELPER: Weekly Bar Chart Card
  Widget _weeklyChartCard(BuildContext c) {
    return Container(padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Weekly Efficiency', style: AppTheme.h3.copyWith(color: AppTheme.text(c))),
          Text('Aug 14 - Aug 20', style: AppTheme.caption),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.end, children: [
          _bar(c, 'M', 60), _bar(c, 'T', 80), _bar(c, 'W', 95, highlight: true), _bar(c, 'T', 70), _bar(c, 'F', 85), _bar(c, 'S', 40), _bar(c, 'S', 55),
        ]),
      ]),
    );
  }

  Widget _bar(BuildContext c, String day, double heightPercent, {bool highlight = false}) { // ✅ Fixed signature
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 24, height: 80 * (heightPercent / 100),
        decoration: BoxDecoration(color: highlight ? AppTheme.primary(c) : AppTheme.border(c), borderRadius: const BorderRadius.vertical(top: Radius.circular(12)))),
      const SizedBox(height: 8),
      Text(day, style: TextStyle(fontSize: 10, color: highlight ? AppTheme.text(c) : AppTheme.textSec(c), fontWeight: highlight ? FontWeight.w600 : FontWeight.normal)),
    ]);
  }

  // 🔧 HELPER: Trip Item Row
  Widget _tripItem(BuildContext c, IconData icon, String title, String details, String efficiency, String time) {
    return Container(padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.primaryLight(c).withOpacity(0.15), borderRadius: AppTheme.smallRadius),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.primaryLight(c), borderRadius: AppTheme.smallRadius),
          child: Icon(icon, size: 20, color: AppTheme.primary(c))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
          const SizedBox(height: 4), Text(details, style: AppTheme.caption),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(efficiency, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
          const SizedBox(height: 4), Text(time, style: AppTheme.caption),
          const SizedBox(height: 4), Icon(Icons.chevron_right, size: 18, color: AppTheme.textSec(c)),
        ]),
      ]),
    );
  }
}