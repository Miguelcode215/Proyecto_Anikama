<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap5.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.css">
    <title>Nueva Venta</title>
</head>
<body>
   <div class="container">
       <h1>Nueva Venta</h1> 
       <form id="ventaForm" action="{{ url('Venta') }}" method="POST">
           @csrf
           <div class="mb-3">
               <label for="FechaEmicion" class="form-label">Fecha de Emisión</label>
               <input type="date" class="form-control" id="FechaEmicion" name="FechaEmicion" value="{{ date('Y-m-d') }}">
           </div>
           <div class="mb-3">
               <label for="Estado" class="form-label">Estado</label>
               <input type="text" class="form-control" id="Estado" name="Estado">
           </div>

           <div class="panel panel-primary">
            <div class="panel panel-heading">
              <h5>Detalle de Venta</h5>
            </div>
            <div class="pane-body">
              <div class="row">
                <div class="col-md-3">
                  <div class="form-group">
                    <label for="auxproducto">Producto</label>
                    <select class="form-control" name="auxproducto" id="auxproducto">
                      @foreach($listaPro as $producto)
                        <option value="{{ $producto->idProducto }}" data-precio="{{ $producto->Precio }}">{{ $producto->NombrePro }}</option>
                      @endforeach
                    </select>
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label for="auxcantidad">Cantidad</label>
                    <input type="number" name="auxcantidad" id="auxcantidad" class="form-control" placeholder="Colocar Cantidad" min="1" value="1">
                  </div>
                </div>
                <div class="col-md-2">
                  <div class="form-group">
                    <label for="auxprecio_unitario">Precio Unitario</label>
                    <input type="text" name="auxprecio_unitario" id="auxprecio_unitario" class="form-control" placeholder="Colocar Precio" readonly>
                  </div>
                </div>
              </div>
              <br>
              <div class="row">
                <div class="col-md-2">
                  <div class="form-group">
                    <button type="button" id="btn-add" class="btn btn-primary">Agregar</button>
                  </div>
                </div>
              </div>
              <table id="detalles" class="table table-striped table-bordered table-condensed table-hover">
                <thead>
                    <tr>
                        <th>Productos</th>
                        <th>Unidades</th>
                        <th>Sub Total</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
              <br>
              <button type="submit" class="btn btn-info">Pagar</button>
              <button type="button" class="btn btn-danger">Cancelar</button>
        </form>
   </div>
   <a href="index"><button class="btn">Dashboard</button></a>

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <script>
       $(document).ready(function() {
           $('#auxproducto').change(function() {
               var precio = $(this).find('option:selected').data('precio');
               $('#auxprecio_unitario').val(precio);
           });

           $('#btn-add').click(function() {
               var producto = $('#auxproducto option:selected').text();
               var productoId = $('#auxproducto').val();
               var cantidad = $('#auxcantidad').val();
               var precio = $('#auxprecio_unitario').val();
               var subtotal = cantidad * precio;

               var fila = '<tr>' +
                   '<td><input type="hidden" name="productos[]" value="' + productoId + '">' + producto + '</td>' +
                   '<td><input type="hidden" name="cantidades[]" value="' + cantidad + '">' + cantidad + '</td>' +
                   '<td><input type="hidden" name="subtotales[]" value="' + subtotal + '">' + subtotal.toFixed(2) + '</td>' +
                   '<td><button type="button" class="btn btn-danger btn-remove">Eliminar</button></td>' +
                   '</tr>';

               $('#detalles tbody').append(fila);
           });

           $(document).on('click', '.btn-remove', function() {
               $(this).closest('tr').remove('');
           });
       });
   </script>
</body>
</html>


