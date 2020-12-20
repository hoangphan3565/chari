import React, { Component } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import Dialog from "react-bootstrap-dialog";
import ProjectTypeService from "../services/ProjectTypeService";

class ProjectType extends Component {
  state = {
    projecttypes: [],
    projecttype: {},
    modalShow: false,
    modalTitle: "",
  };

  componentDidMount() {
    this.loadData();
  }

  loadData = () => {
    ProjectTypeService.list().then((res) => {
      this.setState({ projecttypes: res.data });
    });
  };

  closeModal = () => {
    this.setState({ modalShow: false });
  };

  showModal = (id) => {
    if (id === 0) {
      //add
      this.setState({ projecttype: {} });
      this.setState({ modalTitle: "Thêm mới một Loại dự án" });
    } else if (id > 0) {
      //update
      this.setState({ modalTitle: "Chỉnh sửa loại dự án" });
      ProjectTypeService.get(id).then((res) => {
        this.setState({ projecttype: res.data });
        this.setState({ modalShow: true });
      });
    }
    this.setState({ modalShow: true });
  };

  inputOnChange = (event) => {
    const { name, value } = event.target; // dùng destructuring để rã thuộc tính name và value của event.target ra name và value
    const newprojecttype = { ...this.state.projecttype, [name]: value };
    this.setState({ projecttype: newprojecttype });
  };

  save = () => {
    if (this.state.projecttype.id > 0) {
      ProjectTypeService.update(this.state.projecttype.id, this.state.projecttype).then((res) => {
        if (res.data.errorCode > 0) {
          this.setState({ messenger: res.data.messenger });
        } else {
          this.setState({ modalShow: false });
          this.loadData();
        }
      });
    } else {
      ProjectTypeService.add(this.state.projecttype).then((res) => {
        this.setState({ modalShow: false });
        this.loadData();
      });
    }
  };

  showConfirm = (id) => {
    this.dialog.show({
      title: "Cảnh báo",
      body: `Bạn có chắc chắn sẽ xóa Loại dự án này không?`,
      actions: [
        Dialog.Action("Không", () => {}, "btn-primary"),
        Dialog.Action(
          "Có",
          () => {
            ProjectTypeService.delete(id).then((res) => {
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
                    <small className="text-muted"> danh sách </small>{" "} Loại dự án 
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
                      <th>Tên loại dự án</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {this.state.projecttypes.map((projecttype, idx) => {
                      return (
                        <tr className="text-center" key={projecttype.prt_ID}>
                          <td>{idx + 1}</td>
                          <td>{projecttype.projectTypeName}</td>
                          <td>
                            <span
                              className="hand"
                              href="#"
                              onClick={() => this.showModal(projecttype.prt_ID)}
                            >
                              <i className="fas fa-edit text-info mr-2"></i> 
                            </span>
                            <a
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                this.showConfirm(projecttype.prt_ID);
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
              <Form.Group as={Row} controlId="formHorizontalprojecttype">
                <Form.Label column sm={2}>
                  Tên
                </Form.Label>
                <Col sm={10}>
                  <Form.Control
                    type="text"
                    name="projectTypeName"
                    onChange={this.inputOnChange}
                    value={this.state.projecttype.projectTypeName || ""}
                    placeholder="Nhập tên của Loại dự án"
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
export default ProjectType;
