import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/body_text.dart';
import 'package:schedule_app_flutter/utils/constants.dart';

class SpinnerDay extends StatefulWidget {
  final int selectedDayIndex;
  final Function(int) onDayChanged;

  const SpinnerDay({
    Key? key,
    required this.selectedDayIndex,
    required this.onDayChanged,
  }) : super(key: key);

  @override
  _SpinnerDayState createState() => _SpinnerDayState();
}

class _SpinnerDayState extends State<SpinnerDay> {
  late FixedExtentScrollController _extentScrollController;

  @override
  void initState() {
    super.initState();
    _extentScrollController = FixedExtentScrollController(initialItem: widget.selectedDayIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Stack(
                children: [
                  ListWheelScrollView.useDelegate(
                    controller: _extentScrollController,
                    itemExtent: 35,
                    onSelectedItemChanged: (index) {
                      widget.onDayChanged(index);
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(left: 32),
                          alignment: Alignment.centerLeft,
                          child: BodyText(
                            text: Constants.days[index],
                            size: 18,
                            color: Colors.black87,
                          ),
                        );
                      },
                      childCount: Constants.days.length,
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.95),
                              Colors.white.withOpacity(0.0),
                              Colors.white.withOpacity(0.95),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            right: 5,
            child: Icon(Icons.swipe_vertical_outlined, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _extentScrollController.dispose();
    super.dispose();
  }
}
