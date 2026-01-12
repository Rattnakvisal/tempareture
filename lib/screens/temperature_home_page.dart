import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/glass_card.dart';
import '../widgets/buttons.dart';
import '../widgets/metric_row.dart';
import '../widgets/mini_tile.dart';
import '../widgets/big_icon.dart';

class TemperatureHomePage extends StatefulWidget {
  const TemperatureHomePage({super.key});

  @override
  State<TemperatureHomePage> createState() => _TemperatureHomePageState();
}

class _TemperatureHomePageState extends State<TemperatureHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController(text: "29");

  final List<String> _units = const ['Celsius', 'Fahrenheit', 'Kelvin'];

  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double? _result;

  final List<MiniCardData> _miniCards = const [
    MiniCardData(label: "Now", icon: Icons.thermostat, value: "29°"),
    MiniCardData(label: "5pm", icon: Icons.cloud, value: "28°"),
    MiniCardData(label: "6pm", icon: Icons.grain, value: "28°"),
    MiniCardData(label: "7pm", icon: Icons.nights_stay, value: "27°"),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_autoConvert);
    _convert(showErrors: false);
  }

  @override
  void dispose() {
    _controller.removeListener(_autoConvert);
    _controller.dispose();
    super.dispose();
  }

  void _autoConvert() {
    final t = _controller.text.trim();
    if (t.isEmpty) {
      setState(() => _result = null);
      return;
    }
    _convert(showErrors: false);
  }

  double _toCelsius(double input, String from) {
    switch (from) {
      case 'Fahrenheit':
        return (input - 32) * 5 / 9;
      case 'Kelvin':
        return input - 273.15;
      default:
        return input;
    }
  }

  double _fromCelsius(double c, String to) {
    switch (to) {
      case 'Fahrenheit':
        return c * 9 / 5 + 32;
      case 'Kelvin':
        return c + 273.15;
      default:
        return c;
    }
  }

  void _convert({bool showErrors = true}) {
    if (showErrors) {
      final ok = _formKey.currentState?.validate() ?? false;
      if (!ok) {
        setState(() => _result = null);
        return;
      }
    }

    final input = double.tryParse(_controller.text.trim());
    if (input == null) {
      if (showErrors) setState(() => _result = null);
      return;
    }

    final c = _toCelsius(input, _fromUnit);
    final out = _fromCelsius(c, _toUnit);
    setState(() => _result = out);
  }

  void _swap() {
    setState(() {
      final tmp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = tmp;
    });
    _convert(showErrors: false);
  }

  void _clear() {
    _controller.clear();
    setState(() => _result = null);
  }

  String _unitShort(String unit) {
    switch (unit) {
      case 'Celsius':
        return '°C';
      case 'Fahrenheit':
        return '°F';
      case 'Kelvin':
        return 'K';
      default:
        return unit;
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultText = _result == null
        ? "--"
        : "${_result!.toStringAsFixed(1)}${_unitShort(_toUnit)}";

    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),
      body: Stack(
        children: [
          const _GradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                children: [
                  Center(
                    child: const Text(
                      "Phnom Penh City, Cambodia",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const BigWeatherLikeIcon(
                            icon: Icons.cloud,
                            accent: Colors.orange,
                            drops: true,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            resultText.replaceAll("K", " K"),
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w800,
                              height: 1,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Convert temperature instantly.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 18),

                          const MetricRow(
                            leftIcon: Icons.air,
                            leftText: "11km/hr",
                            midIcon: Icons.water_drop,
                            midText: "02%",
                            rightIcon: Icons.wb_sunny,
                            rightText: "8hr",
                          ),
                          const SizedBox(height: 18),

                          GlassCard(
                            padding: const EdgeInsets.all(14),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    "Temperature Converter",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _controller,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: true,
                                        ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^-?\d*\.?\d*$'),
                                      ),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Enter value (e.g. 29)",
                                      prefixIcon: const Icon(Icons.thermostat),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.06),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    validator: (value) {
                                      final v = (value ?? '').trim();
                                      if (v.isEmpty)
                                        return "Please enter a value";
                                      if (double.tryParse(v) == null) {
                                        return "Invalid number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),

                                  Row(
                                    children: [
                                      Expanded(child: _unitDropdown(true)),
                                      const SizedBox(width: 10),
                                      IconGlassButton(
                                        icon: Icons.swap_vert,
                                        onTap: _swap,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(child: _unitDropdown(false)),
                                      const SizedBox(width: 10),
                                      SecondaryButton(
                                        icon: Icons.refresh,
                                        onTap: _clear,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Row(
                            children: const [
                              Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Quick Presets",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          SizedBox(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _miniCards.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, i) {
                                final c = _miniCards[i];
                                return MiniGlassTile(
                                  label: c.label,
                                  value: c.value,
                                  icon: c.icon,
                                  onTap: () {
                                    final digits = c.value.replaceAll("°", "");
                                    _controller.text = digits;
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 90),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _unitDropdown(bool from) {
    final value = from ? _fromUnit : _toUnit;

    return GlassCard(
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF121A33),
          iconEnabledColor: Colors.white70,
          items: _units
              .map(
                (u) => DropdownMenuItem(
                  value: u,
                  child: Text(
                    u,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v == null) return;
            setState(() {
              if (from) {
                _fromUnit = v;
              } else {
                _toUnit = v;
              }
            });
            _convert(showErrors: false);
          },
        ),
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.4, -0.4),
            radius: 1.2,
            colors: [Color(0xFF2B2F49), Color(0xFF0B1020)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -80,
              top: 90,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x33FF9F3C), Color(0x00000000)],
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}
