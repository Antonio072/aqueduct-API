import 'package:movie_api/models/PeliculasDAO.dart';
import 'package:movie_api/movie_api.dart';

class DirectorDAO extends ManagedObject<table_director> implements table_director{}

class table_director{
    
    @primaryKey
    int id;

    @Column(indexed: true)
    String nombre;

    @Column(indexed: true)
    String pais;

    ManagedSet<PeliculasDAO> peliculasDAOFK2;
}