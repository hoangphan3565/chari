import Home from './pages/home';
import ProjectType from './pages/project_type';
import Login from './pages/login';
import Donator from './pages/donator';
import SupportedPeople from './pages/supported_people';


const routes = [
    {path:"/", exact: true,name: "Home",component:Home},
    {path:"/home", exact: true,name: "Home",component:Home},
    {path:"/projecttype", exact: true,name: "ProjectType",component:ProjectType},
    {path:"/donator", exact: true,name: "Donator",component:Donator},
    {path:"/supportedpeople", exact: true,name: "SupportedPeople",component:SupportedPeople},
    {path:"/login", exact: true,name: "Login",component:Login}

];

export default routes;