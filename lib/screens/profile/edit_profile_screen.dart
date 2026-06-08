import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/luxury_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  
  final _firestoreService = FirestoreService();
  final _picker = ImagePicker();
  
  File? _avatarFile;
  File? _bgFile;
  String _bgLocalPath = '';
  String _avatarLocalPath = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _ageController = TextEditingController(text: widget.user.age > 0 ? widget.user.age.toString() : '');
    _weightController = TextEditingController(text: widget.user.weight > 0 ? widget.user.weight.toString() : '');
    _heightController = TextEditingController(text: widget.user.height > 0 ? widget.user.height.toString() : '');
    _loadLocalPaths();
  }

  Future<void> _loadLocalPaths() async {
    if (widget.user.backgroundUrl.isNotEmpty) {
      _bgLocalPath = await _firestoreService.getLocalImagePath(widget.user.backgroundUrl);
    }
    if (widget.user.photoUrl.isNotEmpty) {
      _avatarLocalPath = await _firestoreService.getLocalImagePath(widget.user.photoUrl);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isAvatar) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isAvatar) {
          _avatarFile = File(pickedFile.path);
        } else {
          _bgFile = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String avatarUrl = widget.user.photoUrl;
      String bgUrl = widget.user.backgroundUrl;

      // Upload new images if selected
      if (_avatarFile != null) {
        avatarUrl = await _firestoreService.saveImageLocally(widget.user.uid, _avatarFile!, true);
      }
      if (_bgFile != null) {
        bgUrl = await _firestoreService.saveImageLocally(widget.user.uid, _bgFile!, false);
      }

      // Update data
      final updatedData = {
        'name': _nameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()) ?? widget.user.age,
        'weight': double.tryParse(_weightController.text.trim()) ?? widget.user.weight,
        'height': double.tryParse(_heightController.text.trim()) ?? widget.user.height,
        'photoUrl': avatarUrl,
        'backgroundUrl': bgUrl,
      };

      await _firestoreService.updateUser(widget.user.uid, updatedData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật hồ sơ thành công!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e'), backgroundColor: Colors.redAccent),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chỉnh sửa hồ sơ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D1B2A), Color(0xFF1B263B), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Images Section
                  GestureDetector(
                    onTap: () => _pickImage(false),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                        image: _bgFile != null
                            ? DecorationImage(image: FileImage(_bgFile!), fit: BoxFit.cover)
                            : (_bgLocalPath.isNotEmpty
                                ? DecorationImage(image: FileImage(File(_bgLocalPath)), fit: BoxFit.cover)
                                : null),
                      ),
                      child: _bgFile == null && _bgLocalPath.isEmpty
                          ? const Center(child: Icon(Icons.camera_alt, color: Colors.white54, size: 40))
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Nhấn vào ảnh để đổi ảnh nền', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white10,
                      backgroundImage: _avatarFile != null
                          ? FileImage(_avatarFile!)
                          : (_avatarLocalPath.isNotEmpty ? FileImage(File(_avatarLocalPath)) : null) as ImageProvider?,
                      child: _avatarFile == null && _avatarLocalPath.isEmpty
                          ? const Icon(Icons.person, color: Colors.white54, size: 50)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Đổi ảnh đại diện', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  
                  const SizedBox(height: 40),

                  // Form Fields
                  LuxuryTextField(
                    hintText: "Họ và tên",
                    icon: Icons.person_rounded,
                    controller: _nameController,
                  ),
                  LuxuryTextField(
                    hintText: "Tuổi",
                    icon: Icons.cake_rounded,
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                  ),
                  LuxuryTextField(
                    hintText: "Chiều cao (cm)",
                    icon: Icons.height_rounded,
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                  ),
                  LuxuryTextField(
                    hintText: "Cân nặng (kg)",
                    icon: Icons.monitor_weight_rounded,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                  ),
                  
                  const SizedBox(height: 40),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              "LƯU THAY ĐỔI",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
