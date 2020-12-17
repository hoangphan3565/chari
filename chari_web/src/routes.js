import Home from './pages/home';
import Students from './pages/student';
import Major from './pages/major';
import Login from './pages/login';
import Instructor from './pages/instructor';


const routes = [
    {path:"/", exact: true,name: "Home",component:Home},
    {path:"/home", exact: true,name: "Home",component:Home},
    {path:"/major", exact: true,name: "Major",component:Major},
    {path:"/instructor", exact: true,name: "Instructor",component:Instructor},
    {path:"/student", exact: true,name: "Student",component:Students},
    {path:"/login", exact: true,name: "Login",component:Login}

];

export default routes;