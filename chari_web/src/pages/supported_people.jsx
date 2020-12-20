import React, { Component } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import Dialog from "react-bootstrap-dialog";
import SupportedPeopleService from "../services/SupportedPeopleService";

class SupportedPeople extends Component {
  state = {
    supportedpeoples: [],
    supportedpeople: {},
    modalShow: false,
    modalTitle: "",
  };

  componentDidMount() {
    this.loadData();
  }

  loadData = () => {
    SupportedPeopleService.list().then((res) => {
      this.setState({ supportedpeoples: res.data });
    });
  };

  closeModal = () => {
    this.setState({ modalShow: false });
  };

  showModal = (id) => {
    if (id === 0) {
      //add
      this.setState({ supportedpeople: {} });
      this.setState({ modalTitle: "Thêm mới một Cá nhân cần được hỗ trợ" });
    } else if (id > 0) {
      //update
      this.setState({ modalTitle: "Chỉnh sửa Cá nhân cần được hỗ trợ" });
      SupportedPeopleService.get(id).then((res) => {
        this.setState({ supportedpeople: res.data });
        this.setState({ modalShow: true });
      });
    }
    this.setState({ modalShow: true });
  };

  inputOnChange = (event) => {
    const { name, value } = event.target; // dùng destructuring để rã thuộc tính name và value của event.target ra name và value
    const newsupportedpeople = { ...this.state.supportedpeople, [name]: value };
    this.setState({ supportedpeople: newsupportedpeople });
  };

  save = () => {
    if (this.state.supportedpeople.id > 0) {
      SupportedPeopleService.update(this.state.supportedpeople.id, this.state.supportedpeople).then((res) => {
        if (res.data.errorCode > 0) {
          this.setState({ messenger: res.data.messenger });
        } else {
          this.setState({ modalShow: false });
          this.loadData();
        }
      });
    } else {
      SupportedPeopleService.add(this.state.supportedpeople).then((res) => {
        this.setState({ modalShow: false });
        this.loadData();
      });
    }
  };

  showConfirm = (id) => {
    this.dialog.show({
      title: "Cảnh báo",
      body: `Bạn có chắc chắn sẽ xóa Cá nhân cần được hỗ trợ này không?`,
      actions: [
        Dialog.Action("Không", () => {}, "btn-primary"),
        Dialog.Action(
          "Có",
          () => {
            SupportedPeopleService.delete(id).then((res) => {
              this.loadData();
            });
          },
          "btn-danger"
        ),
      ],
      bsSize: "small",
      onHide: (dialog) => {
        dialog.hide();
      },
    });
  };

  render() {
    return (
      <div>
        <div className="container mt-4">
          <div className="card border-info bt-5 shadow-lg">
            <div className="card-header">
              <div className="row">
                <div className="col">
                  <h3 className="card-title">
                    <small className="text-muted"> danh sách </small>{" "} Cá nhân cần được hỗ trợ 
                  </h3>
                </div>
                <div className="col-auto">
                  <button
                    type="button"
                    className="btn btn-info font-weight-bold"
                    onClick={() => this.showModal(0)}
                  >
                    <i className="fas fa-plus"></i>
                    <a> Thêm</a>
                  </button>
                </div>
              </div>
            </div>
            <div className="card-body">
              <div className="table-responsive">
                <table className="table table-bordered table-hover table-striped">
                  <thead className="bg-info text-light">
                    <tr className="text-center">
                      <th>#</th>
                      <th>Họ và tên</th>
                      <th>Địa chỉ</th>
                      <th>Số điện thoại</th>
                      <th>Tài khoản ngân hàng</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {this.state.supportedpeoples.map((supportedpeople, idx) => {
                      return (
                        <tr className="text-center" key={supportedpeople.stp_ID}>
                          <td>{idx + 1}</td>
                          <td>{supportedpeople.fullName}</td>
                          <td>{supportedpeople.address}</td>
                          <td>{supportedpeople.phoneNumber}</td>
                          <td>{supportedpeople.bankAccount}</td>
                          <td>
                            <span
                              className="hand"
                              href="#"
                              onClick={() => this.showModal(supportedpeople.stp_ID)}
                            >
                              <i className="fas fa-edit text-info mr-2"></i> 
                            </span>
                            <a
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                this.showConfirm(supportedpeople.stp_ID);
                              }}
                            >
                              <i className="fas fa-trash-alt text-danger"></i>
                            </a>
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <Modal
          show={this.state.modalShow}
          onHide={this.closeModal}
          backdrop="static"
          keyboard={false}
          //aria-labelledby="contained-modal-title-vcenter"
          //centered
        >
          <Modal.Header closeButton>
            <Modal.Title>{this.state.modalTitle}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Form>
              <Form.Group as={Row} controlId="formHorizontalsupportedpeople">
                <Form.Label column lg={3}>
                  Họ tên
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="text"
                    name="fullName"
                    onChange={this.inputOnChange}
                    value={this.state.supportedpeople.fullName || ""}
                    placeholder="Nhập họ và tên"
                  />
                </Col>
              </Form.Group>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Địa chỉ
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="text"
                    name="address"
                    onChange={this.inputOnChange}
                    value={this.state.supportedpeople.address || ""}
                    placeholder="Nhập địa chỉ"
                  />
                </Col>
              </Form.Group>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  SĐT
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="number"
                    name="phoneNumber"
                    onChange={this.inputOnChange}
                    value={this.state.supportedpeople.phoneNumber || ""}
                    placeholder="Nhập Số điện thoại"
                  />
                </Col>
              </Form.Group>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Tài khoản
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="number"
                    name="bankAccount"
                    onChange={this.inputOnChange}
                    value={this.state.supportedpeople.bankAccount || ""}
                    placeholder="Nhập Số tài khoản ngân hàng"
                  />
                </Col>
              </Form.Group>
            </Form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={this.closeModal}>
              Đóng
            </Button>
            <Button variant="primary" onClick={this.save}>
              Lưu
            </Button>
          </Modal.Footer>
        </Modal>
        <Dialog
          ref={(el) => {
            this.dialog = el;
          }}
        />
      </div>
    );
  }
}
export default SupportedPeople;
