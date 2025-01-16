import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cookbookdeisy/pages/design_page.dart';
import 'package:cookbookdeisy/pages/forms_page.dart';
import 'package:cookbookdeisy/pages/images_page.dart';
import 'package:cookbookdeisy/pages/lists_page.dart';
import 'package:cookbookdeisy/pages/navigation_page.dart';
import 'package:cookbookdeisy/pages/news_page.dart';
import 'package:cookbookdeisy/pages/profile_page.dart';

void main() {
  runApp(const cookbookdeisy());
}

class cookbookdeisy extends StatelessWidget {
  const cookbookdeisy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Cookbook',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8B4513), // Saddle Brown
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8B4513), // Saddle Brown
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = true;
  int _currentIndex = 0;

  final categories = [
    {
      'title': 'Diseño de UI',
      'icon': 'assets/lottie/design.json',
      'route': const DesignPage(),
      'color': const Color(0xFF8B4513), // Saddle Brown
      'description': 'Explora hermosos componentes de UI y animaciones',
    },
    {
      'title': 'Formularios Inteligentes',
      'icon': 'assets/lottie/forms.json',
      'route': const FormsPage(),
      'color': const Color(0xFF654321), // Dark Brown
      'description': 'Formularios interactivos y validados',
    },
    {
      'title': 'Imágenes Dinámicas',
      'icon': 'assets/lottie/images.json',
      'route': const ImagesPage(),
      'color': const Color(0xFFD2B48C), // Tan
      'description': 'Técnicas avanzadas de manejo de imágenes',
    },
    {
      'title': 'Listas Animadas',
      'icon': 'assets/lottie/lists.json',
      'route': const ListsPage(),
      'color': const Color(0xFFA0522D), // Sienna
      'description': 'Hermosas animaciones e interacciones en listas',
    },
    {
      'title': 'Navegación Suave.',
      'icon': 'assets/lottie/navigation.json',
      'route': const NavigationPage(),
      'color': const Color(0xFF966F33), // Wood Brown
      'description': 'Patrones de navegación fluidos',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8DED1), // Light Beige
      highlightColor: const Color(0xFFF5F5DC), // Beige
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (_, __) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Card(
      elevation: 8,
      shadowColor: (category['color'] as Color).withAlpha(102),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => category['route'] as Widget),
        ),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                category['color'] as Color,
                (category['color'] as Color).withAlpha(179),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  category['icon'] as String,
                  height: 80,
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  category['title'] as String,
                  style: const TextStyle(
                    color: Color(0xFFF5F5DC), // Beige
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  category['description'] as String,
                  style: TextStyle(
                    color: const Color(0xFFF5F5DC).withAlpha(204), // Beige with opacity
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // HomePage Content
      _isLoading
          ? _buildShimmerLoading()
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(category);
          },
        ),
      ),
      // NewsPage
      const NewsPage(),
      // ProfilePage
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Flutter Cookbook',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: const Color(0xFF8B4513), // Saddle Brown
              ),
            ),
          ],
          totalRepeatCount: 1,
        ),
        backgroundColor: const Color(0xFFF5F5DC), // Beige
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5DC), // Beige background
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B4513).withOpacity(0.3),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFFF5F5DC),
          selectedItemColor: const Color(0xFF8B4513),
          unselectedItemColor: const Color(0xFF8B4513).withOpacity(0.5),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_rounded),
              label: 'Novedades',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Perfil',
            ),
          ],
          elevation: 0,
        ),
      ),
    );
  }
}