import 'package:movie_api/models/RepartoDAO.dart';
import 'package:movie_api/movie_api.dart';

class RepartoController extends ResourceController{

  final ManagedContext context;
  RepartoController(this.context);

  @Operation.get()
  Future<Response> getAllReparto() async{

    final repartosQuery =Query<RepartoDAO>(context);
    final repartos = await repartosQuery.fetch();
    return Response.ok(repartos);
  }

  @Operation.get('id_reparto')
  Future<Response> getReparto(@Bind.path('id_reparto') int idReparto) async{
      final repartoQuery = Query<RepartoDAO>(context)..where( (a) => a.id_reparto).equalTo(idReparto);
      final reparto = await repartoQuery.fetchOne();
      return reparto != null ? Response.ok(reparto) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addReparto() async{
    
    final newReparto = RepartoDAO()..read(await request.body.decode(), ignore:['id_reparto']);
    final newRepartoQuery = Query<RepartoDAO>(context)..values = newReparto;
    final reparto = await newRepartoQuery.insert();
    return Response.ok(reparto);
  }

  @Operation.put('id_reparto')
  Future<Response> updateReparto(@Bind.path('id_reparto') int idReparto) async{
    
    final updateReparto = RepartoDAO()..read(await request.body.decode());
    final updateRepartoQuery = Query<RepartoDAO>(context)..where( 
      (reparto) => reparto.id_reparto).equalTo(idReparto)..values = updateReparto;
    final reparto = await updateRepartoQuery.update();

    return Response.ok(reparto);
  }

  @Operation.delete('id_reparto')
  Future<Response> deleteReparto(@Bind.path('id_reparto') int idReparto) async{ 
    final deleteRepartoQuery = Query<RepartoDAO>(context)..where((reparto)=>reparto.id_reparto).equalTo(idReparto);
    final reparto = await deleteRepartoQuery.delete();

    return Response.ok(reparto);
  }
  
}