import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { Provider } from 'react-redux';
import { PersistGate } from 'redux-persist/integration/react';
import { store, persistor } from '@/store/store';
import App from './App.jsx';
import './index.css';
import LoadingState from '@/components/common/LoadingState/LoadingState';

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <Provider store={store}>
      <PersistGate loading={<LoadingState message="Loading application..." />} persistor={persistor}>
        <App />
      </PersistGate>
    </Provider>
  </StrictMode>
);
