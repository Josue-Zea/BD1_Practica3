-- Consulta 1
(
  select
    s3.id_cliente,
    c.nombre,
    c.apellido,
    pa.nombre_pais,
    s3.monto_total from
    ( select * from (
      select 
      id_cliente,
      sum(monto_total) as monto_total from (
        select 
        orden.id_cliente, 
        (p.precio * orden.cantidad) as monto_total from 
        orden
        inner join producto p on p.id_producto = orden.id_producto
      ) sub1
        group by sub1.id_cliente
    ) sub2
          order by sub2.monto_total desc
    ) s3
  inner join cliente c on c.id_cliente = s3.id_cliente
  inner join pais pa on c.id_pais = pa.id_pais
  where ROWNUM <= 1;
)

-- Consulta 2 verificada
(
  select * from (
    select * from (
      select 
        id_producto, 
        nombre_producto, 
        nombre_categoria, 
        sum(cantidad) as cantidad, 
        sum(monto) as monto from (
        select 
          orden.id_producto, 
          p.nombre_producto, 
          c.nombre_categoria, 
          orden.cantidad, 
          (orden.cantidad*p.precio) as monto from orden
          inner join producto p on p.id_producto = orden.id_producto
          inner join categoria c on p.id_categoria = c.id_categoria
        ) s1 group by id_producto, nombre_producto, nombre_categoria
    ) s2 order by cantidad desc
  ) s3 where rownum <=1
  union
  select * from (
    select * from (
      select 
        id_producto, 
        nombre_producto, 
        nombre_categoria, 
        sum(cantidad) as cantidad, 
        sum(monto) as monto from (
        select 
          orden.id_producto, 
          p.nombre_producto, 
          c.nombre_categoria, 
          orden.cantidad, 
          (orden.cantidad*p.precio) as monto from orden
          inner join producto p on p.id_producto = orden.id_producto
          inner join categoria c on p.id_categoria = c.id_categoria
        ) s1 group by id_producto, nombre_producto, nombre_categoria
    ) s2 order by cantidad asc
  ) s3 where rownum <=1;
)

-- Consulta 3 verificada
(
  select * from (
    select * from (
      select 
        id_vendedor, 
        nombre_vendedor, 
        sum(monto) as monto from (
          select 
            orden.id_vendedor, 
            v.nombre_vendedor, 
            (orden.cantidad * p.precio) as monto from orden
          inner join vendedor v on v.id_vendedor = orden.id_vendedor
          inner join producto p on p.id_producto = orden.id_producto
        ) s1 group by id_vendedor, nombre_vendedor
    ) s2 order by monto desc
  ) s3 where rownum <= 1;
)

-- Consulta 4 verificada
(
  select * from (
    select 
      nombre_pais, 
      sum(monto) as monto from (
        select 
          pa.nombre_pais, 
          (orden.cantidad*p.precio) as monto from orden
          inner join vendedor v on v.id_vendedor = orden.id_vendedor
          inner join pais pa on pa.id_pais = v.id_pais
          inner join producto p on p.id_producto = orden.id_producto
      ) s1 group by nombre_pais order by monto desc
  ) s2 where rownum <=1
  union 
  select * from (
    select 
      nombre_pais, 
      sum(monto) as monto from (
        select 
          pa.nombre_pais, 
          (orden.cantidad*p.precio) as monto from orden
          inner join vendedor v on v.id_vendedor = orden.id_vendedor
          inner join pais pa on pa.id_pais = v.id_pais
          inner join producto p on p.id_producto = orden.id_producto
      ) s1 group by nombre_pais order by monto asc
  ) s2 where rownum <=1;
)

-- Consulta 5
(
  select * from (select * from (select * from (select
    s1.id_pais, 
    s1.nombre_pais, 
    sum(total) as monto from (
      select 
      pa.id_pais, 
      pa.nombre_pais, 
      (cantidad*p.precio) as total from orden
  inner join producto p on p.id_producto = orden.id_producto
  inner join vendedor v on v.id_vendedor = orden.id_vendedor
  inner join pais pa on pa.id_pais = v.id_pais)
  s1 group by s1.id_pais, s1.nombre_pais)
  s2 order by s2.monto desc) s3 where ROWNUM <= 5) s3
  order by s3.monto asc;
)

-- Consulta 6
(
  select * from (
    select 
      c.nombre_categoria, 
      sum(orden.cantidad) as unidades_vendidas from orden
    inner join producto p on p.id_producto = orden.id_producto
    inner join categoria c on c.id_categoria = p.id_categoria
    group by c.nombre_categoria order by unidades_vendidas desc) s1
  where rownum <=1 union 
  select * from (
    select 
      c.nombre_categoria, 
      sum(orden.cantidad) as unidades_vendidas from orden
    inner join producto p on p.id_producto = orden.id_producto
    inner join categoria c on c.id_categoria = p.id_categoria
    group by c.nombre_categoria order by unidades_vendidas asc) s1
  where rownum <=1;
)

-- Consulta 7

-- Consulta 8
(
  select * from (
    select 
    mes, 
    sum(monto) as monto from (
      select extract(month from fecha_orden) as mes, 
      pa.nombre_pais, 
      (cantidad*p.precio) as monto from orden
  inner join producto p on p.id_producto = orden.id_producto
  inner join vendedor v on v.id_vendedor = orden.id_vendedor
  inner join pais pa on pa.id_pais = v.id_pais
  where nombre_pais = 'Inglaterra') s1 
  group by s1.mes, s1.nombre_pais) s2 order by s2.mes;
)

-- Consulta 9
(
  select * from (
    select 
      mes, 
      sum(monto) as monto from (
        select 
          extract(month from fecha_orden) as mes, 
          (cantidad*p.precio) as monto from orden
        inner join producto p on p.id_producto = orden.id_producto)
      s1 group by mes order by monto desc)
  s2 where ROWNUM <= 1 union 
  select * from (
    select 
      mes, 
      sum(monto) as monto from (
        select 
          extract(month from fecha_orden) as mes, 
          (cantidad*p.precio) as monto from orden
        inner join producto p on p.id_producto = orden.id_producto)
      s1 group by mes order by monto asc)
  s2 where ROWNUM <= 1;
)

-- Consulta 10 verificada
(
  select 
    id_producto, 
    nombre_producto, 
    sum(monto) as monto from (
      select 
        orden.id_producto, 
        p.nombre_producto, 
        (cantidad*p.precio) as monto from orden
      inner join producto p on p.id_producto = orden.id_producto
      inner join categoria c on c.id_categoria = p.id_categoria
      where c.nombre_categoria = 'Deportes'
    ) s1 
  group by id_producto, nombre_producto;
)