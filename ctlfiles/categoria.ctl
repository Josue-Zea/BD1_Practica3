    OPTIONS (SKIP=1)
    LOAD DATA
    INFILE '/home/zea/Escritorio/bases/CSV Practica 3/Categoria.csv'
    INTO TABLE categoria  
    FIELDS TERMINATED BY ","
    (
        id_categoria  ,
        nombre_categoria
    )
