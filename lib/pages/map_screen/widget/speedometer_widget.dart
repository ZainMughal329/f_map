import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedoMeterWidget extends StatelessWidget {
  const SpeedoMeterWidget({super.key, required this.speed});
  final double speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: 110,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 200,
            labelOffset: 10,
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor,
                thickness: 0.03),
            majorTickStyle: MajorTickStyle(
                length: 2,
                thickness: 0.5,
                color: Colors.black),
            minorTickStyle: MinorTickStyle(
                length: 2,
                thickness: 0.5,
                color: Colors.black),
            axisLabelStyle: GaugeTextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 10),
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: 200,
                sizeUnit: GaugeSizeUnit.factor,
                startWidth: 0.03,
                endWidth: 0.03,
                gradient: SweepGradient(
                  colors: const <Color>[
                    Colors.green,
                    Colors.yellow,
                    Colors.red
                  ],
                  stops: const <double>[0.0, 0.5, 1],
                ),
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: speed,
                needleLength: 0.95,
                enableAnimation: true,
                animationType: AnimationType.ease,
                needleStartWidth: 0.20,
                needleEndWidth: 2,
                needleColor: Colors.red,
                knobStyle: KnobStyle(knobRadius: 0.05),
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          speed
                              .toStringAsFixed(2)
                              .toString(),
                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 05),
                        Text(
                          'kmph',
                          style: TextStyle(
                              fontSize: 7,
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.75),
            ],
          ),
        ],
      ),
    );
  }
}
