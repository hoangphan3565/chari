import React from 'react';
import './App.css';
import Login from './pages/login';
import DefaultLayout from './containers/defaultLayout';
import { Switch,Route } from 'react-router-dom';


function App() {
  return (
    <Switch>
      <Route path='/login' exact component={Login}/>
      <Route path='/' component={DefaultLayout}/>
    </Switch>
  );
}

export default App;
