import React, { Component } from "react";
import Cookies from 'js-cookie';
import { Link } from "react-router-dom";



class Header extends Component {
  state = {
    nameuser: "",
  };
  componentDidMount() {
    const loginInfoStr = Cookies.get("loginInfo");
    if(loginInfoStr){
      this.setState({ nameuser: JSON.parse(loginInfoStr).usertype });
    }
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-expand-lg navbar-dark bg-info">
          <div className="container">
            <Link className="navbar-brand" to="/">
              Chari
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
                      Trang chính
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/projecttype">
                      Loại dự án
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/project">
                      Dự án
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/donator">
                      Nhà hảo tâm
                    </Link>
                  </span>
                </li>
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    <Link className="nav-link" to="/supportedpeople">
                      Cá nhân cần được hỗ trợ
                    </Link>
                  </span>
                </li>
              </ul>
              <ul className="navbar-nav">
                <li className="nav-item">
                  <span className="nav-link hand" href="#">
                    Xin chào {`${this.state.nameuser}`}
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
