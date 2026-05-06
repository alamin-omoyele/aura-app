import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bg(context),
      padding: AppTheme.screenPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // 🚗 Hero Card: Car + Status + Location
            Container(
              padding: AppTheme.cardPadding,
              decoration: BoxDecoration(
                color: AppTheme.surface(context),
                borderRadius: AppTheme.cardRadius,
                boxShadow: AppTheme.cardShadow(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Image (with safe placeholder)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      color: AppTheme.primaryLight(context).withOpacity(0.15),
                      child: Image.asset(
                        'assets/images/car_side.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Center(child: Text('🚗', style: TextStyle(fontSize: 40))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Status Text Stack
                  Text('CONNECTED', style: AppTheme.label.copyWith(color: AppTheme.primary(context))),
                  const SizedBox(height: 4),
                  Text('Aura GT', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
                  const SizedBox(height: 4),
                  Text('Last updated: 2 mins ago', style: AppTheme.caption),
                  const SizedBox(height: 16),

                  // Location Mini-Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight(context).withOpacity(0.15),
                      borderRadius: AppTheme.smallRadius,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 20, color: AppTheme.primary(context)),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Location', style: AppTheme.caption),
                            Text('Downtown District', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(context))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            // 🔋 Range Card
            _buildMetricCard(
              context,
              icon: Icons.bolt_outlined,
              iconBg: AppTheme.primaryLight(context),
              value: '412 km',
              label: 'Estimated Range',
              progress: 0.8,
              progressColor: AppTheme.primary(context),
            ),
            const SizedBox(height: 8),

            // 🌡️ Climate Card
            _buildClimateCard(context),
            const SizedBox(height: 8),

            // 🛞 Tire Pressure Card
            _buildTireCard(context),
            const SizedBox(height: 36),

            // 💧 Fluid Levels Card
            _buildFluidCard(context),
            const SizedBox(height: 8),

            // 🛑 Brake Health Card
            _buildBrakeCard(context),
            const SizedBox(height: 48),

            // 🔓 Quick Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.lock_open, size: 20),
                    label: const Text('Unlock Aura'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary(context),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: AppTheme.pillRadius),
                      elevation: 0,
                      textStyle: AppTheme.bodyBold.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.ac_unit, size: 20),
                    label: const Text('Pre-Condition'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.text(context),
                      side: BorderSide(color: AppTheme.border(context)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: AppTheme.pillRadius),
                      textStyle: AppTheme.bodyBold.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 🔧 HELPER: Standard Metric Card (Range, etc.)
  Widget _buildMetricCard(BuildContext c, {required IconData icon, required Color iconBg, required String value, required String label, required double progress, required Color progressColor}) {
    return Container(
      padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: iconBg, borderRadius: AppTheme.smallRadius), child: Icon(icon, size: 20, color: AppTheme.primary(c))),
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.primaryLight(c).withOpacity(0.15), borderRadius: AppTheme.smallRadius), child: Text('82%', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c)))),
        ]),
        const SizedBox(height: 16),
        Text(value, style: AppTheme.h2.copyWith(color: AppTheme.text(c))),
        Text(label, style: AppTheme.body.copyWith(color: AppTheme.textSec(c))),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: progress, backgroundColor: AppTheme.border(c), color: progressColor, minHeight: 6, borderRadius: BorderRadius.circular(3)),
      ]),
    );
  }

  // 🔧 HELPER: Climate Card
  Widget _buildClimateCard(BuildContext c) {
    return Container(
      padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.primaryLight(c), borderRadius: AppTheme.smallRadius), child: Icon(Icons.thermostat_outlined, size: 20, color: AppTheme.primary(c))),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}, color: AppTheme.textSec(c), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
        ]),
        const SizedBox(height: 16),
        Text('21.5°C', style: AppTheme.h2.copyWith(color: AppTheme.text(c))),
        Text('Interior Climate', style: AppTheme.body.copyWith(color: AppTheme.textSec(c))),
        const SizedBox(height: 12),
        Row(children: [
          _buildChip(c, 'Eco Mode'),
          const SizedBox(width: 8),
          _buildChip(c, 'Optimal', isActive: true),
        ]),
      ]),
    );
  }

  // 🔧 HELPER: Small Chip Tag
  Widget _buildChip(BuildContext c, String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryLight(c) : AppTheme.primaryLight(c).withOpacity(0.15),
        borderRadius: AppTheme.pillRadius,
      ),
      child: Text(label, style: AppTheme.label.copyWith(color: isActive ? AppTheme.primary(c) : AppTheme.textSec(c))),
    );
  }

  // 🔧 HELPER: Tire Pressure Card
  Widget _buildTireCard(BuildContext c) {
    return Container(
      padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.primaryLight(c).withOpacity(0.15), borderRadius: AppTheme.smallRadius), child: Icon(Icons.tire_repair_sharp, size: 20, color: AppTheme.primary(c))),
          Icon(Icons.check_circle, color: AppTheme.primary(c), size: 20),
        ]),
        const SizedBox(height: 16),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.5,
          children: [
            _buildTireCell(c, 'Front', '32 PSI / 32 PSI'),
            _buildTireCell(c, 'Rear', '34 PSI / 34 PSI'),
          ],
        ),
        const SizedBox(height: 12),
        Text('All tires optimal', style: AppTheme.body.copyWith(color: AppTheme.textSec(c))),
      ]),
    );
  }

  Widget _buildTireCell(BuildContext c, String label, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: AppTheme.caption),
      const SizedBox(height: 4),
      Text(value, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
    ]);
  }

  // 🔧 HELPER: Fluid Levels Card
  Widget _buildFluidCard(BuildContext c) {
    return Container(
      padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Fluid Levels', style: AppTheme.h3.copyWith(color: AppTheme.text(c))),
          Text('Next Service: 4k km', style: AppTheme.caption),
        ]),
        const SizedBox(height: 12),
        _buildFluidRow(c, 'Washer Fluid', '90%', 0.9),
        const SizedBox(height: 12),
        _buildFluidRow(c, 'Coolant', 'Normal', 1.0),
      ]),
    );
  }

  Widget _buildFluidRow(BuildContext c, String label, String value, double progress) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTheme.body.copyWith(color: AppTheme.text(c))),
        Text(value, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
      ]),
      const SizedBox(height: 8),
      LinearProgressIndicator(value: progress, backgroundColor: AppTheme.border(c), color: AppTheme.primary(c), minHeight: 4, borderRadius: BorderRadius.circular(2)),
    ]);
  }

  // 🔧 HELPER: Brake Health Card
  Widget _buildBrakeCard(BuildContext c) {
    return Container(
      padding: AppTheme.cardPadding,
      decoration: BoxDecoration(color: AppTheme.surface(c), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(c)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Brake Health', style: AppTheme.h3.copyWith(color: AppTheme.text(c))),
          Icon(Icons.info_outline, color: AppTheme.textSec(c), size: 20),
        ]),
        const SizedBox(height: 12),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(width: 60, height: 60, child: CircularProgressIndicator(value: 0.85, strokeWidth: 4, backgroundColor: AppTheme.border(c), color: AppTheme.primary(c))),
            Text('85%', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c), fontSize: 14)),
          ]),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Brake Pads Wearing Evenly', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(c))),
            const SizedBox(height: 4),
            Text('Status check completed on Oct 24, 2023.', style: AppTheme.caption),
            const SizedBox(height: 8),
            Text('Full Report →', style: AppTheme.label.copyWith(color: AppTheme.primary(c))),
          ])),
        ]),
      ]),
    );
  }
}