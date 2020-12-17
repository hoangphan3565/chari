import React, { Component } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import InstructorService from "../services/InstructorService";
import Dialog from "react-bootstrap-dialog";

class Instructor extends Component {
  state = {
    instructors: [],
    instructor: {},
    modalShow: false,
    modalTitle: "",
  };

  componentDidMount() {
    this.loadData();
  }
  loadData = () => {
    InstructorService.list().then((res) => {
      this.setState({ instructors: res.data.data });
    });
  };

  closeModal = () => {
    this.setState({ modalShow: false });
  };

  showModal = (id) => {
    if (id === 0) {
      //add
      this.setState({ instructor: {} });
      this.setState({ modalTitle: "New Instructor" });
    } else if (id > 0) {
      //update
      this.setState({ modalTitle: "Edit Instructor" });
      InstructorService.get(id).then((res) => {
        this.setState({ instructor: res.data.data });
        this.setState({ modalShow: true });
      });
    }
    this.setState({ modalShow: true });
  };

  inputOnChange = (event) => {
    const { name, value } = event.target; // dùng destructuring để rã thuộc tính name và value của event.target ra name và value
    const newInstructor = { ...this.state.instructor, [name]: value };
    this.setState({ instructor: newInstructor });
  };

  save = () => {
    if (this.state.instructor.id > 0) {
      InstructorService.update(
        this.state.instructor.id,
        this.state.instructor
      ).then((res) => {
        if (res.data.errorCode > 0) {
          this.setState({ message: res.data.message });
        } else {
          this.setState({ modalShow: false });
          this.loadData();
        }
      });
    } else {
      InstructorService.add(this.state.instructor).then((res) => {
        this.setState({ modalShow: false });
        this.loadData();
      });
    }
  };

  showConfirm = (id) => {
    this.dialog.show({
      title: "Confirmation",
      body: `Are you sure you want to delete this Instructor ?`,
      actions: [
        Dialog.Action("No", () => {}, "btn-primary"),
        Dialog.Action(
          "Yes",
          () => {
            InstructorService.delete(id).then((res) => {
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
                    Instructor <small className="text-muted">list </small>{" "}
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
                      <th>Account</th>
                      <th className="text-left">Full Name</th>
                      <th>Gender</th>
                      <th className="text-left">Email</th>
                      <th>Phone</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {this.state.instructors.map((instructor, idx) => {
                      return (
                        <tr className="text-center" key={instructor.id}>
                          <td>{idx + 1}</td>
                          <td>{instructor.code}</td>
                          <td className="text-left">
                            {instructor.lastName} {instructor.firstName}
                          </td>
                          <td>
                            <i
                              className={
                                instructor.gender === 1
                                  ? "fas fa-male text-warning justify-content-center"
                                  : "fas fa-female text-success justify-content-center"
                              }
                            ></i>
                          </td>
                          <td className="text-left">{instructor.email}</td>
                          <td>{instructor.phone}</td>
                          <td>
                            <span
                              className="hand"
                              href="#"
                              onClick={() => this.showModal(instructor.id)}
                            >
                              <i className="fas fa-edit text-info mr-2"></i>
                            </span>
                            <a
                              href="#"
                              onClick={(e) => {
                                e.preventDefault();
                                this.showConfirm(instructor.id);
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
          size="md"
          //aria-labelledby="contained-modal-title-vcenter"
          //centered
        >
          <Modal.Header closeButton>
            <Modal.Title>{this.state.modalTitle}</Modal.Title>
          </Modal.Header>
          <Modal.Body>
            <Form>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Account
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="text"
                    name="code"
                    onChange={this.inputOnChange}
                    value={this.state.instructor.code || ""}
                    placeholder="Account"
                  />
                </Col>
              </Form.Group>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Full Name
                </Form.Label>
                <Col lg={9}>
                  <Form>
                    <Form.Row>
                      <Col lg={8}>
                        <Form.Control 
                        type="text"
                        name="lastName"
                        onChange={this.inputOnChange}
                        value={this.state.instructor.lastName || ""}
                        placeholder="Last name" />
                      </Col>
                      <Col lg={4}>
                        <Form.Control 
                        type="text"
                        name="firstName"
                        onChange={this.inputOnChange}
                        value={this.state.instructor.firstName || ""}
                        placeholder="First name" />
                      </Col>
                    </Form.Row>
                </Form>
                </Col>
              </Form.Group>
              <fieldset>
                <Form.Group as={Row}>
                  <Form.Label as="legend" column lg={3}>
                    Gender
                  </Form.Label>
                  <Col lg={9}>
                    {['radio'].map((type) => (
                      <div key={`custom-inline-${type}`} className="mb-3">
                        <Form.Check
                          custom
                          inline
                          type="radio"
                          label="Male"
                          id="formHorizontalRadios1"
                          name="gender"
                          onClick={this.inputOnChange}
                          value={this.state.instructor.gender || 1}
                        />
                        <Form.Check
                          custom
                          inline
                          type="radio"
                          label="Female"
                          id="formHorizontalRadios2"
                          name="gender"
                          onClick={this.inputOnChange}
                          value={this.state.instructor.gender || 0}
                        />
                      </div>
                    ))}
                  </Col>
                </Form.Group>
              </fieldset>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Email
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="email"
                    name="email"
                    onChange={this.inputOnChange}
                    value={this.state.instructor.email || ""}
                  />
                </Col>
              </Form.Group>
              <Form.Group as={Row}>
                <Form.Label column lg={3}>
                  Phone
                </Form.Label>
                <Col lg={9}>
                  <Form.Control
                    type="number"
                    name="phone"
                    onChange={this.inputOnChange}
                    value={this.state.instructor.phone || ""}
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
export default Instructor;
