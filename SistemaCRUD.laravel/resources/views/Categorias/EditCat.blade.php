<div class="modal fade" id="ModalEditCat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Editar Categoria</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{url('NuevaCategoria')}}" method="post">
            @csrf
            @method('PUT')
            <input type="hidden" id="idCategoria" name="idCategoria" >
            <label>Nombre de Categoria:
                <input type="text" id="txtNombrecat" name="NombreCat">
            </label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="sibmit" class="btn btn-primary">Guardar</button>
        </form>
      </div>
    </div>
  </div>
</div>