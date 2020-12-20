import React, { Component, useRef } from 'react';
import UserService from "../services/UserService";
import Cookies from 'js-cookie'

class Login extends Component {
  state = {
    messenger: ""
  }
  
  usernameref = React.createRef();
  passwordref = React.createRef();

  login = () =>{
    const username = this.usernameref.current.value;
    const password = this.passwordref.current.value;
    UserService.login(username,password).then (res=>{
      if(res.data.errorCode > 0){
        this.setState({messenger: res.data.messenger})
      } else {
        if(res.data.data.usertype=="Donator"){
          this.setState({messenger: "Không thể đăng nhập!"})
        } else {
          this.setState({messenger: ""})
          // save cookie
          Cookies.set("loginInfo",JSON.stringify(res.data.data),{expires: 1});
          //redirect to student page
          this.props.history.push("/project");
        }
      }
    });
  };


  render() {
    return (
      <div className="container h-100">
        <div className="row h-100 justify-content-center align-items-center">
          <div className="col-sm-6 col-lg-4">
            <div className="card shadow-lg border-info">
              <h2 className="card-header font-weight-bold text-center text-light bg-info ">
                Đăng nhập
                </h2>
              <div className="card-body">
                  <div className="form-group row mx-2">
                    <label className="sr-only">Tên đăng nhập</label>
                    <div className="input-group mb-2">
                      <div className="input-group-prepend">
                        <div className="input-group-text"><i className="fas fa-user-alt text-info"></i></div>
                      </div>
                      <input type="text" ref={this.usernameref} className="form-control" placeholder="Tên đăng nhập"></input>
                    </div>
                  </div>
                  <div className="form-group row mx-2">
                    <label className="sr-only">Mật khẩu</label>
                    <div className="input-group mb-2">
                      <div className="input-group-prepend">
                        <div className="input-group-text"><i className="fas fa-key text-info"></i></div>
                      </div>
                      <input type="text" ref={this.passwordref} className="form-control" placeholder="Mật khẩu"></input>
                    </div>
                  </div>
                  <div className="form-group row mx-2 ">
                    <button type="button" onClick={this.login} className="btn btn-info">
                      Đăng nhập
                    </button>
                  </div>
                  <div className="text-danger text-center mb-2">{this.state.messenger}</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Login;