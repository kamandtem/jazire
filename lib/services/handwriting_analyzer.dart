import 'dart:math' as math;
import 'package:flutter/material.dart';

class StrokeSample { const StrokeSample(this.points); final List<Offset> points; }
class HandwritingResult {
  const HandwritingResult({required this.coverage, required this.orderScore, required this.connected, required this.accepted, required this.message});
  final double coverage, orderScore;
  final bool connected, accepted;
  final String message;
}

/// Lightweight, offline stroke evaluator. It measures coverage and direction,
/// while leaving room for per-glyph templates later.
class HandwritingAnalyzer {
  const HandwritingAnalyzer();
  HandwritingResult analyze({required List<StrokeSample> strokes, required Rect target, bool requireConnection = false}) {
    if (strokes.isEmpty) return const HandwritingResult(coverage: 0, orderScore: 0, connected: false, accepted: false, message: 'هنوز چیزی نوشته نشده است.');
    final all = strokes.expand((s) => s.points).toList();
    final inside = all.where(target.contains).length / all.length;
    final length = strokes.fold<double>(0, (sum, s) => sum + _length(s.points));
    final diagonal = math.sqrt(target.width * target.width + target.height * target.height);
    final order = (length / math.max(diagonal, 1)).clamp(0.0, 1.0);
    final connected = strokes.length == 1 || _hasNearbyEnds(strokes, target.shortestSide * .16);
    final accepted = inside >= .35 && order >= .08 && (!requireConnection || connected);
    final message = accepted ? 'خوب نوشتی، مسیر نشانه پوشش داده شد.' : 'کمی آرام‌تر و نزدیک‌تر به الگو بنویس.';
    return HandwritingResult(coverage: inside, orderScore: order, connected: connected, accepted: accepted, message: message);
  }
  double _length(List<Offset> points) { var value = 0.0; for (var i = 1; i < points.length; i++) { value += (points[i] - points[i - 1]).distance; } return value; }
  bool _hasNearbyEnds(List<StrokeSample> strokes, double radius) { for (var i = 0; i < strokes.length; i++) { for (var j = i + 1; j < strokes.length; j++) { final a = strokes[i].points.last; final b = strokes[j].points.first; if ((a - b).distance <= radius) return true; } } return false; }
}
