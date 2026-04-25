import 'package:flutter/material.dart';

// Enum pour spécifier la direction de la transition
enum TransitionDirection {
  fromRight,
  fromLeft,
  fromTop,
  fromBottom,
  fromDiagTopLeft,
  fromDiagBottomRight,
}

Route createRouteWithTransition({
  required Widget child,
  required TransitionDirection direction,
}) {
  Offset getBeginOffset(TransitionDirection direction) {
    switch (direction) {
      case TransitionDirection.fromRight:
        return const Offset(1.0, 0.0);
      case TransitionDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case TransitionDirection.fromTop:
        return const Offset(0.0, -1.0);
      case TransitionDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case TransitionDirection.fromDiagTopLeft:
        return const Offset(-1.0, -1.0);
      case TransitionDirection.fromDiagBottomRight:
        return const Offset(1.0, 1.0);
    }
  }

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = getBeginOffset(direction);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
