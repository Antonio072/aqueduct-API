import 'package:movie_api/movie_api.dart';

class ActorDAO extends ManagedObject<actor> implements actor{}

class actor{
    
    @primaryKey
    int id_actor;

    @Column(indexed: true)
    String nombre;

    @Column(indexed: true)
    String nacionalidad;

    ManagedSet<ActorDAO> repartoDAOFK1;
}