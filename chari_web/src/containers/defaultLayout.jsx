import React, { Component } from "react";
import Header from "./header";
import { Switch, Route } from "react-router-dom";
import routes from "./../routes";

class DefaultLayout extends Component {
  state = {};
  render() {
    return (
      <div>
        <Header />
        <Switch>
          {routes.map((route, idx) => {
            return route.component ? (
              <Route
                key={idx}
                path={route.path}
                exact={route.exact}
                name={route.name}
                component={route.component}
              />
            ) : null;
          })}
        </Switch>
      </div>
    );
  }
}

export default DefaultLayout;
