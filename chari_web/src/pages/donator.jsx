import React, { Component } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import Dialog from "react-bootstrap-dialog";
import DonatorService from "../services/DonatorService";

class Donator extends Component {
  state = {
    donators: [],
    donator: {},
    modalShow: false,
    modalTitle: "",
  };

  componentDidMount() {
    this.loadData();
  }

  loadData = () => {
    DonatorService.list().then((res) => {
      this.setState({ donators: res.data });
    });
  };

  closeModal = () => {
    this.setState({ modalShow: false });
  };

  showModal = (id) => {
    if (id === 0) {
      //add
      this.setState({ donator: {} });
      this.setState({ modalTitle: "Thêm mới một Nhà hảo tâm" });
    } else if (id > 0) {
      //update
      this.setState({ modalTitle: "Chỉnh sửa Nhà hảo tâm" });
      DonatorService.get(id).then((res) => {
        this.setState({ donator: res.data });
        this.setState({ modalShow: true });
      });
    }
    this.setState({ modalShow: true });
  };

  inputOnChange = (event) => {
    const { name, value } = event.target; // dùng destructuring để rã thuộc tính name và value của event.target ra name và value
    const newdonator = { ...this.state.donator, [name]: value };
    this.setState({ donator: newdonator });
  };

  save = () => {
    if (this.state.donator.id > 0) {
      DonatorService.update(this.state.donator.id, this.state.donator).then((res) => {
        if (res.data.errorCode > 0) {
          this.setState({ messenger: res.data.messenger });
        } else {
          this.setState({ modalShow: false });
          this.loadData();
        }
      });
    } else {
      DonatorService.add(this.state.donator).then((res) => {
        this.setState({ modalShow: false });
        this.loadData();
      });
    }
  };

  showConfirm = (id) => {
    this.dialog.show({
      title: "Cảnh báo",
      body: `Bạn có chắc chắn sẽ xóa Nhà hảo tâm này không?`,
      actions: [
        Dialog.Action("Không", () => {}, "btn-primary"),
        Dialog.Action(
          "Có",
          () => {
            DonatorService.delete(id).then((res) => {
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
                    <small className="text-muted"> danh sách </small>{" "} Nhà hảo tâm 
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
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {this.state.donators.map((donator, idx) => {
                      return (
                        <tr className="text-center" key={donator.dnt_ID}>
                          <td>{idx + 1}</td>
                          <td>{donator.fullName}</td>
                          <td>{donator.address}</td>
                          <td>{donator.phoneNumber}</td>
                          <td>
                            <span
                              className="hand"
                              href="#"
                              onClick={() => this.showModal(donator.dnt_ID)}
                            >
                              <i className="fas fa-edit text-info mr-2"></i> 
                            </span>
                            <a
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                this.showConfirm(donator.dnt_ID);
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
              <Form.Group as={Row} controlId="formHorizontaldonator">
                <Form.Label column lg={3}>
                  Tên
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="text"
                    name="fullName"
                    onChange={this.inputOnChange}
                    value={this.state.donator.fullName || ""}
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
                    value={this.state.donator.address || ""}
                    placeholder="Nhập địa chỉ"
                  />
                </Col>
              </Form.Group>
              {/* <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Phone
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="number"
                    name="phoneNumber"
                    onChange={this.inputOnChange}
                    value={this.state.donator.phoneNumber || ""}
                    placeholder="Nhập Số điện thoại"
                  />
                </Col>
              </Form.Group> */}
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
export default Donator;
