import 'package:movie_api/controllers/ActorController.dart';
import 'package:movie_api/controllers/ClasificacionController.dart';
import 'package:movie_api/controllers/DirectorController.dart';
import 'package:movie_api/controllers/GeneroController.dart';

import 'movie_api.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class MovieApiChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  
  ManagedContext context;
  
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistenceStore = PostgreSQLPersistentStore('postgres', '1234', 'localhost', 5432, 'movies_db');

  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    // router
    //   .route("/example")
    //   .linkFunction((request) async {
    //     return Response.ok({"key": "value"});
    //   });

    router.route("/actor[/:id_actor]").link( () => ActorController(context));
    router.route("/clasificacion[/:clave]").link( () => ClasificacionController(context));
    router.route("/director[/:id]").link( () => DirectorController(context));
    router.route("/genero[/:id]").link( () => GeneroController(context));
    // router.route("/peliculas[/:id]").link( () => PeliculasController(context));
    // router.route("/reparto[/:id_reparto]").link( () => RepartoController(context));

    return router;
  }
}