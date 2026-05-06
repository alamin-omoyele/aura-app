import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ControlsScreen extends StatefulWidget {
  const ControlsScreen({super.key});
  @override State<ControlsScreen> createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {
  // Toggle states
  bool isStartOn = false, isLocked = true, isFlashOn = false, isClimateOn = false;
  // Climate states
  double _temperature = 21.0;
  bool isHeatedSeatsOn = false, isDefrostOn = false;

  void _changeTemp(double delta) => setState(() => _temperature = (_temperature + delta).clamp(16.0, 28.0));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.bg(context),
      padding: AppTheme.screenPadding,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),

          // 🚗 Car Image (clipped, adaptive)
          ClipRRect(
            borderRadius: AppTheme.smallRadius,
            child: Container(
              width: double.infinity,
              color: AppTheme.primaryLight(context).withOpacity(0.15),
              child: Image.asset('assets/images/car_2.png', fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(child: Text('🚗', style: TextStyle(fontSize: 40))),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 📝 Title
          Text('Remote Controls', style: AppTheme.h2.copyWith(color: AppTheme.text(context))),
          const SizedBox(height: 24),

          // 🔘 2×2 Toggle Grid
          GridView.count(
            crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5,
            children: [
              _toggleCard('Start', Icons.power_settings_new, isStartOn, () => setState(() => isStartOn = !isStartOn)),
              _toggleCard(isLocked ? 'Locked' : 'Unlocked', isLocked ? Icons.lock : Icons.lock_open, isLocked, () => setState(() => isLocked = !isLocked)),
              _toggleCard('Flash', Icons.flashlight_on, isFlashOn, () => setState(() => isFlashOn = !isFlashOn)),
              _toggleCard('Climate', Icons.ac_unit, isClimateOn, () => setState(() => isClimateOn = !isClimateOn)),
            ],
          ),
          const SizedBox(height: 24),

          // 🌡️ Climate Control Card
          Container(
            padding: AppTheme.cardPadding,
            decoration: BoxDecoration(color: AppTheme.surface(context), borderRadius: AppTheme.cardRadius, boxShadow: AppTheme.cardShadow(context)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Cabin temperature', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(context))),
                Text('${_temperature.toStringAsFixed(1)}°C', style: AppTheme.bodyBold.copyWith(color: AppTheme.text(context))),
              ]),
              const SizedBox(height: 16),
              Slider(value: _temperature, min: 16, max: 28, divisions: 12, label: '${_temperature.toStringAsFixed(1)}°C',
                activeColor: AppTheme.primary(context), inactiveColor: AppTheme.primary(context).withOpacity(0.15),
                onChanged: (v) => setState(() => _temperature = v)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => _changeTemp(-1), color: AppTheme.primary(context)),
                Text('Adjust temperature', style: AppTheme.caption),
                IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => _changeTemp(1), color: AppTheme.primary(context)),
              ]),
              const SizedBox(height: 16),
              _switchRow(Icons.chair, 'Heated Seats', isHeatedSeatsOn, (v) => setState(() => isHeatedSeatsOn = v)),
              const Divider(height: 1, color: Colors.transparent),
              _switchRow(Icons.air, 'Defrost', isDefrostOn, (v) => setState(() => isDefrostOn = v)),
            ]),
          ),
          const SizedBox(height: 24),

          // 📊 Info Cards Column (Tire / Range / Location)
          Column(children: [
            _infoCard(Icons.tire_repair, 'Tire Pressure', 'Optimal'),
            const SizedBox(height: 12),
            _infoCard(Icons.battery_full, 'Range', '342 km'),
            const SizedBox(height: 12),
            _infoCard(Icons.location_on, 'Location', 'Home'),
          ]),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }

  // 🔧 HELPER: Toggle Card (2×2 grid)
  Widget _toggleCard(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: AnimatedContainer(duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary(context) : AppTheme.surface(context),
        borderRadius: AppTheme.smallRadius,
        border: Border.all(color: isActive ? Colors.transparent : AppTheme.border(context)),
        boxShadow: isActive ? [] : AppTheme.cardShadow(context),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, size: 24, color: isActive ? Colors.white : AppTheme.primary(context)),
        const SizedBox(height: 8),
        Text(label, style: AppTheme.label.copyWith(color: isActive ? Colors.white : AppTheme.primary(context))),
      ]),
    ));
  }

  // 🔧 HELPER: Switch Row (Heated Seats / Defrost)
  Widget _switchRow(IconData icon, String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [Icon(icon, size: 20, color: AppTheme.primary(context)), const SizedBox(width: 12), Text(label, style: AppTheme.body.copyWith(color: AppTheme.text(context)))]),
      Switch(value: value, onChanged: onChanged, activeColor: AppTheme.primary(context), activeTrackColor: AppTheme.primary(context).withOpacity(0.3),
        inactiveThumbColor: AppTheme.surface(context), inactiveTrackColor: AppTheme.border(context)),
    ]));
  }

  // 🔧 HELPER: Full-width Info Card
  Widget _infoCard(IconData icon, String title, String value) {
    return Container(width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.surface(context), borderRadius: AppTheme.smallRadius, boxShadow: AppTheme.cardShadow(context)),
      child: Row(children: [
        Icon(icon, size: 22, color: AppTheme.primary(context)), const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: AppTheme.caption), const SizedBox(height: 2),
          Text(value, style: AppTheme.bodyBold.copyWith(color: AppTheme.text(context))),
        ]),
      ]),
    );
  }
}