// Created by: deisylop21
// Date: 2025-01-16 00:01:28 UTC
// Description: Formulario UI con diseño personalizado

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF8B4513);
  static const Color background = Color(0xFFF5F5DC);
  static const Color darkBrown = Color(0xFF654321);
  static const Color tan = Color(0xFFD2B48C);
  static const Color sienna = Color(0xFFA0522D);
  static const Color woodBrown = Color(0xFF966F33);
}

class FormsPage extends StatefulWidget {
  const FormsPage({super.key});

  @override
  State<FormsPage> createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Deisy');
  final _emailController = TextEditingController(text: 'deisylopez@gmail.com');
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.primary,
                toolbarHeight: 80,
                centerTitle: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulario',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.background,
                        ),
                      ),
                      Text(
                        'Completa tus datos',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.background.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth > 600 ?
                  constraints.maxWidth * 0.2 : 20,
                  vertical: 20,
                ),
                sliver: SliverToBoxAdapter(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            AppColors.background.withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 24),
                            _buildTextFields(constraints),
                            const SizedBox(height: 16),
                            _buildTermsAndConditions(),
                            const SizedBox(height: 24),
                            _buildSubmitButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¡Hola!',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Completa el formulario y gana un carro de hot wheels',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.darkBrown,
          ),
        ),
        const Divider(height: 32, color: AppColors.tan),
      ],
    );
  }

  Widget _buildTextFields(BoxConstraints constraints) {
    final isWide = constraints.maxWidth > 600;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: isWide ? (constraints.maxWidth - 100) / 2 : double.infinity,
          child: _buildTextField(
            controller: _nameController,
            label: 'Nombre',
            hint: 'Ingresa tu nombre completo',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: isWide ? (constraints.maxWidth - 100) / 2 : double.infinity,
          child: _buildTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Ingresa tu email',
            icon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu email';
              }
              if (!value.contains('@')) {
                return 'Por favor ingresa un email válido';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: isWide ? (constraints.maxWidth - 100) / 2 : double.infinity,
          child: _buildTextField(
            controller: _phoneController,
            label: 'Teléfono',
            hint: 'Ingresa tu número de teléfono',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
        ),
        SizedBox(
          width: isWide ? (constraints.maxWidth - 100) / 2 : double.infinity,
          child: _buildTextField(
            controller: _messageController,
            label: 'Mensaje',
            hint: 'Escribe tu mensaje',
            icon: Icons.message,
            maxLines: 3,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(color: AppColors.darkBrown),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: AppColors.tan),
        labelStyle: GoogleFonts.poppins(color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _acceptTerms,
            onChanged: (value) {
              setState(() => _acceptTerms = value ?? false);
            },
            activeColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'Acepto los ',
              style: GoogleFonts.poppins(color: AppColors.darkBrown),
              children: [
                TextSpan(
                  text: 'términos y condiciones',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: (_isLoading || !_acceptTerms) ? null : _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.tan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (_isLoading)
                const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                Transform.scale(
                  scale: 1 + 0.1 * _animationController.value,
                  child: Text(
                    'Enviar Formulario',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _animationController.repeat(reverse: true);

      // Simular envío de formulario
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        _animationController.stop();
        setState(() => _isLoading = false);
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 30),
            const SizedBox(width: 8),
            Text(
              '¡Éxito!',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        content: Text(
          'Tu mensaje ha sido enviado correctamente. Nos pondremos en contacto contigo pronto.',
          style: GoogleFonts.poppins(color: AppColors.darkBrown),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Aceptar',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}