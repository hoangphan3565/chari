import React, { Component } from "react";
import { Link } from "react-router-dom";
class Header extends Component {
  render() {
    return (
      <div>
        <nav className="navbar navbar-expand-lg navbar-dark bg-info">
          <div className="container">
            <Link className="navbar-brand" to="/">
              Student Management
            </Link>
            <button
              className="navbar-toggler"
              type="button"
              data-toggle="collapse"
              data-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent"
              aria-expanded="false"
              aria-label="Toggle navigation"
            >
              <span className="navbar-toggler-icon"></span>
            </button>

            <div className="collapse navbar-collapse" id="navbarSupportedContent">
              <ul className="navbar-nav mr-auto">
                <li className="nav-item active">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/">
                      Home
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/major">
                      Major
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/instructor">
                      Instructor
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/student">
                      Student
                    </Link>
                  </span>
                </li>
              </ul>
              <ul className="navbar-nav">
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    Wellcome ...{" "}
                  </span>
                </li>
                <li className="nav-item">
                  <Link className="nav-link" to="/login">
                    <i className="fas fa-sign-in-alt"></i>
                  </Link>
                </li>
              </ul>
            </div>
          </div>
        </nav>
      </div>
    );
  }
}
export default Header;
