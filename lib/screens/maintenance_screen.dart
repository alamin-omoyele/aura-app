import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bg(context),
      padding: AppTheme.screenPadding,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),

          // 🏥 Hero Card: Health Score
          Container(
            padding: AppTheme.cardPadding,
            decoration: BoxDecoration(color: AppTheme.surface(context), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(context)),
            child: Column(children: [
              Align(alignment: Alignment.centerLeft, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.primaryLight(context).withOpacity(0.15), borderRadius: AppTheme.pillRadius),
                  child: Text('VEHICLE DIAGNOSTICS', style: AppTheme.label.copyWith(color: AppTheme.primary(context)))),
                const SizedBox(height: 12),
                Text('System Status: Good', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
                const SizedBox(height: 8),
                Text('Your Aura is performing at peak efficiency. No immediate attention is required for critical systems.', style: AppTheme.body.copyWith(color: AppTheme.textSec(context))),
              ])),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Stack(alignment: Alignment.center, children: [
                  SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: 0.98, strokeWidth: 8,
                    backgroundColor: AppTheme.border(context), color: AppTheme.primary(context))),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.verified_user, size: 32, color: AppTheme.primary(context)),
                    const SizedBox(height: 4), Text('98%', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
                    Text('Health Score', style: AppTheme.label.copyWith(color: AppTheme.textSec(context))),
                  ]),
                ]),
                ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary(context), foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: AppTheme.smallRadius),
                  textStyle: AppTheme.bodyBold.copyWith(fontSize: 14)),
                  child: const Text('Schedule Service')),
              ]),
            ]),
          ),
          const SizedBox(height: 24),

          // 🧩 Bento Grid: Maintenance + Stats (Responsive)
          LayoutBuilder(builder: (ctx, constraints) {
            final isWide = constraints.maxWidth > 600;
            return isWide
                ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 2, child: _upcomingCard(ctx)),
                    const SizedBox(width: 16),
                    Expanded(flex: 1, child: _statsCard(ctx)), // ✅ Fixed: passes context
                  ])
                : Column(children: [_upcomingCard(ctx), const SizedBox(height: 16), _statsCard(ctx)]);
          }),
          const SizedBox(height: 24),

          // 📋 Service History Table
          Container(
            decoration: BoxDecoration(color: AppTheme.surface(context), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(context)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.all(16), child: Text('Service History', style: AppTheme.h3.copyWith(color: AppTheme.text(context)))),
              const Divider(height: 1),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: Row(children: [
                Expanded(flex: 2, child: _tableHeader(context, 'Date')), Expanded(flex: 3, child: _tableHeader(context, 'Service')),
                Expanded(flex: 2, child: _tableHeader(context, 'Location')), Expanded(flex: 2, child: _tableHeader(context, 'Mileage')),
                Expanded(flex: 2, child: _tableHeader(context, 'Cost', alignRight: true)),
              ])),
              const Divider(height: 1),
              _historyRow(context, 'Mar 15, 2023', 'Tire Rotation & Balance', 'Aura Center East', '24,500 mi', '\$85.00'),
              _historyRow(context, 'Jan 02, 2023', 'Annual Systems Check', 'Aura Center North', '18,200 mi', '\$0.00'),
              _historyRow(context, 'Sep 20, 2022', 'Cabin Filter Replacement', 'Aura Mobile Service', '12,100 mi', '\$42.50'),
              Padding(padding: const EdgeInsets.all(12), child: Center(child: TextButton(onPressed: () {},
                child: Text('View All Records', style: AppTheme.bodyBold.copyWith(color: AppTheme.primary(context), fontSize: 14))))),
            ]),
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  // 🔧 HELPER: Upcoming Maintenance Card
  Widget _upcomingCard(BuildContext c) {
    return Container(padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Upcoming Maintenance', style: AppTheme.h3.copyWith(color: AppTheme.text(c))),
          Icon(Icons.more_horiz, color: AppTheme.textSec(c), size: 20),
        ]),
        const SizedBox(height: 16),
        _maintItem(c, Icons.oil_barrel, 'Oil & Filter Change', 'Synthetic 0W-20 standard service', '1,240 mi', '~3 weeks'),
        const SizedBox(height: 12),
        _maintItem(c, Icons.settings_input_component, 'Brake Inspection', 'Front & rear pad thickness check', '4,800 mi', '~4 months'),
      ]),
    );
  }

  Widget _maintItem(BuildContext c, IconData icon, String title, String desc, String miles, String time) {
    return Container(padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppTheme.primaryLight(c).withOpacity(0.15), borderRadius: AppTheme.smallRadius),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.primaryLight(c), borderRadius: AppTheme.smallRadius),
          child: Icon(icon, size: 20, color: AppTheme.primary(c))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
          Text(desc, style: AppTheme.caption),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(miles, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
          Text(time, style: AppTheme.caption),
        ]),
      ]),
    );
  }

  // 🔧 HELPER: Stats Card (Dark Green Background)
  Widget _statsCard(BuildContext c) { // ✅ Fixed signature
    return Container(padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.primary(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Last Inspection', style: AppTheme.bodyBold.copyWith(color: Colors.white)),
        Text('October 12, 2023', style: AppTheme.body.copyWith(color: Colors.white.withOpacity(0.8))),
        const SizedBox(height: 20),
        _progRow(c, 'Tire Tread', '7/32"', 0.7, true),
        const SizedBox(height: 12),
        _progRow(c, 'Coolant Level', 'Optimal', 0.92, true),
      ]),
    );
  }

  Widget _progRow(BuildContext c, String label, String value, double progress, bool isDark) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTheme.label.copyWith(color: isDark ? Colors.white70 : AppTheme.textSec(c))),
        Text(value, style: AppTheme.label.copyWith(color: isDark ? Colors.white70 : AppTheme.textSec(c))),
      ]),
      const SizedBox(height: 4),
      Container(height: 6, decoration: BoxDecoration(color: isDark ? Colors.white24 : AppTheme.border(c), borderRadius: BorderRadius.circular(3)),
        child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: progress,
          child: Container(decoration: BoxDecoration(color: isDark ? AppTheme.primaryLight(c) : AppTheme.primary(c), borderRadius: BorderRadius.circular(3))))),
    ]);
  }

  // 🔧 HELPER: Table Helpers
  Widget _tableHeader(BuildContext c, String text, {bool alignRight = false}) {
    return Text(text, style: AppTheme.label.copyWith(color: AppTheme.textSec(c)), textAlign: alignRight ? TextAlign.right : TextAlign.left);
  }

  Widget _historyRow(BuildContext c, String date, String service, String location, String mileage, String cost) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [
      Expanded(flex: 2, child: Text(date, style: AppTheme.body.copyWith(color: AppTheme.text(c)))),
      Expanded(flex: 3, child: Text(service, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c)))),
      Expanded(flex: 2, child: Text(location, style: AppTheme.body.copyWith(color: AppTheme.textSec(c)))),
      Expanded(flex: 2, child: Text(mileage, style: AppTheme.body.copyWith(color: AppTheme.textSec(c)))),
      Expanded(flex: 2, child: Text(cost, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c)), textAlign: TextAlign.right)),
    ]));
  }
}