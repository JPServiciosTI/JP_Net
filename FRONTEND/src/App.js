import { BrowserRouter, Route } from 'react-router-dom';
import {Routes } from "react-router";
import './css/App.css'
import {PageLogin}  from './pages/login'


function App() {
  return (
   <div className='App'>
    <BrowserRouter>
    <Routes>
        <Route path='/' element={ <PageLogin/>} exact />
    </Routes>
    </BrowserRouter>

   </div>
  );
}

export default App;
