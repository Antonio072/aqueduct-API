import 'package:movie_api/models/PeliculasDAO.dart';
import 'package:movie_api/models/ActorDAO.dart';
import 'package:movie_api/movie_api.dart';

class RepartoDAO extends ManagedObject<table_reparto> implements table_reparto{}

class table_reparto{
    
    @primaryKey
    int id_reparto;

    @Column(unique: true)
    String personaje;

    @Relate(#repartoDAOFK1)
    ActorDAO actor;

    @Relate(#repartoDAOFK2)
    PeliculasDAO pelicula;

}