// src/directives/v-permission.js
import { EventBus } from '../directives/eventBus';

export default {
  mounted(el, binding) {
    const checkPermissions = () => {
      const userPermissions = JSON.parse(localStorage.getItem('permissions')) || [];

      let requiredPermissions = binding.value;
      if (typeof requiredPermissions === 'string') {
        requiredPermissions = requiredPermissions.split(',').map(permission => permission.trim());
      }

      const hasPermission = userPermissions.some(permission => requiredPermissions.includes(permission));

      if (!hasPermission) {
        el.style.display = 'none';
      } else {
        el.style.display = ''; // Asegura que se muestre si tiene permisos
      }
    };

    // Verificar permisos cuando se monta
    checkPermissions();

    // Escuchar el evento `permissionsUpdated` para volver a verificar los permisos cuando cambien
    EventBus.on('permissionsUpdated', () => {
      checkPermissions();
    });
  },
  unmounted() {
    // Limpiar el evento cuando el elemento/directiva se destruya
    EventBus.off('permissionsUpdated');
  }
};
