import React from 'react';
import './index.css';
import Identity from './components/identity/Identity';
import Multichar from './components/multichar/Multichar';
import { createRoot } from 'react-dom/client';
import { SquircleNoScript } from "@squircle-js/react";


const root = createRoot(document.getElementById('root')!);

root.render(
  <React.StrictMode>
    <SquircleNoScript />
    <Identity />
    <Multichar />
  </React.StrictMode>
);
