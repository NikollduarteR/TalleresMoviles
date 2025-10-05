import 'package:go_router/go_router.dart';
import 'package:talleres/views/grid/registrarse_detalle_screen.dart';
import 'package:talleres/views/grid/registrarse_screen.dart';
import '../views/home/home_screen.dart';
import '../views/paso_parametros/paso_parametros_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart'; // Para CicloVidaScreen
import 'package:talleres/views/grid/mi_ciclo_vida.dart'; // Para MiCicloVida
import '../views/future/future_view.dart'; // Para FutureView
import '../views/isolate/isolate_view.dart'; // Para IsolateView
import '../views/timer/timer_view.dart'; // Para TimerView

final GoRouter appRouter = GoRouter(
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
  ],
);
