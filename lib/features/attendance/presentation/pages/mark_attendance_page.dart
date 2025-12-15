import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';
import '../../../../core/widgets/custom_button.dart';

class MarkAttendancePage extends GetView<AttendanceController> {
  const MarkAttendancePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        controller.currentLocation != null
                            ? 'Lat: ${controller.currentLocation!.latitude.toStringAsFixed(6)}\n'
                                'Lng: ${controller.currentLocation!.longitude.toStringAsFixed(6)}'
                            : 'Location not available',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => controller.currentLocation != null
                          ? controller.isWithinGeofence
                              ? const Chip(
                                  label: Text('Within School Premises'),
                                  backgroundColor: Colors.green,
                                  labelStyle: TextStyle(color: Colors.white),
                                )
                              : const Chip(
                                  label: Text('Outside School Premises'),
                                  backgroundColor: Colors.red,
                                  labelStyle: TextStyle(color: Colors.white),
                                )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => CustomButton(
                        text: 'Check Location',
                        isLoading: controller.isLoading,
                        onPressed: controller.checkLocation,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Capture Selfie',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => controller.capturedImage != null
                          ? Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    controller.capturedImage!,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: controller.capturePhoto,
                                  child: const Text('Retake Photo'),
                                ),
                              ],
                            )
                          : CustomButton(
                              text: 'Capture Photo',
                              onPressed: controller.capturePhoto,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => CustomButton(
                text: 'Mark Attendance',
                isLoading: controller.isLoading,
                onPressed: controller.markAttendance,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
