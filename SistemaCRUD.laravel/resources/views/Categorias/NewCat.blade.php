<!-- Modal NewCat-->
<div class="modal fade" id="ModalNewCat" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Nueva Categoria</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="{{url('NuevaCategoria')}}" method="post">
            @csrf
            <label>Nombre de Categoria:
                <input type="text" name="NombreCat">
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