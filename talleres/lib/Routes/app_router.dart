import 'package:go_router/go_router.dart';
import 'package:talleres/models/task.dart';
import 'package:talleres/views/grid/registrarse_detalle_screen.dart';
import 'package:talleres/views/grid/registrarse_screen.dart';
import 'package:talleres/views/jwt/jwt_view.dart';
import 'package:talleres/views/task/form_view.dart';
import 'package:talleres/views/task/list_view.dart';
import 'package:talleres/views/universidades/universidad_fb_form_view.dart';

import 'package:talleres/views/universidades/universidades_fb_list_view.dart';
import '../views/home/home_screen.dart';
import '../views/paso_parametros/paso_parametros_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart'; // Para CicloVidaScreen
import 'package:talleres/views/grid/mi_ciclo_vida.dart'; // Para MiCicloVida
import '../views/future/future_view.dart'; // Para FutureView
import '../views/isolate/isolate_view.dart'; // Para IsolateView
import '../views/timer/timer_view.dart'; // Para TimerView
import '../views/actualizacion/actualizacione_view.dart'; // Para ActualizacionesView
import '../views/meal/meal_list_view.dart'; // Para MealListScreen
import '../views/meal/meal_detail_view.dart'; // Para MealDetailScreen
import '../views/auth/login_page.dart'; // Para LoginPage

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // Usa HomeView
    ),
    // Rutas para el paso de parámetros
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),

    // !Ruta para el detalle con parámetros
    GoRoute(
      path:
          '/detalle/:parametro/:metodo', //la ruta recibe dos parametros los " : " indican que son parametros
      builder: (context, state) {
        //*se capturan los parametros recibidos
        // declarando las variables parametro y metodo
        // es final porque no se van a modificar
        final parametro = state.pathParameters['parametro']!;
        final metodo = state.pathParameters['metodo']!;
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),

    GoRoute(
      path: '/registrar',
      builder: (context, state) => const RegistrarScreen(),
    ),

    GoRoute(
      path: '/registrar/:metodo/:valor',
      builder: (context, state) {
        final metodo = state.pathParameters['metodo']!;
        final valor = state.pathParameters['valor']!;
        return RegistrarDetalleScreen(metodo: metodo, valor: valor);
      },
    ),

    //!Ruta para el ciclo de vida
    GoRoute(
      path: '/ciclo_vida',
      name: 'ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
    GoRoute(
      path: '/ciclo_vida_demo',
      builder: (context, state) => const MiCicloVida(),
    ),

    //!Ruta para FUTURE
    GoRoute(
      path: '/future',
      name: 'future',
      builder: (context, state) => const FutureView(),
    ),
    //!Ruta para ISOLATE
    GoRoute(
      path: '/isolate',
      name: 'isolate',
      builder: (context, state) => const IsolateView(),
    ),

    //!Ruta para TIMER
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) => const TimerView(),
    ),

    //!Ruta para API MEALS
    // Ruta para listado de comidas
    GoRoute(
      path: '/meals',
      name: 'meals',
      builder: (context, state) =>
          const MealListView(), // Pantalla de lista de comidas
    ),

    // Ruta para detalle de una comida
    GoRoute(
      path: '/meal/:id', // se envía id y nombre como parámetros
      name: 'meal_detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MealDetailView(mealId: id);
      },
    ),
    GoRoute(
      path: '/actualizaciones',
      builder: (context, state) => const ActualizacionesView(),
    ),
    //!Ruta para login
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/jwt', builder: (context, state) => const JwtScreen()),

    // !Ruta para el manejo de Universidades CRUD
    GoRoute(
      path: '/universidadesFirebase',
      name: 'universidadesFirebase',
      builder: (_, __) => const UniversidadFbListView(),
    ),
    GoRoute(
      path: '/universidadesfb/create',
      name: 'universidadesfb.create',
      builder: (context, state) => const UniversidadFbFormView(),
    ),
    GoRoute(
      path: '/universidadesfb/edit/:id',
      name: 'universidadesfb.edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UniversidadFbFormView(id: id);
      },
    ),
    GoRoute(
      path: '/tasks',
      name: 'tasks',
      builder: (context, state) => const TaskListView(),
    ),
    GoRoute(
      path: '/tasks/create',
      name: 'tasks.create',
      builder: (context, state) => const TaskFormView(),
    ),
    GoRoute(
      path: '/tasks/edit',
      name: 'tasks.edit',
      builder: (context, state) {
        final task = state.extra as Task; // ← Recibes el objeto completo
        return TaskFormView(task: task);
      },
    ),
  ],
);
