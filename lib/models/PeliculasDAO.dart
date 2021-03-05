class PeliculasDAO extends ManagedObject<peliculas> implements peliculas{}

class peliculas{
    
    @primaryKey
    int id;
    
    int duracion;

    @Column(indexed: true)
    Srting sinopsis;

    @Column(unique: true)
    String titulo;
    DateTime fechaEstreno

}