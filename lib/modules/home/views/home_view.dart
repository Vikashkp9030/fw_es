import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/app_theme.dart';
import '../controllers/home_controller.dart';

const _officeAddress =
    'First Floor, Shop No. 02, Regal Civic Center, Awadhpuri, Bhopal, '
    'Madhya Pradesh, India.';
const _tagline = 'Your Trusted Partner for Safety, Security & Sustainability.';
const _mapsUrl =
    'https://www.google.com/maps/dir/?api=1&destination=First+Floor%2C+'
    'Shop+No.+02%2C+Regal+Civic+Center%2C+Awadhpuri%2C+Bhopal%2C+'
    'Madhya+Pradesh%2C+India';
const _phoneDisplay = 'Phone number to be confirmed';
const _emailDisplay = 'Email address to be confirmed';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 82,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 2,
            titleSpacing: 24,
            title: _Brand(onTap: () => controller.scrollTo('home')),
            actions: [
              if (MediaQuery.sizeOf(context).width >= 1350) ...[
                _NavLink('Home', () => controller.scrollTo('home')),
                _NavLink('About Us', () => controller.scrollTo('about')),
                _NavLink('Services', () => controller.scrollTo('services')),
                _NavLink('Why Choose Us', () => controller.scrollTo('why')),
                _NavLink('Core Values', () => controller.scrollTo('values')),
                _NavLink('Contact', () => controller.scrollTo('contact')),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 26),
                  child: _SmallQuoteButton(
                    onPressed: () => controller.scrollTo('contact'),
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: PopupMenuButton<String>(
                    tooltip: 'Open navigation menu',
                    icon: const Icon(Icons.menu_rounded, color: AppColors.navy),
                    onSelected: controller.scrollTo,
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'home', child: Text('Home')),
                      PopupMenuItem(value: 'about', child: Text('About Us')),
                      PopupMenuItem(value: 'services', child: Text('Services')),
                      PopupMenuItem(value: 'why', child: Text('Why Choose Us')),
                      PopupMenuItem(
                        value: 'values',
                        child: Text('Core Values'),
                      ),
                      PopupMenuItem(value: 'contact', child: Text('Contact')),
                    ],
                  ),
                ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _HeroSection(
                  key: controller.sectionKeys['home'],
                  onQuote: () => controller.scrollTo('contact'),
                  onServices: () => controller.scrollTo('services'),
                ),
                _AboutSection(key: controller.sectionKeys['about']),
                _ServicesSection(
                  key: controller.sectionKeys['services'],
                  onQuote: () => controller.scrollTo('contact'),
                ),
                _ProjectsSection(
                  key: controller.sectionKeys['projects'],
                  onQuote: () => controller.scrollTo('contact'),
                ),
                _IndustriesSection(key: controller.sectionKeys['industries']),
                _WhyChooseSection(key: controller.sectionKeys['why']),
                _CoreValuesSection(key: controller.sectionKeys['values']),
                _QuoteBanner(onQuote: () => controller.scrollTo('contact')),
                _ContactSection(key: controller.sectionKeys['contact']),
                const _Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({this.onTap, this.light = false});

  final VoidCallback? onTap;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: light ? Colors.white : AppColors.navy,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.fence_rounded,
              color: light ? AppColors.green : Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 11),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'FENCING WORLD',
                style: TextStyle(
                  color: light ? Colors.white : AppColors.navyDark,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  letterSpacing: .3,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '& ENERGY SOLUTIONS',
                style: TextStyle(
                  color: light ? const Color(0xFF9BE4B2) : AppColors.green,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.15,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.ink,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
      child: Text(label),
    );
  }
}

class _SmallQuoteButton extends StatelessWidget {
  const _SmallQuoteButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.navyDark,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
    ),
    child: const Text('Get a Free Quote'),
  );
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    super.key,
    required this.onQuote,
    required this.onServices,
  });

  final VoidCallback onQuote;
  final VoidCallback onServices;

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 650;
    return SizedBox(
      height: mobile ? 780 : 730,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/residential-perimeter.jpg',
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.navyDark.withValues(alpha: .96),
                  AppColors.navyDark.withValues(alpha: .82),
                  AppColors.navyDark.withValues(alpha: .35),
                  AppColors.navyDark.withValues(alpha: .1),
                ],
                stops: const [0, .43, .77, 1],
              ),
            ),
          ),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 850),
              curve: Curves.easeOutCubic,
              builder: (context, progress, child) => Opacity(
                opacity: progress,
                child: Transform.translate(
                  offset: Offset(0, 18 * (1 - progress)),
                  child: child,
                ),
              ),
              child: _PageWidth(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Eyebrow(
                            label: 'BUILT FOR BOUNDARIES THAT MATTER',
                            light: true,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            mobile
                                ? 'Smart Fencing\nSolutions.\nStronger Security.'
                                : 'Smart Fencing Solutions.\nStronger Security.',
                            style: TextStyle(
                              fontSize: mobile ? 39 : 56,
                              height: 1.1,
                              letterSpacing: -1.6,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Reliable fencing for residential, commercial, '
                            'industrial, agricultural and infrastructure projects. '
                            'Designed around your site. Built for lasting protection.',
                            style: TextStyle(
                              color: Color(0xFFE1E9F4),
                              fontSize: 17,
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 13,
                            runSpacing: 12,
                            children: [
                              _HeroButton(
                                label: 'Get a Free Quote',
                                onPressed: onQuote,
                              ),
                              OutlinedButton.icon(
                                onPressed: onServices,
                                icon: const Icon(Icons.arrow_downward_rounded),
                                label: const Text('Explore Our Services'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.white70,
                                    width: 1.2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 44),
                          const Wrap(
                            spacing: 25,
                            runSpacing: 12,
                            children: [
                              _HeroPoint(label: 'Thoughtful site planning'),
                              _HeroPoint(label: 'Quality-focused installation'),
                              _HeroPoint(
                                label: 'Solutions that fit your needs',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!mobile)
            Positioned(
              right: 44,
              bottom: 42,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .95),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 28,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: AppColors.green),
                    SizedBox(width: 9),
                    Text(
                      'Proudly serving Bhopal & beyond',
                      style: TextStyle(
                        color: AppColors.navyDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroPoint extends StatelessWidget {
  const _HeroPoint({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.check_circle, color: Color(0xFF71D394), size: 17),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

class _HeroButton extends StatelessWidget {
  const _HeroButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
    label: Text(label),
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.orange,
      foregroundColor: AppColors.navyDark,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
  );
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({super.key});

  static const _aboutCopy = [
    'Fencing World and Energy Solutions is a professional fencing solutions '
        'company dedicated to providing reliable, durable, and secure fencing '
        'solutions for residential, commercial, industrial, agricultural, and '
        'infrastructure projects.',
    'We specialize in the design, supply, installation, and maintenance of '
        'fencing systems tailored to the specific security and site requirements '
        'of our clients. Our solutions provide long-lasting protection, '
        'boundary security, safety, and a professional appearance.',
    'Our services include GI Fencing, Chain Link Fencing, Barbed Wire Fencing, '
        'Concertina Fencing, MS Fencing, Welded Mesh Fencing, Solar Fencing, '
        'Security Fencing, and customized fencing solutions.',
    'We focus on quality materials, proper installation practices, safety, '
        'and timely project execution. Our experienced team works closely with '
        'clients to understand their requirements and deliver practical, '
        'cost-effective fencing solutions.',
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: Colors.white,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 820;
        final image = ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: stacked ? 330 : 480,
            width: double.infinity,
            child: Image.asset(
              'assets/images/electric-fence-residence.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
        final content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Eyebrow(label: 'ABOUT OUR COMPANY'),
            const SizedBox(height: 15),
            const _SectionHeading(
              title: 'Protection planned around your place.',
              subtitle: 'Practical expertise. A partnership you can count on.',
              alignLeft: true,
            ),
            const SizedBox(height: 21),
            for (final paragraph in _aboutCopy) ...[
              Text(
                paragraph,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  height: 1.75,
                ),
              ),
              const SizedBox(height: 11),
            ],
            const SizedBox(height: 10),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _Highlight(
                  icon: Icons.verified_outlined,
                  label: 'Quality Materials',
                ),
                _Highlight(
                  icon: Icons.handyman_outlined,
                  label: 'Professional Installation',
                ),
                _Highlight(
                  icon: Icons.schedule_rounded,
                  label: 'Reliable Project Execution',
                ),
              ],
            ),
          ],
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: stacked
              ? [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [image, const SizedBox(height: 38), content],
                    ),
                  ),
                ]
              : [
                  Expanded(flex: 5, child: image),
                  const SizedBox(width: 70),
                  Expanded(flex: 6, child: content),
                ],
        );
      },
    ),
  );
}

class _Highlight extends StatelessWidget {
  const _Highlight({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: AppColors.green),
        const SizedBox(width: 7),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.navyDark,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _Service {
  const _Service(this.title, this.description, this.icon);

  final String title;
  final String description;
  final IconData icon;
}

class _ServicesSection extends StatelessWidget {
  const _ServicesSection({super.key, required this.onQuote});

  final VoidCallback onQuote;

  static const _services = [
    _Service(
      'GI Fencing',
      'Galvanized fencing options for dependable boundary definition and everyday protection.',
      Icons.grid_on_rounded,
    ),
    _Service(
      'Chain Link Fencing',
      'Versatile mesh fencing suited to a wide range of sites, spaces and perimeter needs.',
      Icons.fence_rounded,
    ),
    _Service(
      'Barbed Wire Fencing',
      'A practical perimeter deterrent for properties that need an added layer of security.',
      Icons.linear_scale_rounded,
    ),
    _Service(
      'Concertina Fencing',
      'High-security coiled wire systems for locations that require a more secure boundary.',
      Icons.bolt_rounded,
    ),
    _Service(
      'MS Fencing',
      'Mild steel fencing designed for sturdy boundaries and a clean, professional finish.',
      Icons.domain_rounded,
    ),
    _Service(
      'Welded Mesh Fencing',
      'Rigid welded panels provide a neat boundary with clear visibility across the site.',
      Icons.grid_4x4_rounded,
    ),
    _Service(
      'Solar Fencing',
      'An energy-conscious fencing option that can complement a site’s perimeter security.',
      Icons.wb_sunny_outlined,
    ),
    _Service(
      'Security Fencing',
      'Site-specific security fencing planned around access, use and boundary requirements.',
      Icons.shield_outlined,
    ),
    _Service(
      'Customized Fencing Solutions',
      'A tailored combination of materials and systems for your particular project needs.',
      Icons.tune_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: AppColors.background,
    child: Column(
      children: [
        const _Eyebrow(label: 'WHAT WE DO'),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'Fencing for every boundary',
          subtitle:
              'From straightforward enclosures to specialized perimeter needs, '
              'find a solution that fits your site.',
        ),
        const SizedBox(height: 42),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 980
                ? 3
                : constraints.maxWidth >= 620
                ? 2
                : 1;
            const gap = 18.0;
            final cardWidth =
                (constraints.maxWidth - (columns - 1) * gap) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final service in _services)
                  SizedBox(
                    width: cardWidth,
                    child: _ServiceCard(service: service, onQuote: onQuote),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.onQuote});

  final _Service service;
  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    child: InkWell(
      onTap: onQuote,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        constraints: const BoxConstraints(minHeight: 238),
        padding: const EdgeInsets.all(23),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3EF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(service.icon, color: AppColors.green, size: 26),
            ),
            const SizedBox(height: 19),
            Text(
              service.title,
              style: const TextStyle(
                color: AppColors.navyDark,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              service.description,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            InkWell(
              onTap: onQuote,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Request a Quote',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 7),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: AppColors.green,
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

class _Project {
  const _Project(this.title, this.category, this.image);

  final String title;
  final String category;
  final String image;
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({super.key, required this.onQuote});

  final VoidCallback onQuote;

  static const _projects = [
    _Project(
      'Residential electric fencing',
      'HOME & PROPERTY',
      'assets/images/electric-fence-residence.jpg',
    ),
    _Project(
      'High-security perimeter fencing',
      'INDUSTRIAL & INFRASTRUCTURE',
      'assets/images/industrial-perimeter.jpg',
    ),
    _Project(
      'Welded mesh boundary systems',
      'DURABLE MESH SOLUTIONS',
      'assets/images/welded-mesh-fence.jpg',
    ),
    _Project(
      'Electrified perimeter deterrents',
      'SITE SECURITY',
      'assets/images/electric-security-fence.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: Colors.white,
    verticalPadding: 88,
    child: Column(
      children: [
        const _Eyebrow(label: 'FENCING IN THE FIELD'),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'Made for the places that matter',
          subtitle:
              'Explore the fencing styles and real-world applications we '
              'help bring to life.',
        ),
        const SizedBox(height: 38),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1100
                ? 4
                : constraints.maxWidth >= 620
                ? 2
                : 1;
            const gap = 18.0;
            final width =
                (constraints.maxWidth - (columns - 1) * gap) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final project in _projects)
                  SizedBox(
                    width: width,
                    height: 310,
                    child: _ProjectCard(project: project, onTap: onQuote),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onTap});

  final _Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Material(
      color: AppColors.navyDark,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(project.image, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xE6072346)],
                  stops: [.38, 1],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 21,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.category,
                    style: const TextStyle(
                      color: Color(0xFF9BE4B2),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Wrap(
                    spacing: 7,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Discuss your project',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                        color: Color(0xFF9BE4B2),
                      ),
                    ],
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

class _Industry {
  const _Industry(this.title, this.image, this.icon);

  final String title;
  final String image;
  final IconData icon;
}

class _IndustriesSection extends StatelessWidget {
  const _IndustriesSection({super.key});

  static const _industries = [
    _Industry(
      'Residential Properties',
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9',
      Icons.home_outlined,
    ),
    _Industry(
      'Commercial Buildings',
      'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab',
      Icons.apartment_rounded,
    ),
    _Industry(
      'Industrial Facilities',
      'https://images.unsplash.com/photo-1565514020179-026b92b84bb6',
      Icons.factory_outlined,
    ),
    _Industry(
      'Agricultural Land',
      'https://images.unsplash.com/photo-1500382017468-9049fed747ef',
      Icons.agriculture_outlined,
    ),
    _Industry(
      'Infrastructure Projects',
      'https://images.unsplash.com/photo-1541888946425-d81bb19240f5',
      Icons.construction_rounded,
    ),
    _Industry(
      'Perimeter Security',
      'https://images.unsplash.com/photo-1497366754035-f200968a6e72',
      Icons.security_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: Colors.white,
    verticalPadding: 92,
    child: Column(
      children: [
        const _Eyebrow(label: 'BUILT FOR MANY ENVIRONMENTS'),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'Solutions across industries',
          subtitle:
              'Thoughtful perimeter solutions for places people live, '
              'work, grow and connect.',
        ),
        const SizedBox(height: 40),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 980
                ? 3
                : constraints.maxWidth >= 620
                ? 2
                : 1;
            const gap = 16.0;
            final width =
                (constraints.maxWidth - (columns - 1) * gap) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final industry in _industries)
                  SizedBox(
                    width: width,
                    height: 220,
                    child: _IndustryCard(industry: industry),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _IndustryCard extends StatelessWidget {
  const _IndustryCard({required this.industry});

  final _Industry industry;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Stack(
      fit: StackFit.expand,
      children: [
        _Photo(
          url: '${industry.image}?auto=format&fit=crop&w=900&q=80',
          fallbackIcon: industry.icon,
          fallbackColor: AppColors.navy,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Color(0xD90B2348)],
              stops: [.25, 1],
            ),
          ),
        ),
        Positioned(
          left: 19,
          right: 19,
          bottom: 17,
          child: Row(
            children: [
              Icon(industry.icon, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  industry.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Commitment {
  const _Commitment(this.title, this.description, this.icon);

  final String title;
  final String description;
  final IconData icon;
}

class _WhyChooseSection extends StatelessWidget {
  const _WhyChooseSection({super.key});

  static const _commitments = [
    _Commitment(
      'Quality Materials',
      'We focus on selecting materials suited to your application and site.',
      Icons.workspace_premium_outlined,
    ),
    _Commitment(
      'Reliable & Durable Solutions',
      'Fencing planned for dependable everyday performance and lasting use.',
      Icons.shield_outlined,
    ),
    _Commitment(
      'Site-Specific Customization',
      'Recommendations shaped around your boundaries, needs and environment.',
      Icons.tune_rounded,
    ),
    _Commitment(
      'Professional Installation Practices',
      'Careful installation practices with attention to the details that matter.',
      Icons.handyman_outlined,
    ),
    _Commitment(
      'Safety-Focused Execution',
      'Safety remains an important consideration throughout project execution.',
      Icons.health_and_safety_outlined,
    ),
    _Commitment(
      'Timely Project Delivery',
      'We plan and coordinate work with a focus on agreed project timelines.',
      Icons.event_available_outlined,
    ),
    _Commitment(
      'Cost-Effective Solutions',
      'Practical options help align your fencing needs with your project budget.',
      Icons.savings_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: AppColors.navyDark,
    child: Column(
      children: [
        const _Eyebrow(label: 'WHY FENCING WORLD', light: true),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'A dependable partner from start to finish',
          subtitle:
              'A considered approach to materials, planning and execution for '
              'your peace of mind.',
          light: true,
        ),
        const SizedBox(height: 42),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 980
                ? 4
                : constraints.maxWidth >= 620
                ? 2
                : 1;
            const gap = 17.0;
            final width =
                (constraints.maxWidth - (columns - 1) * gap) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final commitment in _commitments)
                  SizedBox(
                    width: width,
                    child: _CommitmentCard(commitment: commitment),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 22),
        const Text(
          'These are our service commitments, not independent certifications '
          'or guarantees.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFFB9C8DC), fontSize: 11),
        ),
      ],
    ),
  );
}

class _CommitmentCard extends StatelessWidget {
  const _CommitmentCard({required this.commitment});

  final _Commitment commitment;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 190),
    padding: const EdgeInsets.all(21),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: .07),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: Colors.white.withValues(alpha: .1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(commitment.icon, color: const Color(0xFF71D394), size: 27),
        const SizedBox(height: 17),
        Text(
          commitment.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          commitment.description,
          style: const TextStyle(
            color: Color(0xFFD1DAE7),
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}

class _CoreValue {
  const _CoreValue(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _CoreValuesSection extends StatelessWidget {
  const _CoreValuesSection({super.key});

  static const _values = [
    _CoreValue('Safety', Icons.health_and_safety_outlined),
    _CoreValue('Security', Icons.security_rounded),
    _CoreValue('Quality', Icons.diamond_outlined),
    _CoreValue('Reliability', Icons.handshake_outlined),
    _CoreValue('Customer Satisfaction', Icons.sentiment_satisfied_alt_rounded),
    _CoreValue('Sustainability', Icons.eco_outlined),
    _CoreValue('Professionalism', Icons.engineering_outlined),
  ];

  @override
  Widget build(BuildContext context) => _Section(
    background: AppColors.background,
    verticalPadding: 82,
    child: Column(
      children: [
        const _Eyebrow(label: 'WHAT GUIDES US'),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'Our core values',
          subtitle:
              'The principles behind every project and every partnership.',
        ),
        const SizedBox(height: 38),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 980
                ? 7
                : constraints.maxWidth >= 620
                ? 4
                : 2;
            const gap = 12.0;
            final width =
                (constraints.maxWidth - (columns - 1) * gap) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final value in _values)
                  SizedBox(
                    width: width,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 125),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 17,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.line),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(value.icon, color: AppColors.green, size: 27),
                          const SizedBox(height: 11),
                          Text(
                            value.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.navyDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class _QuoteBanner extends StatelessWidget {
  const _QuoteBanner({required this.onQuote});

  final VoidCallback onQuote;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: AppColors.green,
    child: _PageWidth(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 720;
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Your Boundaries with Confidence.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: compact ? 25 : 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.5,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Tell us about your project, and let us help you find the '
                  'right fencing solution.',
                  style: TextStyle(color: Color(0xFFE8F7ED), fontSize: 14),
                ),
              ],
            );
            final button = OutlinedButton.icon(
              onPressed: onQuote,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('Contact Us for a Quote'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.navyDark,
                backgroundColor: AppColors.orange,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            );
            return compact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [copy, const SizedBox(height: 22), button],
                  )
                : Row(
                    children: [
                      Expanded(child: copy),
                      const SizedBox(width: 30),
                      button,
                    ],
                  );
          },
        ),
      ),
    ),
  );
}

class _ContactSection extends GetView<HomeController> {
  const _ContactSection({super.key});

  @override
  Widget build(BuildContext context) => _Section(
    background: Colors.white,
    child: Column(
      children: [
        const _Eyebrow(label: 'LET’S TALK ABOUT YOUR PROJECT'),
        const SizedBox(height: 13),
        const _SectionHeading(
          title: 'Let’s secure what matters',
          subtitle:
              'Share a few details and our team can help you explore the right '
              'fencing approach.',
        ),
        const SizedBox(height: 44),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 820;
            final contactInfo = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fencing World & Energy Solutions',
                  style: TextStyle(
                    color: AppColors.navyDark,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 23),
                const _ContactItem(
                  icon: Icons.location_on_outlined,
                  title: 'Visit our office',
                  content: _officeAddress,
                ),
                const SizedBox(height: 19),
                const _ContactItem(
                  icon: Icons.call_outlined,
                  title: 'Call us',
                  content: _phoneDisplay,
                ),
                const SizedBox(height: 19),
                const _ContactItem(
                  icon: Icons.mail_outline_rounded,
                  title: 'Email us',
                  content: _emailDisplay,
                ),
                const SizedBox(height: 25),
                OutlinedButton.icon(
                  onPressed: _openMaps,
                  icon: const Icon(Icons.directions_outlined, size: 18),
                  label: const Text('Get directions'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.navy,
                    side: const BorderSide(color: AppColors.line),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 27),
                ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: SizedBox(
                    height: 185,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        const _Photo(
                          url:
                              'https://images.unsplash.com/photo-1563013544-824ae1b704d3'
                              '?auto=format&fit=crop&w=900&q=80',
                          fallbackIcon: Icons.location_city_rounded,
                          fallbackColor: AppColors.navy,
                        ),
                        Container(color: AppColors.navy.withValues(alpha: .35)),
                        const Center(
                          child: Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );

            final form = Container(
              padding: const EdgeInsets.all(27),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.line),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D172033),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request a quotation',
                      style: TextStyle(
                        color: AppColors.navyDark,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Fields marked with * are required.',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                    const SizedBox(height: 21),
                    LayoutBuilder(
                      builder: (context, fieldConstraints) {
                        final twoColumns = fieldConstraints.maxWidth >= 520;
                        final itemWidth = twoColumns
                            ? (fieldConstraints.maxWidth - 13) / 2
                            : fieldConstraints.maxWidth;
                        return Wrap(
                          spacing: 13,
                          runSpacing: 15,
                          children: [
                            SizedBox(
                              width: itemWidth,
                              child: _TextInput(
                                label: 'Your name *',
                                hint: 'Enter your name',
                                controller: controller.nameController,
                                validator: _requiredValidator,
                                textCapitalization: TextCapitalization.words,
                              ),
                            ),
                            SizedBox(
                              width: itemWidth,
                              child: _TextInput(
                                label: 'Phone number *',
                                hint: 'Enter your phone number',
                                controller: controller.phoneController,
                                validator: _phoneValidator,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            SizedBox(
                              width: fieldConstraints.maxWidth,
                              child: _TextInput(
                                label: 'Email address *',
                                hint: 'you@example.com',
                                controller: controller.emailController,
                                validator: _emailValidator,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(
                              width: fieldConstraints.maxWidth,
                              child: _TextInput(
                                label: 'Service required *',
                                hint: 'e.g. Chain Link Fencing',
                                controller: controller.serviceController,
                                validator: _requiredValidator,
                              ),
                            ),
                            SizedBox(
                              width: fieldConstraints.maxWidth,
                              child: _TextInput(
                                label: 'Project details *',
                                hint:
                                    'Tell us about your site and requirements',
                                controller: controller.detailsController,
                                validator: _requiredValidator,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 19),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: controller.submitQuote,
                        icon: const Icon(Icons.send_rounded, size: 17),
                        label: const Text('Prepare Quote Request'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => controller.formSubmitted.value
                          ? Container(
                              margin: const EdgeInsets.only(top: 17),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF7EE),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.green,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Your details are ready in this form. '
                                      'Backend integration is pending, so no '
                                      'message has been sent.',
                                      style: TextStyle(
                                        color: AppColors.navyDark,
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This frontend does not send or store your information.',
                      style: TextStyle(color: AppColors.muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            );

            return stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [contactInfo, const SizedBox(height: 35), form],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: contactInfo),
                      const SizedBox(width: 50),
                      Expanded(flex: 6, child: form),
                    ],
                  );
          },
        ),
      ],
    ),
  );
}

Future<void> _openMaps() async {
  final launched = await launchUrl(
    Uri.parse(_mapsUrl),
    mode: LaunchMode.externalApplication,
  );
  if (!launched) {
    Get.snackbar(
      'Unable to open directions',
      'Please search the office address in Google Maps.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

String? _requiredValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'This field is required.';
  return null;
}

String? _phoneValidator(String? value) {
  final requiredError = _requiredValidator(value);
  if (requiredError != null) return requiredError;
  final digits = value!.replaceAll(RegExp(r'\D'), '');
  if (digits.length < 7 || digits.length > 15) {
    return 'Enter a valid phone number.';
  }
  return null;
}

String? _emailValidator(String? value) {
  final requiredError = _requiredValidator(value);
  if (requiredError != null) return requiredError;
  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value!.trim())) {
    return 'Enter a valid email address.';
  }
  return null;
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      alignLabelWithHint: maxLines > 1,
      hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 13),
      labelStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
    ),
  );
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF3EF),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, color: AppColors.green, size: 21),
      ),
      const SizedBox(width: 13),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.navyDark,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              content,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _Footer extends GetView<HomeController> {
  const _Footer();

  @override
  Widget build(BuildContext context) => Container(
    color: AppColors.navyDark,
    child: _PageWidth(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 58, 24, 0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 720;
                final brand = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Brand(light: true),
                    const SizedBox(height: 19),
                    const Text(
                      'Professional fencing solutions for residential, '
                      'commercial, industrial, agricultural and infrastructure '
                      'projects.',
                      style: TextStyle(
                        color: Color(0xFFC5D0E0),
                        fontSize: 13,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      _tagline,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                );
                final navigation = _FooterLinkColumn(
                  title: 'Quick links',
                  links: const [
                    ('Home', 'home'),
                    ('About Us', 'about'),
                    ('Services', 'services'),
                    ('Projects', 'projects'),
                    ('Why Choose Us', 'why'),
                    ('Core Values', 'values'),
                    ('Contact', 'contact'),
                  ],
                );
                final serviceColumn = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FooterTitle('Our services'),
                    for (final service in const [
                      'GI Fencing',
                      'Chain Link Fencing',
                      'Barbed Wire Fencing',
                      'Security Fencing',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Text(
                          service,
                          style: const TextStyle(
                            color: Color(0xFFC5D0E0),
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                );
                final address = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _FooterTitle('Visit us'),
                    SizedBox(height: 14),
                    Text(
                      _officeAddress,
                      style: TextStyle(
                        color: Color(0xFFC5D0E0),
                        fontSize: 12,
                        height: 1.7,
                      ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      _phoneDisplay,
                      style: TextStyle(color: Color(0xFFC5D0E0), fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _emailDisplay,
                      style: TextStyle(color: Color(0xFFC5D0E0), fontSize: 12),
                    ),
                  ],
                );

                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      brand,
                      const SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: navigation),
                          const SizedBox(width: 20),
                          Expanded(child: serviceColumn),
                        ],
                      ),
                      const SizedBox(height: 27),
                      address,
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: brand),
                    const SizedBox(width: 38),
                    Expanded(flex: 2, child: navigation),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: serviceColumn),
                    const SizedBox(width: 20),
                    Expanded(flex: 3, child: address),
                  ],
                );
              },
            ),
            const SizedBox(height: 42),
            const Divider(color: Color(0xFF34445C), height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '© ${DateTime.now().year} Fencing World & Energy Solutions. All rights reserved.',
                style: const TextStyle(color: Color(0xFF9DAEC4), fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _FooterLinkColumn extends GetView<HomeController> {
  const _FooterLinkColumn({required this.title, required this.links});

  final String title;
  final List<(String, String)> links;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _FooterTitle(title),
      for (final (label, section) in links)
        Padding(
          padding: const EdgeInsets.only(top: 9),
          child: InkWell(
            onTap: () => controller.scrollTo(section),
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFFC5D0E0), fontSize: 12),
            ),
          ),
        ),
    ],
  );
}

class _FooterTitle extends StatelessWidget {
  const _FooterTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w800,
    ),
  );
}

class _Photo extends StatelessWidget {
  const _Photo({
    required this.url,
    required this.fallbackIcon,
    required this.fallbackColor,
  });

  final String url;
  final IconData fallbackIcon;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) => Image.network(
    url,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) => DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [fallbackColor, AppColors.navyDark],
        ),
      ),
      child: Center(
        child: Icon(
          fallbackIcon,
          size: 64,
          color: Colors.white.withValues(alpha: .72),
        ),
      ),
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.background,
    required this.child,
    this.verticalPadding = 96,
  });

  final Color background;
  final Widget child;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) => Container(
    color: background,
    width: double.infinity,
    child: _PageWidth(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: verticalPadding,
        ),
        child: child,
      ),
    ),
  );
}

class _PageWidth extends StatelessWidget {
  const _PageWidth({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1240),
      child: child,
    ),
  );
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.subtitle,
    this.light = false,
    this.alignLeft = false,
  });

  final String title;
  final String subtitle;
  final bool light;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: alignLeft
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center,
    children: [
      Text(
        title,
        textAlign: alignLeft ? TextAlign.left : TextAlign.center,
        style: TextStyle(
          color: light ? Colors.white : AppColors.navyDark,
          fontSize: MediaQuery.sizeOf(context).width < 600 ? 29 : 36,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 10),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: Text(
          subtitle,
          textAlign: alignLeft ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: light ? const Color(0xFFCBD6E4) : AppColors.muted,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ),
    ],
  );
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow({required this.label, this.light = false});

  final String label;
  final bool light;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 21,
        height: 2,
        color: light ? const Color(0xFF71D394) : AppColors.green,
      ),
      const SizedBox(width: 9),
      Flexible(
        child: Text(
          label,
          style: TextStyle(
            color: light ? const Color(0xFF9BE4B2) : AppColors.green,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.6,
          ),
        ),
      ),
    ],
  );
}
