const React = require('react');
const ReactDOM = require('react-dom');

import {
    BrowserRouter,
    Routes,
    Route,
} from "react-router-dom";
import { Earnings }  from './pages/earnings';
import { Periods } from './pages/periods';

// Importing the Bootstrap CSS
import 'bootstrap/dist/css/bootstrap.min.css';


class App extends React.Component {


	render() {

    	return (
            <BrowserRouter>
                <Routes>
                    <Route path="/periods" element={<Periods />} />
                    <Route path="/earnings" element={<Earnings />} />
                </Routes>
            </BrowserRouter>
		)
	}
}


ReactDOM.render(
	<App />,
	document.getElementById('react')
)