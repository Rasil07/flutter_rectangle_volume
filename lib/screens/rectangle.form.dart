import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import "package:rectangle_volume/model/rectangle.model.dart";

class RectangleForm extends StatefulWidget {
  const RectangleForm({super.key});

  @override
  State<RectangleForm> createState() => _RectangleFormState();
}

class _RectangleFormState extends State<RectangleForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _lengthCtrl;
  late final TextEditingController _breadthCtrl;
  late final TextEditingController _depthCtrl;

  final _numFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'^\d*\.?\d{0,6}$'),
  );

  @override
  void initState() {
    super.initState();
    final m = context.read<RectangleModel>();
    _lengthCtrl = TextEditingController(
      text: m.length == 0 ? '' : m.length.toString(),
    );
    _breadthCtrl = TextEditingController(
      text: m.breadth == 0 ? '' : m.breadth.toString(),
    );
    _depthCtrl = TextEditingController(
      text: m.depth == 0 ? '' : m.depth.toString(),
    );
  }

  @override
  void dispose() {
    _lengthCtrl.dispose();
    _breadthCtrl.dispose();
    _depthCtrl.dispose();
    super.dispose();
  }

  String? _requiredPositive(String? v) {
    final s = v?.trim();
    if (s == null || s.isEmpty) return 'Required';
    final d = double.tryParse(s);
    if (d == null) return 'Invalid number';
    if (d <= 0) return 'Must be > 0';
    return null;
  }

  void _goToDetails() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final l = double.parse(_lengthCtrl.text.trim());
    final b = double.parse(_breadthCtrl.text.trim());
    final d = double.parse(_depthCtrl.text.trim());

    context.read<RectangleModel>().setMeasurements(l, b, d);
    Navigator.pushNamed(context, '/details');
  }

  @override
  Widget build(BuildContext context) {
    final volume = context.watch<RectangleModel>().volume;

    return Scaffold(
      appBar: AppBar(title: const Text('Screen 1: Enter Box')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _lengthCtrl,
                    decoration: const InputDecoration(labelText: 'Length'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [_numFormatter],
                    validator: _requiredPositive,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _breadthCtrl,
                    decoration: const InputDecoration(labelText: 'Breadth'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [_numFormatter],
                    validator: _requiredPositive,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _depthCtrl,
                    decoration: const InputDecoration(labelText: 'Depth'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [_numFormatter],
                    validator: _requiredPositive,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _goToDetails,
              child: const Text('Go to Screen 2'),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                volume == null ? '' : 'Volume: $volume',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
