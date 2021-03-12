import 'package:movie_api/models/ActorDAO.dart';
import 'package:movie_api/movie_api.dart';

class ActorController extends ResourceController{

  final ManagedContext context;
  ActorController(this.context);

  @Operation.get()
  Future<Response> getAllActors() async{

    final actorsQuery =Query<ActorDAO>(context);
    final actors = await actorsQuery.fetch();
    return Response.ok(actors);
  }

  @Operation.get('id_actor')
  Future<Response> getActor(@Bind.path('id_actor') int idActor) async{
      final actorQuery = Query<ActorDAO>(context)..where( (a) => a.id_actor).equalTo(idActor);
      final actor = await actorQuery.fetchOne();
      return actor != null ? Response.ok(actor) : Response.notFound();
  }

  @Operation.post()
  Future<Response> addActor() async{
    
    final newActor = ActorDAO()..read(await request.body.decode(), ignore:['id_actor']);
    final newActorQuery = Query<ActorDAO>(context)..values = newActor;
    final actor = await newActorQuery.insert();
    return Response.ok(actor);
  }

  @Operation.put('id_actor')
  Future<Response> updateActor(@Bind.path('id_actor') int idActor) async{
    
    final updateActor = ActorDAO()..read(await request.body.decode());
    final updateActorQuery = Query<ActorDAO>(context)..where( 
      (actor) => actor.id_actor).equalTo(idActor)..values = updateActor;
    final actor = await updateActorQuery.update();

    return Response.ok(actor);
  }

  @Operation.delete('id_actor')
  Future<Response> deleteActor(@Bind.path('id_actor') int idActor) async{ 
    final deleteActorQuery = Query<ActorDAO>(context)..where((actor)=>actor.id_actor).equalTo(idActor);
    final actor = await deleteActorQuery.delete();

    return Response.ok(actor);
  }
  
}