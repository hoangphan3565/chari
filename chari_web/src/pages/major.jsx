import React, { Component } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import Dialog from "react-bootstrap-dialog";
import MajorService from "../services/MajorService";

class Major extends Component {
  state = {
    majors: [],
    major: {},
    modalShow: false,
    modalTitle: "",
  };

  componentDidMount() {
    this.loadData();
  }

  loadData = () => {
    MajorService.list().then((res) => {
      this.setState({ majors: res.data.data });
    });
  };

  closeModal = () => {
    this.setState({ modalShow: false });
  };

  showModal = (id) => {
    if (id === 0) {
      //add
      this.setState({ major: {} });
      this.setState({ modalTitle: "New Major" });
    } else if (id > 0) {
      //update
      this.setState({ modalTitle: "Edit Major" });
      MajorService.get(id).then((res) => {
        this.setState({ major: res.data.data });
        this.setState({ modalShow: true });
      });
    }
    this.setState({ modalShow: true });
  };

  inputOnChange = (event) => {
    const { name, value } = event.target; // dùng destructuring để rã thuộc tính name và value của event.target ra name và value
    const newMajor = { ...this.state.major, [name]: value };
    this.setState({ major: newMajor });
  };

  save = () => {
    if (this.state.major.id > 0) {
      MajorService.update(this.state.major.id, this.state.major).then((res) => {
        if (res.data.errorCode > 0) {
          this.setState({ message: res.data.message });
        } else {
          this.setState({ modalShow: false });
          this.loadData();
        }
      });
    } else {
      MajorService.add(this.state.major).then((res) => {
        this.setState({ modalShow: false });
        this.loadData();
      });
    }
  };

  showConfirm = (id) => {
    this.dialog.show({
      title: "Confirmation",
      body: `Are you sure you want to delete this Major ?`,
      actions: [
        Dialog.Action("No", () => {}, "btn-primary"),
        Dialog.Action(
          "Yes",
          () => {
            MajorService.delete(id).then((res) => {
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
                    Major <small className="text-muted">list </small>{" "}
                  </h3>
                </div>
                <div className="col-auto">
                  <button
                    type="button"
                    className="btn btn-info font-weight-bold"
                    onClick={() => this.showModal(0)}
                  >
                    <i className="fas fa-plus"></i>
                    <a> Add</a>
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
                      <th>Name</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {this.state.majors.map((major, idx) => {
                      return (
                        <tr className="text-center" key={major.id}>
                          <td>{idx + 1}</td>
                          <td>{major.name}</td>
                          <td>
                            <span
                              className="hand"
                              href="#"
                              onClick={() => this.showModal(major.id)}
                            >
                              <i className="fas fa-edit text-info mr-2"></i> 
                            </span>
                            <a
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                this.showConfirm(major.id);
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
              <Form.Group as={Row} controlId="formHorizontalMajor">
                <Form.Label column sm={2}>
                  Name
                </Form.Label>
                <Col sm={10}>
                  <Form.Control
                    type="text"
                    name="name"
                    onChange={this.inputOnChange}
                    value={this.state.major.name || ""}
                    placeholder="Enter Major name"
                  />
                </Col>
              </Form.Group>
            </Form>
          </Modal.Body>
          <Modal.Footer>
            <Button variant="secondary" onClick={this.closeModal}>
              Close
            </Button>
            <Button variant="primary" onClick={this.save}>
              Save
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
export default Major;
