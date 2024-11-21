import { createStore } from 'vuex';

export default createStore({
  state: {
    userEmail: '',  // Estado para almacenar el correo electrónico del usuario autenticado
  },
  getters: {
    // Getter para obtener el correo electrónico del usuario autenticado
    getEmail(state) {
      return state.userEmail;
    },
  },
  mutations: {
    // Mutación para actualizar el correo electrónico del usuario
    setEmail(state, email) {
      state.userEmail = email;
    },
    // Mutación para limpiar el correo electrónico del usuario (por ejemplo, al cerrar sesión)
    clearEmail(state) {
      state.userEmail = '';
    },
  },
  actions: {
    // Acción para establecer el correo electrónico
    saveEmail({ commit }, email) {
      commit('setEmail', email);
    },
    // Acción para limpiar el correo electrónico
    logout({ commit }) {
      commit('clearEmail');
    },
  },
  modules: {},
});