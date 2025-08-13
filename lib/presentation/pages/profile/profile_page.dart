import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Datos de ejemplo del usuario
  final Map<String, dynamic> _userInfo = {
    'name': 'Juan Pérez',
    'email': 'juan.perez@email.com',
    'phone': '+1 (809) 123-4567',
    'address': 'Calle Principal #123, Santo Domingo',
    'userType': 'customer',
    'memberSince': '2024',
    'totalOrders': 15,
    'favoriteStore': 'Colmado El Buen Precio',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // App Bar con información del usuario
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: theme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.primaryColor,
                      theme.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        // Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Nombre
                        Text(
                          _userInfo['name'],
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Email
                        Text(
                          _userInfo['email'],
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  // TODO: Navegar a editar perfil
                  _showEditProfileDialog();
                },
              ),
            ],
          ),
          
          // Contenido principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Estadísticas del usuario
                  _buildStatsCard(theme),
                  
                  const SizedBox(height: 16),
                  
                  // Opciones del menú
                  _buildMenuSection(theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mi actividad',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.shopping_bag_outlined,
                  label: 'Pedidos',
                  value: _userInfo['totalOrders'].toString(),
                  color: Colors.blue,
                  theme: theme,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.store_outlined,
                  label: 'Colmado favorito',
                  value: _userInfo['favoriteStore'],
                  color: Colors.green,
                  theme: theme,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.calendar_today_outlined,
                  label: 'Miembro desde',
                  value: _userInfo['memberSince'],
                  color: Colors.orange,
                  theme: theme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required ThemeData theme,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuSection(ThemeData theme) {
    final menuItems = [
      {
        'icon': Icons.person_outline,
        'title': 'Información personal',
        'subtitle': 'Editar nombre, teléfono y dirección',
        'onTap': () => _showEditProfileDialog(),
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Direcciones',
        'subtitle': 'Gestionar direcciones de entrega',
        'onTap': () => _showComingSoon('Direcciones'),
      },
      {
        'icon': Icons.payment_outlined,
        'title': 'Métodos de pago',
        'subtitle': 'Tarjetas y métodos de pago',
        'onTap': () => _showComingSoon('Métodos de pago'),
      },
      {
        'icon': Icons.history_outlined,
        'title': 'Historial de pedidos',
        'subtitle': 'Ver pedidos anteriores',
        'onTap': () => _showComingSoon('Historial de pedidos'),
      },
      {
        'icon': Icons.favorite_outline,
        'title': 'Favoritos',
        'subtitle': 'Productos y colmados favoritos',
        'onTap': () => _showComingSoon('Favoritos'),
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notificaciones',
        'subtitle': 'Configurar notificaciones',
        'onTap': () => _showComingSoon('Notificaciones'),
      },
      {
        'icon': Icons.help_outline,
        'title': 'Ayuda y soporte',
        'subtitle': 'Preguntas frecuentes y contacto',
        'onTap': () => _showComingSoon('Ayuda y soporte'),
      },
      {
        'icon': Icons.info_outline,
        'title': 'Acerca de',
        'subtitle': 'Información de la aplicación',
        'onTap': () => _showAboutDialog(),
      },
      {
        'icon': Icons.logout,
        'title': 'Cerrar sesión',
        'subtitle': 'Salir de tu cuenta',
        'onTap': () => _showLogoutDialog(),
        'isDestructive': true,
      },
    ];

    return Column(
      children: menuItems.map((item) => _buildMenuItem(item, theme)).toList(),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, ThemeData theme) {
    final isDestructive = item['isDestructive'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive 
                ? Colors.red.withOpacity(0.1)
                : theme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item['icon'],
            color: isDestructive ? Colors.red : theme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          item['title'],
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDestructive ? Colors.red : null,
          ),
        ),
        subtitle: Text(
          item['subtitle'],
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: item['onTap'],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _userInfo['name']);
    final phoneController = TextEditingController(text: _userInfo['phone']);
    final addressController = TextEditingController(text: _userInfo['address']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar perfil'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _userInfo['name'] = nameController.text;
                _userInfo['phone'] = phoneController.text;
                _userInfo['address'] = addressController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Perfil actualizado'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Próximamente disponible'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Colmax',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.store,
          color: Colors.white,
          size: 30,
        ),
      ),
      children: [
        const Text(
          'Colmax es tu aplicación de confianza para comprar en colmados locales con entrega a domicilio.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Desarrollado con ❤️ para la comunidad dominicana.',
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar lógica de logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sesión cerrada'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red[600]),
            ),
          ),
        ],
      ),
    );
  }
}