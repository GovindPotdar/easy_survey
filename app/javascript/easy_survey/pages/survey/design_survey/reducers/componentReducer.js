export const INITIAL_STATE = {
  past: [],
  present: {
    components: []
  },
  future: [],
  selectedComponentId: null,
  loading: true,
}

export const componentReducer = (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case 'UPDATE_SELECTED_COMPONENT':
      return { ...state, selectedComponentId: action.payload };
    case 'UPDATE_LOADING':
      return { ...state, loading: action.payload };
    case 'SET_COMPONENTS':
      return { ...state, present: { components: [...action.payload] } }
    case 'ADD_COMPONENT':
      const pastComponents_add = state.past
      pastComponents_add.push(state.present);
      return { ...state, past: pastComponents_add, present: { components: [...state.present.components, action.payload] } }
    case 'UPDATE_COMPONENT':
      const pastComponents_update = state.past;
      pastComponents_update.push(state.present);
      const updatedComponents = state.present.components.map((component) => {
        if (component.id === action.payload.id) {
          return action.payload;
        }
        return component;
      });
      return { ...state, past: pastComponents_update, present: { components: updatedComponents } }
    case 'DELETE_COMPONENT':
      const pastComponents_delete = state.past;
      pastComponents_delete.push(state.present);
      const filteredComponents = state.present.components.filter((component) => component.id !== action.payload);
      return { ...state, past: pastComponents_delete, present: { components: filteredComponents } }
    case 'UNDO':
      if (state.past.length === 0) return state;
      const futureComponents_undo = state.future;
      futureComponents_undo.unshift(state.present);
      const pastComponents_undo = state.past;
      const presentComponent_undo = pastComponents_undo.pop();
      return { ...state, selectedComponentId: null, past: pastComponents_undo, present: presentComponent_undo, future: futureComponents_undo };
    case 'REDO':
      if (state.future.length === 0) return state;
      const pastComponents_redo = state.past;
      pastComponents_redo.push(state.present);
      const futureComponents_redo = state.future;
      const presentComponent_redo = futureComponents_redo.shift();
      return { ...state, selectedComponentId: null, past: pastComponents_redo, present: presentComponent_redo, future: futureComponents_redo };
    default:
      return state;
    }
};
