import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../tasks/presentation/screens/ppm_checklist_screen.dart';
import '../../../tasks/presentation/screens/breakdown_repair_screen.dart';
import '../../../assets/presentation/screens/asset_details_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _isFlashOn = false;
  final MobileScannerController _controller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
                _showAssetDialog(barcode.rawValue ?? "Unknown");
                break;
              }
            },
          ),
          _buildOverlay(),
          _buildTopActions(),
          _buildBottomInfo(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: AppColors.primary,
          borderRadius: 20,
          borderLength: 40,
          borderWidth: 8,
          cutOutSize: 280,
        ),
      ),
    );
  }

  Widget _buildTopActions() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Remix.arrow_left_line, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(100),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(
                  _isFlashOn ? Remix.flashlight_fill : Remix.flashlight_line,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isFlashOn = !_isFlashOn;
                    _controller.toggleTorch();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Column(
        children: [
          const Text(
            "Scan Asset QR Code",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 10, color: Colors.black)],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Align the QR code within the frame",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              shadows: [Shadow(blurRadius: 10, color: Colors.black)],
            ),
          ),
        ],
      ),
    );
  }

  void _showAssetDialog(String code) {
    _controller.stop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AssetDetailsSheet(assetId: code),
    ).then((_) => _controller.start());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AssetDetailsSheet extends StatelessWidget {
  final String assetId;
  const _AssetDetailsSheet({required this.assetId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Asset Identified",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Remix.close_line),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAssetInfo(context),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  "Start PPM",
                  Remix.tools_line,
                  AppColors.primary,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PPMChecklistScreen(
                          assetName: "Centrifugal Pump CP-04",
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context,
                  "Raise Ticket",
                  Remix.error_warning_line,
                  AppColors.danger,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreakdownRepairScreen(
                          ticketId: "NEW-TICKET",
                          assetName: "Centrifugal Pump CP-04",
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            "View History",
            Remix.history_line,
            AppColors.info,
            isFullWidth: true,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AssetDetailsScreen(
                    assetName: "Centrifugal Pump CP-04",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssetInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Remix.box_3_line, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Centrifugal Pump CP-04",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "ID: $assetId",
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const Text(
                  "Location: Pump Room 2",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color, {
    bool isFullWidth = false,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(isFullWidth ? double.infinity : 0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

// Custom Painter for QR Overlay
class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double cutOutSize;

  const QrScannerOverlayShape({
    required this.borderColor,
    this.borderRadius = 10,
    this.borderLength = 40,
    this.borderWidth = 10,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()..addRect(rect);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;

    final boxRect = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: cutOutSize,
      height: cutOutSize,
    );

    final backgroundPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    final cutOutPath = Path()
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndRadius(boxRect, Radius.circular(borderRadius)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(cutOutPath, backgroundPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderPath = Path();

    // Top Left
    borderPath.moveTo(boxRect.left, boxRect.top + borderLength);
    borderPath.lineTo(boxRect.left, boxRect.top + borderRadius);
    borderPath.arcToPoint(
      Offset(boxRect.left + borderRadius, boxRect.top),
      radius: Radius.circular(borderRadius),
    );
    borderPath.lineTo(boxRect.left + borderLength, boxRect.top);

    // Top Right
    borderPath.moveTo(boxRect.right - borderLength, boxRect.top);
    borderPath.lineTo(boxRect.right - borderRadius, boxRect.top);
    borderPath.arcToPoint(
      Offset(boxRect.right, boxRect.top + borderRadius),
      radius: Radius.circular(borderRadius),
    );
    borderPath.lineTo(boxRect.right, boxRect.top + borderLength);

    // Bottom Left
    borderPath.moveTo(boxRect.left, boxRect.bottom - borderLength);
    borderPath.lineTo(boxRect.left, boxRect.bottom - borderRadius);
    borderPath.arcToPoint(
      Offset(boxRect.left + borderRadius, boxRect.bottom),
      radius: Radius.circular(borderRadius),
    );
    borderPath.lineTo(boxRect.left + borderLength, boxRect.bottom);

    // Bottom Right
    borderPath.moveTo(boxRect.right - borderLength, boxRect.bottom);
    borderPath.lineTo(boxRect.right - borderRadius, boxRect.bottom);
    borderPath.arcToPoint(
      Offset(boxRect.right, boxRect.bottom - borderRadius),
      radius: Radius.circular(borderRadius),
    );
    borderPath.lineTo(boxRect.right, boxRect.bottom - borderLength);

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => QrScannerOverlayShape(borderColor: borderColor);
}
