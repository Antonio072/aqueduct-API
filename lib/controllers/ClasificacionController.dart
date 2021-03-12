import 'package:movie_api/models/ClasificacionDAO.dart';
import 'package:movie_api/movie_api.dart';

class ClasificacionController extends ResourceController{

  final ManagedContext context;
  ClasificacionController(this.context);

  @Operation.get()
  Future<Response> getAllClasifications() async{

    final clasificationsQuery =Query<ClasificacionDAO>(context);
    final clasifications = await clasificationsQuery.fetch();
    return Response.ok(clasifications);
  }

  @Operation.get('clave')
  Future<Response> getClasificacion(@Bind.path('clave') int idClasificacion) async{
      final clasificacionQuery = Query<ClasificacionDAO>(context)..where( (a) => a.clave).equalTo(idClasificacion);
      final clasificacion = await clasificacionQuery.fetchOne();
      return clasificacion != null ? Response.ok(clasificacion) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addClasificacion() async{
    
    final newClasificacion = ClasificacionDAO()..read(await request.body.decode(), ignore:['clave']);
    final newClasificacionQuery = Query<ClasificacionDAO>(context)..values = newClasificacion;
    final clasificacion = await newClasificacionQuery.insert();
    return Response.ok(clasificacion);
  }

  @Operation.put('clave')
  Future<Response> updateClasificacion(@Bind.path('clave') int idClasificacion) async{
    
    final updateClasificacion = ClasificacionDAO()..read(await request.body.decode());
    final updateClasificacionQuery = Query<ClasificacionDAO>(context)..where( 
      (clasificacion) => clasificacion.clave).equalTo(idClasificacion)..values = updateClasificacion;
    final clasificacion = await updateClasificacionQuery.update();

    return Response.ok(clasificacion);
  }

  @Operation.delete('clave')
  Future<Response> deleteClasificacion(@Bind.path('clave') int idClasificacion) async{ 
    final deleteClasificacionQuery = Query<ClasificacionDAO>(context)..where((clasificacion)=>clasificacion.clave).equalTo(idClasificacion);
    final clasificacion = await deleteClasificacionQuery.delete();

    return Response.ok(clasificacion);
  }
  
}