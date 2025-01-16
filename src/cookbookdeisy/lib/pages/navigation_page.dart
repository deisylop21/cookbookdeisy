import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;

  // Paleta de colores café
  final ColorScheme _brownColorScheme = const ColorScheme(
    primary: Color(0xFF795548), // Café principal
    primaryContainer: Color(0xFF3E2723), // Café oscuro
    secondary: Color(0xFFD7CCC8), // Café claro
    secondaryContainer: Color(0xFFBCAAA4), // Café medio claro
    surface: Color(0xFFEFEBE9), // Beige claro
    background: Color(0xFFFAF8F6), // Beige muy claro
    error: Color(0xFFB71C1C),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Color(0xFF3E2723),
    onBackground: Color(0xFF3E2723),
    onError: Colors.white,
    brightness: Brightness.light,
  );

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Home',
      'icon': Icons.home,
      'color': Color(0xFF795548),
    },
    {
      'title': 'Search',
      'icon': Icons.search,
      'color': Color(0xFF8D6E63),
    },
    {
      'title': 'Profile',
      'icon': Icons.person,
      'color': Color(0xFF6D4C41),
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
      'color': Color(0xFF5D4037),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: _brownColorScheme,
      ),
      child: Scaffold(
        backgroundColor: _brownColorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              expandedHeight: 120,
              pinned: true,
              backgroundColor: _brownColorScheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Navigation Patterns',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildPage(_currentIndex),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: _brownColorScheme.surface,
            indicatorColor: _brownColorScheme.secondaryContainer,
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _brownColorScheme.primaryContainer,
                );
              }
              return GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: _brownColorScheme.primary,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: _buildNavigationDestinations(),
          ),
        ),
      ),
    );
  }

  List<NavigationDestination> _buildNavigationDestinations() {
    return _pages.map((page) {
      return NavigationDestination(
        icon: Icon(page['icon'] as IconData),
        label: page['title'] as String,
      );
    }).toList();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePage();
      case 1:
        return _buildSearchPage();
      case 2:
        return _buildProfilePage();
      case 3:
        return _buildSettingsPage();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHomePage() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final cards = [
          {'icon': Icons.analytics, 'title': 'Analytics', 'color': _brownColorScheme.primary},
          {'icon': Icons.shopping_cart, 'title': 'Shop', 'color': Color(0xFF8D6E63)},
          {'icon': Icons.favorite, 'title': 'Favorites', 'color': Color(0xFF6D4C41)},
          {'icon': Icons.message, 'title': 'Messages', 'color': Color(0xFF5D4037)},
          {'icon': Icons.map, 'title': 'Map', 'color': Color(0xFF4E342E)},
          {'icon': Icons.settings, 'title': 'Settings', 'color': _brownColorScheme.primaryContainer},
        ];

        return _buildHomeCard(cards[index]);
      },
    );
  }

  Widget _buildHomeCard(Map<String, dynamic> card) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showCardDetails(context, card),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                card['color'] as Color,
                (card['color'] as Color).withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                card['icon'] as IconData,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                card['title'] as String,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCardDetails(BuildContext context, Map<String, dynamic> card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true, // Permite cerrar al tocar fuera
      backgroundColor: Colors.transparent,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(), // Cierra al tocar fuera
        child: DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return GestureDetector(
              onTap: () {}, // Evita que se cierre al tocar dentro del contenido
              child: Container(
                decoration: BoxDecoration(
                  color: _brownColorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: card['color'] as Color,
                      expandedHeight: 200,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          card['title'] as String,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        background: Icon(
                          card['icon'] as IconData,
                          size: 100,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detalles',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _brownColorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Contenido específico para cada card
                            _buildCardSpecificContent(card),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardSpecificContent(Map<String, dynamic> card) {
    // Contenido específico para cada card
    switch (card['title']) {
      case 'Analytics':
        return Column(
          children: [
            _buildDetailItem(
              Icons.bar_chart,
              'Estadísticas',
              'Visualiza tus datos y métricas importantes',
            ),
            _buildDetailItem(
              Icons.trending_up,
              'Tendencias',
              'Análisis de tendencias y patrones',
            ),
            _buildDetailItem(
              Icons.insights,
              'Insights',
              'Descubre información valiosa sobre tu negocio',
            ),
          ],
        );

      case 'Shop':
        return Column(
          children: [
            _buildDetailItem(
              Icons.shopping_bag,
              'Productos',
              'Explora nuestra colección de productos',
            ),
            _buildDetailItem(
              Icons.local_offer,
              'Ofertas',
              'Descuentos y promociones especiales',
            ),
            _buildDetailItem(
              Icons.shopping_cart_checkout,
              'Carrito',
              'Gestiona tus compras',
            ),
          ],
        );

      case 'Favorites':
        return Column(
          children: [
            _buildDetailItem(
              Icons.favorite,
              'Items Favoritos',
              'Tu lista de elementos guardados',
            ),
            _buildDetailItem(
              Icons.collections,
              'Colecciones',
              'Organiza tus favoritos en colecciones',
            ),
            _buildDetailItem(
              Icons.share,
              'Compartir',
              'Comparte tus favoritos con otros',
            ),
          ],
        );

      case 'Messages':
        return Column(
          children: [
            _buildDetailItem(
              Icons.chat,
              'Chats',
              'Tus conversaciones recientes',
            ),
            _buildDetailItem(
              Icons.group,
              'Grupos',
              'Mensajes grupales y colaboración',
            ),
            _buildDetailItem(
              Icons.notifications,
              'Notificaciones',
              'Configura tus alertas de mensajes',
            ),
          ],
        );

      case 'Map':
        return Column(
          children: [
            _buildDetailItem(
              Icons.location_on,
              'Ubicaciones',
              'Encuentra lugares cercanos',
            ),
            _buildDetailItem(
              Icons.navigation,
              'Navegación',
              'Obtén direcciones y rutas',
            ),
            _buildDetailItem(
              Icons.bookmark,
              'Guardados',
              'Tus lugares favoritos',
            ),
          ],
        );

      case 'Settings':
        return Column(
          children: [
            _buildDetailItem(
              Icons.person,
              'Cuenta',
              'Gestiona tu perfil y preferencias',
            ),
            _buildDetailItem(
              Icons.security,
              'Seguridad',
              'Configura la seguridad de tu cuenta',
            ),
            _buildDetailItem(
              Icons.help,
              'Ayuda',
              'Centro de ayuda y soporte',
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }



  Widget _buildDetailItem(IconData icon, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }

  Widget _buildSearchPage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey.withAlpha(20),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.primaries[index % Colors.primaries.length],
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Search Result ${index + 1}'),
                    subtitle: Text('Description for result ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResult(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[index % Colors.primaries.length],
          child: Text('${index + 1}'),
        ),
        title: Text(
          'Resultado ${index + 1}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Descripción del resultado ${index + 1}'),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            // Implementar acción
          },
        ),
      ),
    );
  }

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(),
          _buildProfileStats(),
          _buildProfileActions(),
          const SizedBox(height: 20),
          _buildPostsGrid(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/1.jpg',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Deisy López',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '@deisylopez',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStats() {
    final stats = [
      {'label': 'Posts', 'value': '128'},
      {'label': 'Followers', 'value': '12.8K'},
      {'label': 'Following', 'value': '321'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: stats.map((stat) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  stat['value']!,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stat['label']!,
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProfileActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Editar Perfil'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Compartir Perfil'),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent() {
    final tabs = [
      {'icon': Icons.grid_on, 'label': 'Posts'},
      {'icon': Icons.favorite_border, 'label': 'Likes'},
      {'icon': Icons.bookmark_border, 'label': 'Saved'},
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            tabs: tabs.map((tab) {
              return Tab(
                icon: Icon(tab['icon'] as IconData),
                text: tab['label'] as String,
              );
            }).toList(),
          ),
          SizedBox(
            height: 300, // Altura fija para el contenido
            child: TabBarView(
              children: [
                _buildPostsGrid(),
                _buildLikesGrid(),
                _buildSavedGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              // Implementar acción al tocar
            },
            child: Hero(
              tag: 'post_$index',
              child: Image.network(
                'https://picsum.photos/500/500?random=$index',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLikesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              // Implementar acción al tocar
            },
            child: Image.network(
              'https://picsum.photos/500/500?random=${index + 10}',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSavedGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              // Implementar acción al tocar
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://picsum.photos/500/500?random=${index + 20}',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.bookmark,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSettingsSection(
          'Cuenta',
          [
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'Información Personal',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacidad y Seguridad',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.notifications_outlined,
              title: 'Notificaciones',
              onTap: () {},
            ),
          ],
        ),
        _buildSettingsSection(
          'Preferencias',
          [
            _buildSettingsTile(
              icon: Icons.color_lens_outlined,
              title: 'Tema',
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            _buildSettingsTile(
              icon: Icons.language_outlined,
              title: 'Idioma',
              trailing: const Text('Español'),
              onTap: () {},
            ),
          ],
        ),
        _buildSettingsSection(
          'Soporte',
          [
            _buildSettingsTile(
              icon: Icons.help_outline,
              title: 'Ayuda y Soporte',
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.info_outline,
              title: 'Acerca de',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: const Text('Cerrar Sesión'),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.poppins(),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}