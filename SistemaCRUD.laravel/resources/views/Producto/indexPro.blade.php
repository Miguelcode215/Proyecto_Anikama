<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
    <script src="https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap5.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap5.css">
    <title>Document</title>
</head>
<body>
   <h2>Lista de Productos Disponibles</h2> 
   <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#ModalNewPro">New Categoria</button>
   <table class="table table-striped">
    <thead>
        <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Categoria</th>
        </tr>
    <tbody>
    @foreach ($listaPro as $lp )
        <tr>
            <td>{{$lp->NombrePro}}</td>
            <td>{{$lp->Descripcion}}</td>
            <td>{{$lp->Precio}}</td>
            <td>{{$lp->Stock}}</td>
            <td>{{$lp->NombreCat}}</td> 
            <td><button class=" btn btn-primary btn-sm btn-EditPro" value="{{$lp->idProducto}}">EDIT</button></td> 
            <td><button class="btn btn-danger btn-sm btn-Deletepro" value="{{$lp->idProducto}}">ELIMINAR</button></td>
        </tr>
    @endforeach
    </tbody>
    </thead>
   </table>
   <a href="index"><button class="btn">Dashboard</button></a>
   @include('Producto.NewPro')
   @include('Producto.EditPro')
   @include('Producto.DeletePro')
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script crf="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="{{asset('Datosjs/traerPro.js')}}"></script>
</body>
</html>