import 'package:alera/alera.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alera Showcase',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F64AD)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  static const Color _brand = Color(0xFF3F64AD);

  AleraStyle _style = AleraStyle.classic;
  AleraTransition _transition = AleraTransition.adaptive;
  int _actionCount = 1;
  bool _longMessage = false;

  String get _styleName => switch (_style) {
    AleraStyle.classic => 'Classic',
    AleraStyle.floatingTop => 'Floating top',
    AleraStyle.cornerBadge => 'Corner badge',
  };

  Color get _accent => switch (_style) {
    AleraStyle.classic => _brand,
    AleraStyle.floatingTop => Colors.blueGrey,
    AleraStyle.cornerBadge => Colors.deepPurple,
  };

  String _titleFor(AleraType type) => switch (type) {
    AleraType.success => 'Success',
    AleraType.warning => 'Warning',
    AleraType.error => 'Connection error',
    AleraType.fail => 'Operation failed',
    AleraType.info => 'Information',
    AleraType.loading => 'Loading',
  };

  String _messageFor(AleraType type) {
    if (_longMessage) {
      return 'This is a longer message to demonstrate how Alera adapts to '
          'different amounts of content on smaller screens. The dialog '
          'should remain readable, accessible, and visually balanced even '
          'when multiple lines of text are displayed.';
    }
    return switch (type) {
      AleraType.success => 'Your changes were saved successfully.',
      AleraType.warning => 'Please review the information before continuing.',
      AleraType.error => 'The server could not be reached. Please try again.',
      AleraType.fail => 'The requested operation could not be completed.',
      AleraType.info => 'Here is some useful information for you.',
      AleraType.loading => 'Processing your request...',
    };
  }

  List<AleraAction> _actionsFor(AleraType type) {
    if (_actionCount == 0) return [];
    if (_actionCount == 1) {
      return [
        AleraAction(
          label: 'OK',
          isPrimary: true,
          onPressed: () {},
        ),
      ];
    }
    return [
      AleraAction(label: 'Cancel', onPressed: () {}),
      AleraAction(
        label: type == AleraType.error ? 'Retry' : 'Continue',
        isPrimary: true,
        onPressed: () {},
      ),
    ];
  }

  void _showAlert(AleraType type) {
    debugPrint('Alera preview: type=$type, actions=$_actionCount, style=$_style');
    if (type == AleraType.loading) {
      _showLoading();
      return;
    }
    Alera.show(
      context,
      type: type,
      style: _style,
      transition: _transition,
      title: _titleFor(type),
      message: _messageFor(type),
      primaryColor: _accent,
      actions: _actionsFor(type),
      // With zero actions, users can dismiss by tapping outside.
      barrierDismissible: _actionCount == 0,
    );
  }

  Future<void> _showLoading({bool cancellable = false}) async {
    final controller = Alera.showLoading(
      context,
      style: _style,
      transition: _transition,
      title: 'Loading',
      message: 'Processing your request...',
      primaryColor: _accent,
      action: cancellable
          ? AleraAction(
              label: 'Cancel',
              onPressed: () {},
            )
          : null,
    );

    // Close automatically so this showcase never leaves a locked dialog.
    await Future<void>.delayed(const Duration(seconds: 4));
    controller.close();
  }

  Widget _sectionHeading(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
        const SizedBox(height: 3),
        Text(description, style: TextStyle(color: Colors.blueGrey.shade700)),
      ],
    );
  }

  Widget _alertTile(AleraType type, IconData icon, Color color) {
    return OutlinedButton(
      onPressed: () => _showAlert(type),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF27344B),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: Colors.blueGrey.shade100),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 29),
          const SizedBox(height: 9),
          Text(_titleFor(type), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alera Showcase'),
        backgroundColor: const Color(0xFFF5F7FB),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
        children: [
          const Text(
            'Animated alerts for Flutter',
            style: TextStyle(fontSize: 15, color: Color(0xFF58677D)),
          ),
          const SizedBox(height: 24),
          _sectionHeading('Visual style', 'Choose a layout for all six alert types.'),
          const SizedBox(height: 12),
          SegmentedButton<AleraStyle>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: AleraStyle.classic, label: Text('Classic')),
              ButtonSegment(value: AleraStyle.floatingTop, label: Text('Floating')),
              ButtonSegment(value: AleraStyle.cornerBadge, label: Text('Corner')),
            ],
            selected: {_style},
            onSelectionChanged: (selection) {
              setState(() => _style = selection.first);
            },
          ),
          const SizedBox(height: 9),
          Text('Selected: $_styleName', style: const TextStyle(color: Color(0xFF58677D))),
          const SizedBox(height: 28),
          _sectionHeading('Alert types', 'Tap an alert to preview it with the selected style and settings. Loading uses its own controller.'),
          const SizedBox(height: 14),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _alertTile(AleraType.success, Icons.check_circle_outline, Colors.green),
              _alertTile(AleraType.warning, Icons.warning_amber_rounded, Colors.orange),
              _alertTile(AleraType.error, Icons.error_outline, Colors.red),
              _alertTile(AleraType.fail, Icons.cancel_outlined, Colors.deepOrange),
              _alertTile(AleraType.info, Icons.info_outline, Colors.blue),
              _alertTile(AleraType.loading, Icons.hourglass_top_rounded, Colors.deepPurple),
            ],
          ),
          const SizedBox(height: 30),
          _sectionHeading('Advanced examples', 'Explore actions, transitions and long messages.'),
          const SizedBox(height: 14),
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Actions', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 0, label: Text('None')),
                      ButtonSegment(value: 1, label: Text('One')),
                      ButtonSegment(value: 2, label: Text('Two')),
                    ],
                    selected: {_actionCount},
                    onSelectionChanged: (value) => setState(() => _actionCount = value.first),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Selected: $_actionCount ${_actionCount == 1 ? 'action' : 'actions'} '
                    '(standard alerts only)',
                    style: const TextStyle(fontSize: 12, color: Color(0xFF58677D)),
                  ),
                  const SizedBox(height: 10),
                  FilledButton.icon(
                    onPressed: () => _showAlert(AleraType.warning),
                    icon: const Icon(Icons.visibility_outlined),
                    label: Text('Preview warning ($_actionCount ${_actionCount == 1 ? 'action' : 'actions'})'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Transition', style: TextStyle(fontWeight: FontWeight.w600)),
                  DropdownButton<AleraTransition>(
                    value: _transition,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: AleraTransition.adaptive, child: Text('Adaptive')),
                      DropdownMenuItem(value: AleraTransition.fadeScale, child: Text('Fade scale')),
                      DropdownMenuItem(value: AleraTransition.top, child: Text('Top')),
                      DropdownMenuItem(value: AleraTransition.bottom, child: Text('Bottom')),
                      DropdownMenuItem(value: AleraTransition.left, child: Text('Left')),
                      DropdownMenuItem(value: AleraTransition.right, child: Text('Right')),
                      DropdownMenuItem(value: AleraTransition.tiltIn, child: Text('Tilt in')),
                      DropdownMenuItem(value: AleraTransition.forward, child: Text('Forward')),
                      DropdownMenuItem(value: AleraTransition.none, child: Text('None')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _transition = value);
                    },
                  ),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Long message'),
                    subtitle: const Text('Test dialogs with multiple text lines'),
                    value: _longMessage,
                    onChanged: (value) => setState(() => _longMessage = value),
                  ),
                  const Divider(),
                  const Text('Loading with cancel action',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => _showLoading(cancellable: true),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Preview loading with action'),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Loading previews close automatically after 4 seconds.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF58677D)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}