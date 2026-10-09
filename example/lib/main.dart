import 'package:alera/alera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated App Alert Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F64AD),
        ),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  static const primaryColor = Color(0xFF3F64AD);
  static const secondColor = Colors.blueGrey;
  static const thirtyColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated App Alert'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [

          Text('Alerts Style Classic', style: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),),
          const SizedBox(height: 12),

          _ExampleButton(
            color: primaryColor,
            label: 'Success',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.success,
                style: AleraStyle.classic,
                title: 'Success',
                message: 'Your operation was completed successfully.',
                primaryColor: primaryColor,
                barrierDismissible: false,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            }, 
          ),

          const SizedBox(height: 12),

          Wrap(
          spacing: 8,
          runSpacing: 8,
            children: [
              _ExampleButton(
                color: primaryColor,
                label: 'Warning A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.classic,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: primaryColor 
                  );
                },
              ),
              _ExampleButton(
                color: primaryColor,
                label: 'Warning B',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.classic,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: primaryColor,
                    actions: [
                      AleraAction(
                        label: 'Ok',
                        onPressed: () {},
                      ),
               
                    ],
                  );
                },
              ),
              _ExampleButton(
                color: primaryColor,
                label: 'Warning C',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.classic,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: primaryColor,
                    actions: [
                      AleraAction(
                        label: 'Cancel',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ExampleButton(
                color: primaryColor,
                label: 'Error',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.error,
                     style: AleraStyle.classic,
                    title: 'Connection error',
                    message:
                        'The operation could not be completed because '
                        'a technical error occurred.',
                    primaryColor: primaryColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

              _ExampleButton(
                color: primaryColor,
                label: 'Fail',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.fail,
                    style: AleraStyle.classic,
                    title: 'Fail',
                    message:
                        'The operation could not be completed because '
                        'a technical error occurred.',
                    primaryColor: primaryColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

                  _ExampleButton(
            color: primaryColor,
            label: 'Loading A',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.loading,
                style: AleraStyle.classic,
                title: 'Loading',
                message: 'Cargando registro',
                primaryColor: primaryColor,
                barrierDismissible: false,
              );
            },
          ),

          _ExampleButton(
            color: primaryColor,
            label: 'Loading B',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.loading,
                style: AleraStyle.classic,
                title: 'Loading',
                message: 'Cargando registro',
                primaryColor: primaryColor,
                barrierDismissible: false,
                actions: [
                  AleraAction(
                    label: 'Cancel',
                    onPressed: () {
                      debugPrint('Loading cancelled');
                    },
                  ),
                ],
              );
            },
          ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ExampleButton(
                color: primaryColor,
                label: 'Information A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.info,
                    style: AleraStyle.classic,
                    title: 'Información',
                    message: 'Este mensaje no requiere ninguna acción.',
                    primaryColor: const Color(0xFF3F64AD),
                  );
                },
              ),

               _ExampleButton(
                color: primaryColor,
            label: 'Information B',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.classic,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: primaryColor,
                actions: [
                  AleraAction(
                    label: 'Ok',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          _ExampleButton(
            color: primaryColor,
            label: 'Information C',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.classic,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: primaryColor,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: false,
                    onPressed: () {},
                  ),
                  AleraAction(
                    label: 'Cancel',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
            ],
          ),

          Divider(),
          Text('Alerts Style FloatingTop', style: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),),
          const SizedBox(height: 12),

          _ExampleButton(
            color: secondColor,
            label: 'Success',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.success,
                style: AleraStyle.floatingTop,
                title: 'Success',
                message: 'Your operation was completed successfully.',
                primaryColor: secondColor,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ExampleButton(
                color: secondColor,
                label: 'Warning A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.floatingTop,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: secondColor 
                  );
                },
              ),
              _ExampleButton(
                color: secondColor,
                label: 'Warning B',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.floatingTop,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: secondColor,
                    actions: [
                      AleraAction(
                        label: 'Ok',
                        onPressed: () {},
                      ),
               
                    ],
                  );
                },
              ),
              _ExampleButton(
                color: secondColor,
                label: 'Warning C',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.floatingTop,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: secondColor,
                    actions: [
                      AleraAction(
                        label: 'Cancel',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ExampleButton(
                color: secondColor,
                label: 'Error',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.error,
                     style: AleraStyle.floatingTop,
                    title: 'Connection error',
                    message:
                        'We were unable to complete the operation because the server '
                        'could not be reached. Please verify your internet connection '
                        'and try again. If the problem continues, wait a few moments '
                        'before attempting the operation again. Your information has '
                        'not been lost and no additional changes were made.',
                    primaryColor: secondColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

              _ExampleButton(
                color: secondColor,
                label: 'Fail',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.fail,
                    style: AleraStyle.floatingTop,
                    title: 'Fail',
                    message:
                        'The operation could not be completed because '
                        'a technical error occurred.',
                    primaryColor: secondColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

                _ExampleButton(
            color: secondColor,
            label: 'Loading A',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.loading,
                style: AleraStyle.floatingTop,
                title: 'Loading',
                message: 'Cargando registro',
                primaryColor: secondColor,
                barrierDismissible: false,
              );
            },
          ),

          _ExampleButton(
            color: secondColor,
            label: 'Loading B',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.loading,
                style: AleraStyle.floatingTop,
                title: 'Loading',
                message: 'Cargando registro',
                primaryColor: secondColor,
                barrierDismissible: false,
                actions: [
                  AleraAction(
                    label: 'Cancel',
                    onPressed: () {
                      debugPrint('Loading cancelled');
                    },
                  ),
                ],
              );
            },
          ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ExampleButton(
                color: secondColor,
                label: 'Information A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.info,
                    style: AleraStyle.floatingTop,
                    title: 'Información',
                    message: 'Este mensaje no requiere ninguna acción.',
                    primaryColor: secondColor,
                  );
                },
              ),

               _ExampleButton(
               color: secondColor,
            label: 'Information B',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.floatingTop,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: secondColor,
                actions: [
                  AleraAction(
                    label: 'Ok',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          _ExampleButton(
            color: secondColor,
            label: 'Information C',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.floatingTop,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: secondColor,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: false,
                    onPressed: () {},
                  ),
                  AleraAction(
                    label: 'Cancel',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),
            ],
          ),

          Divider(),

          Text('Alerts Style CornerBarge', style: TextStyle(fontSize: 20, color: primaryColor, fontWeight: FontWeight.w600),),
          const SizedBox(height: 12),

          _ExampleButton(
            color: thirtyColor,
            label: 'Success',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.success,
                style: AleraStyle.cornerBadge,
                transition: AleraTransition.forward,
                title: 'Success',
                message: 'Your operation was completed successfully.',
                primaryColor: thirtyColor,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ExampleButton(
                color: thirtyColor,
                label: 'Warning A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.cornerBadge,
                    transition: AleraTransition.bottom,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: thirtyColor 
                  );
                },
              ),
              _ExampleButton(
                color: thirtyColor,
                label: 'Warning B',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.cornerBadge,
                    transition: AleraTransition.fadeScale,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: thirtyColor,
                    actions: [
                      AleraAction(
                        label: 'Ok',
                        onPressed: () {},
                      ),
               
                    ],
                  );
                },
              ),
              _ExampleButton(
                color: thirtyColor,
                label: 'Warning C',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.warning,
                    style: AleraStyle.cornerBadge,
                    transition: AleraTransition.left,
                    title: 'Warning',
                    message: 'Would you like to try again?',
                    primaryColor: thirtyColor,
                    actions: [
                      AleraAction(
                        label: 'Cancel',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ExampleButton(
                color: thirtyColor,
                label: 'Error',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.error,
                     style: AleraStyle.cornerBadge,
                     transition: AleraTransition.right,
                    title: 'Connection error',
                    message:
                        'The operation could not be completed because '
                        'a technical error occurred.',
                    primaryColor: thirtyColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

              _ExampleButton(
                color: thirtyColor,
                label: 'Fail',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.fail,
                    style: AleraStyle.cornerBadge,
                    transition: AleraTransition.top,
                    title: 'Fail',
                    message:
                        'The operation could not be completed because '
                        'a technical error occurred.',
                    primaryColor: thirtyColor,
                    actions: [
                      AleraAction(
                        label: 'Close',
                        onPressed: () {},
                      ),
                      AleraAction(
                        label: 'Retry',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),

          _ExampleButton(
            color: thirtyColor,
            label: 'Loading A',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.loading,
                style: AleraStyle.cornerBadge,
                title: 'Loading',
                message: 'Cargando registro',
                primaryColor: thirtyColor,
                barrierDismissible: false,
              );
            },
          ),

         _ExampleButton(
          color: thirtyColor,
          label: 'Loading B',
          onPressed: () async {
            final loading =
                Alera.showLoading(
              context,
              style:
                  AleraStyle.cornerBadge,
                  transition: AleraTransition.tiltIn,
              title: 'Loading',
              message: 'Cargando registro',
              primaryColor:
                  thirtyColor,
              action: AleraAction(
                label: 'Cancel',
                onPressed: () {
                  debugPrint(
                    'Loading cancelled',
                  );
                },
              ),
            );

            await Future.delayed(
              const Duration(
                seconds: 4,
              ),
            );

            loading.close();
          },
        ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ExampleButton(
                color: thirtyColor,
                label: 'Information A',
                onPressed: () {
                  Alera.show(
                    context,
                    type: AleraType.info,
                    style: AleraStyle.cornerBadge,
                    transition: AleraTransition.adaptive,
                    title: 'Información',
                    message: 'This message contains additional information about the operation '
                    'you are currently performing. Some processes may require more '
                    'time depending on your network connection and the amount of data '
                    'being processed. You can continue using the application normally '
                    'while the requested information is prepared.',
                    primaryColor: thirtyColor,
                  );
                },
              ),

               _ExampleButton(
                color: thirtyColor,
            label: 'Information B',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.cornerBadge,
                transition: AleraTransition.tiltIn,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: thirtyColor,
                actions: [
                  AleraAction(
                    label: 'Ok',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          _ExampleButton(
            color: thirtyColor,
            label: 'Information C',
            onPressed: () {
              Alera.show(
                context,
                type: AleraType.info,
                style: AleraStyle.cornerBadge,
                transition: AleraTransition.none,
                title: 'Information',
                message:
                    'This alert is intended to display general '
                    'or informative content.',
                primaryColor: thirtyColor,
                actions: [
                  AleraAction(
                    label: 'Accept',
                    isPrimary: false,
                    onPressed: () {},
                  ),
                  AleraAction(
                    label: 'Cancel',
                    isPrimary: true,
                    onPressed: () {},
                  ),
                ],
              );
            },
          ),

          
            ],
          ),

          Divider(),
         
        ],
      ),
    );
  }
}

class _ExampleButton extends StatelessWidget {
  const _ExampleButton({
    required this.label,
    required this.onPressed,
    required this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        child: Text(label),
      ),
      
    );
  }
}