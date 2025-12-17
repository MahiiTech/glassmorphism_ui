import 'dart:ui';
import 'package:flutter/material.dart';

/// A widget that creates a glassmorphism effect by blurring the background
/// and applying a translucent container with optional border and shadow.
///
/// The [GlassContainer] applies a blur effect to the background behind it,
/// and overlays a semi-transparent container with customizable opacity,
/// border, background color, and shadow.
///
/// Example usage:
/// ```dart
/// GlassContainer(
///   blur: 20,
///   opacity: 0.3,
///   borderRadius: BorderRadius.circular(15),
///   borderColor: Colors.white.withOpacity(0.3),
///   borderWidth: 1.5,
///   shadowColor: Colors.black.withOpacity(0.1),
///   shadowBlurRadius: 10,
///   padding: EdgeInsets.all(20),
///   child: Text("Glassmorphism!"),
/// )
/// ```
class GlassContainer extends StatelessWidget {
  /// The child widget displayed inside the glass container.
  final Widget child;

  /// The sigma value for the Gaussian blur effect.
  /// Higher values create more blur.
  final double blur;

  /// The opacity of the white overlay.
  /// Value between 0.0 (fully transparent) and 1.0 (fully opaque).
  final double opacity;

  /// The border radius of the glass container's rounded corners.
  final BorderRadius borderRadius;

  /// The color of the container's background.
  /// Defaults to white with opacity set by [opacity].
  final Color? backgroundColor;

  /// The color of the border around the container.
  /// Defaults to white with 30% opacity.
  final Color borderColor;

  /// The width of the border.
  /// Defaults to 1.0.
  final double borderWidth;

  /// The color of the shadow cast by the container.
  /// Defaults to fully transparent (no shadow).
  final Color shadowColor;

  /// The blur radius of the shadow.
  /// Defaults to 0 (no shadow).
  final double shadowBlurRadius;

  /// The padding inside the glass container around the [child].
  final EdgeInsetsGeometry padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15,
    this.opacity = 0.2,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.backgroundColor,
    this.borderColor = const Color.fromARGB(77, 255, 255, 255), // white30
    this.borderWidth = 1.0,
    this.shadowColor = Colors.transparent,
    this.shadowBlurRadius = 0,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        // Blur the background behind this widget
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            // Use custom background color or default to white with opacity
            color: (backgroundColor ?? Colors.white).withOpacity(opacity),
            borderRadius: borderRadius,
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: shadowBlurRadius,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
