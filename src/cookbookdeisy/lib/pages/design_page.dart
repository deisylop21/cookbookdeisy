// Created by: deisylop21
// Date: 2025-01-15 09:19:28 UTC
// Description: UI Design Gallery App

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Definición de colores constantes
class AppColors {
  static const Color primary = Color(0xFF8B4513);
  static const Color background = Color(0xFFF5F5DC);
  static const Color darkBrown = Color(0xFF654321);
  static const Color tan = Color(0xFFD2B48C);
  static const Color sienna = Color(0xFFA0522D);
  static const Color woodBrown = Color(0xFF966F33);
}

class DesignPage extends StatefulWidget {
  const DesignPage({super.key});

  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> sections = [
    {
      'title': 'Componentes',
      'icon': Icons.widgets_rounded,
      'items': [
        {
          'title': 'Botones',
          'subtitle': 'Diseños de botones interactivos',
          'icon': Icons.touch_app_rounded,
          'widget': const ButtonsShowcase(),
        },
        {
          'title': 'Tarjetas',
          'subtitle': 'Diseños modernos de tarjetas',
          'icon': Icons.credit_card_rounded,
          'widget': const CardsShowcase(),
        },
        {
          'title': 'Colores',
          'subtitle': 'Muestra de esquema de colores',
          'icon': Icons.palette_rounded,
          'widget': const ColorSchemeShowcase(),
        },
      ],
    },
    {
      'title': 'Animación',
      'icon': Icons.animation_rounded,
      'items': [
        {
          'title': 'Contenedor',
          'subtitle': 'Contenedores animados',
          'icon': Icons.crop_square_rounded,
          'widget': const AnimatedContainerShowcase(),
        },
        {
          'title': 'Carga',
          'subtitle': 'Animaciones de carga',
          'icon': Icons.refresh_rounded,
          'widget': const LoadingEffectsShowcase(),
        },
      ],
    },
    {
      'title': 'Temas',
      'icon': Icons.brush_rounded,
      'items': [
        {
          'title': 'Personalización',
          'subtitle': 'Personalización de temas',
          'icon': Icons.style_rounded,
          'widget': const ThemeSwitcherShowcase(),
        },
      ],
    },
    {
      'title': 'Diseño',
      'icon': Icons.grid_view_rounded,
      'items': [
        {
          'title': 'Responsivo',
          'subtitle': 'Diseños adaptativos',
          'icon': Icons.devices_rounded,
          'widget': const ResponsiveLayoutShowcase(),
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: sections.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Text(
                    'Galería de Diseño UI',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: AppColors.background,
                  indicatorWeight: 3,
                  padding: const EdgeInsets.only(bottom: 8),
                  tabs: sections.map((section) {
                    return Tab(
                      child: Row(
                        children: [
                          Icon(
                            section['icon'] as IconData,
                            color: AppColors.background,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            section['title'] as String,
                            style: GoogleFonts.poppins(
                              color: AppColors.background,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: sections.map((section) {
            return _buildSectionContent(section);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSectionContent(Map<String, dynamic> section) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: (section['items'] as List).length,
      itemBuilder: (context, index) {
        final item = section['items'][index] as Map<String, dynamic>;
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showItemDetails(context, item['title'] as String, item['widget'] as Widget),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          item['subtitle'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showItemDetails(BuildContext context, String title, Widget content) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Text(
              title,
              style: GoogleFonts.poppins(
                color: AppColors.background,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: IconThemeData(color: AppColors.background),
            elevation: 0,
          ),
          body: content,
        ),
      ),
    );
  }
}
// ButtonsShowcase
class ButtonsShowcase extends StatefulWidget {
  const ButtonsShowcase({super.key});

  @override
  ButtonsShowcaseState createState() => ButtonsShowcaseState();
}

class ButtonsShowcaseState extends State<ButtonsShowcase> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                setState(() => isLoading = true);
                await Future.delayed(const Duration(seconds: 2));
                if (mounted) setState(() => isLoading = false);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
              ),
              child: isLoading
                  ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.background),
                ),
              )
                  : const Text('Elevated Button'),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Filled Button'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(200, 50),
                backgroundColor: AppColors.woodBrown,
                foregroundColor: AppColors.background,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(200, 50),
                side: BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
              ),
              child: const Text('Outlined Button'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                minimumSize: const Size(200, 50),
                foregroundColor: AppColors.sienna,
              ),
              child: const Text('Text Button'),
            ),
            const SizedBox(height: 32),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(
                  value: 0,
                  label: Text('Opción 1'),
                  icon: Icon(Icons.looks_one),
                ),
                ButtonSegment(
                  value: 1,
                  label: Text('Opción 2'),
                  icon: Icon(Icons.looks_two),
                ),
                ButtonSegment(
                  value: 2,
                  label: Text('Opción 3'),
                  icon: Icon(Icons.looks_3),
                ),
              ],
              selected: {0},
              onSelectionChanged: (Set<int> newSelection) {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColors.primary;
                    }
                    return AppColors.background;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return AppColors.background;
                    }
                    return AppColors.primary;
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.small(
                  onPressed: () {},
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: AppColors.woodBrown,
                  foregroundColor: AppColors.background,
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton.large(
                  onPressed: () {},
                  backgroundColor: AppColors.sienna,
                  foregroundColor: AppColors.background,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// CardsShowcase
class CardsShowcase extends StatelessWidget {
  const CardsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Elevated Card',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'This is an elevated card example',
                  style: TextStyle(color: AppColors.darkBrown),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                  child: const Text('ACCIÓN'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.network(
                'https://picsum.photos/500/200',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card con Imagen',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Ejemplo de card con imagen y acciones',
                      style: TextStyle(color: AppColors.darkBrown),
                    ),
                    const SizedBox(height: 8),
                    ButtonBar(
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.sienna,
                          ),
                          child: const Text('CANCELAR'),
                        ),
                        FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.background,
                          ),
                          child: const Text('ACEPTAR'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: AppColors.background),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Card Interactiva',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Toca para más información',
                          style: TextStyle(color: AppColors.darkBrown),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColors.primary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ColorSchemeShowcase
class ColorSchemeShowcase extends StatelessWidget {
  const ColorSchemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        final colors = [
          AppColors.primary,
          AppColors.darkBrown,
          AppColors.tan,
          AppColors.sienna,
          AppColors.woodBrown,
          AppColors.primary.withOpacity(0.7),
          AppColors.darkBrown.withOpacity(0.7),
          AppColors.sienna.withOpacity(0.7),
        ];
        final labels = [
          'Primary',
          'Dark Brown',
          'Tan',
          'Sienna',
          'Wood Brown',
          'Primary 70%',
          'Dark Brown 70%',
          'Sienna 70%',
        ];
        return Container(
          decoration: BoxDecoration(
            color: colors[index],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colors[index].withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            labels[index],
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: colors[index].computeLuminance() > 0.5 ?
              AppColors.primary : AppColors.background,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
// AnimatedContainerShowcase
class AnimatedContainerShowcase extends StatefulWidget {
  const AnimatedContainerShowcase({super.key});

  @override
  AnimatedContainerShowcaseState createState() => AnimatedContainerShowcaseState();
}

class AnimatedContainerShowcaseState extends State<AnimatedContainerShowcase> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          width: _isExpanded ? 200 : 100,
          height: _isExpanded ? 200 : 100,
          decoration: BoxDecoration(
            color: _isExpanded ? AppColors.primary : AppColors.woodBrown,
            borderRadius: BorderRadius.circular(_isExpanded ? 32 : 16),
            boxShadow: [
              BoxShadow(
                color: (_isExpanded ? AppColors.primary : AppColors.woodBrown)
                    .withOpacity(0.3),
                blurRadius: _isExpanded ? 12 : 6,
                spreadRadius: _isExpanded ? 2 : 0,
                offset: Offset(0, _isExpanded ? 4 : 2),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                _isExpanded ? Icons.remove : Icons.add,
                key: ValueKey<bool>(_isExpanded),
                color: AppColors.background,
                size: _isExpanded ? 48 : 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// LoadingEffectsShowcase
class LoadingEffectsShowcase extends StatelessWidget {
  const LoadingEffectsShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    backgroundColor: AppColors.tan.withOpacity(0.3),
                    strokeWidth: 4,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Circular Progress',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.woodBrown),
                    backgroundColor: AppColors.tan.withOpacity(0.3),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Linear Progress',
                    style: GoogleFonts.poppins(
                      color: AppColors.woodBrown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.sienna),
                    backgroundColor: AppColors.tan.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Adaptive Progress',
                    style: GoogleFonts.poppins(
                      color: AppColors.sienna,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ThemeSwitcherShowcase
class ThemeSwitcherShowcase extends StatefulWidget {
  const ThemeSwitcherShowcase({super.key});

  @override
  ThemeSwitcherShowcaseState createState() => ThemeSwitcherShowcaseState();
}

class ThemeSwitcherShowcaseState extends State<ThemeSwitcherShowcase> {
  bool isDark = false;
  Color selectedColor = AppColors.primary;
  final List<Color> colorOptions = [
    AppColors.primary,
    AppColors.darkBrown,
    AppColors.tan,
    AppColors.sienna,
    AppColors.woodBrown,
    AppColors.primary.withOpacity(0.7),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                subtitle: Text(
                  'Toggle between light and dark theme',
                  style: GoogleFonts.poppins(
                    color: AppColors.darkBrown,
                  ),
                ),
                value: isDark,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    isDark = value;
                  });
                },
              ),
              const Divider(height: 32),
              Text(
                'Theme Colors',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedColor == color
                              ? AppColors.background
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          if (selectedColor == color)
                            BoxShadow(
                              color: color.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: selectedColor == color
                          ? Icon(
                        Icons.check,
                        color: AppColors.background,
                      )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBrown : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selectedColor.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Preview',
                      style: TextStyle(
                        color: isDark ? AppColors.background : selectedColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedColor,
                        foregroundColor: AppColors.background,
                      ),
                      onPressed: () {},
                      child: const Text('Sample Button'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ResponsiveLayoutShowcase
class ResponsiveLayoutShowcase extends StatelessWidget {
  const ResponsiveLayoutShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _wideLayout();
        } else {
          return _narrowLayout();
        }
      },
    );
  }

  Widget _wideLayout() {
    return Row(
      children: [
        Expanded(
          child: _buildContent(),
        ),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _narrowLayout() {
    return _buildContent();
  }

  Widget _buildContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'Item ${index + 1}',
              style: GoogleFonts.poppins(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Description for item ${index + 1}',
              style: TextStyle(
                color: AppColors.darkBrown,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.woodBrown,
              size: 16,
            ),
          ),
        );
      },
    );
  }
}