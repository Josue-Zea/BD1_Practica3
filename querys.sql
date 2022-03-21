-- Consulta 1
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