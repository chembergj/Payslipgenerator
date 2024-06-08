const React = require('react');
import { useState } from 'react';
const ReactDOM = require('react-dom');
const { v4: uuidv4 } = require('uuid');
import Nav from 'react-bootstrap/Nav';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
const client = require('../client');
import { EarningPeriodListSelector } from '../components/earningperiodListSelector.js';

/*

  {
    "id": "01a7bb9c-c976-4065-b43d-d64b58175f18",
    "modelId": "8673d76c-9e9a-408c-847c-6af03c1b075c",
    "modelName": "Monica Paulin Avendaño Caro",
    "percentage": 65.0,
    "modelEarnings": [

    ]
  },
  {
    "id": "4450ef31-d739-447e-beb3-4d13ff74a680",
*/
class ModelEarningPeriod extends React.Component {

    percentageChangedHandler(modelearningperiod, event) {
        modelearningperiod.percentage = event.target.value;
        this.props.onModelEarningPeriodChanged(modelearningperiod);
    }

    render() {
        const rows = this.props.modelearningperiods.map(mep =>
                     <tr key={mep.id}>
                        <td>{mep.modelName}</td>
                        <td><input value={mep.percentage} onChange={(event)=>this.percentageChangedHandler(mep, event)}/></td>
                    </tr>
                 );

        return (
            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>Model name</th><th>Percentage</th>
                    </tr>
                </thead>
                <tbody>
                    {rows}
                </tbody>
            </Table>
            );

    }
}
 /*
    id": "ee326114-8060-4b41-8679-2021745b4f78",
        "fromDate": "2024-05-13",
        "toDate": "2024-05-19",
        "TRM": 3486.0,
        "TRMDate": "2024-05-21"
        */
class EarningPeriod extends React.Component {

    fromDateChangedHandler(earningPeriod, event) {
        earningPeriod.fromDate = event.target.value;
        this.props.onEarningPeriodChanged(earningPeriod);
    }

    toDateChangedHandler(earningPeriod, event) {
        earningPeriod.toDate = event.target.value;
        this.props.onEarningPeriodChanged(earningPeriod);
    }
    TRMChangedHandler(earningPeriod, event) {
        earningPeriod.TRM = event.target.value;
        this.props.onEarningPeriodChanged(earningPeriod);
    }

    TRMDateChangedHandler(earningPeriod, event) {
        earningPeriod.TRMDate = event.target.value;
        this.props.onEarningPeriodChanged(earningPeriod);
    }

    render() {
        const ep = this.props.period;

        if(!ep) return null;

         return (
          <table>
             <tbody>
                   <tr><td>From date:</td><td><input value={ep.fromDate} onChange={(event)=>this.fromDateChangedHandler(ep, event)}/></td></tr>
                   <tr><td>To date:</td><td><input value={ep.toDate} onChange={(event)=>this.toDateChangedHandler(ep, event)}/></td></tr>
                   <tr><td>TRM:</td><td><input value={ep.TRM} onChange={(event)=>this.TRMChangedHandler(ep, event)}/></td></tr>
                   <tr><td>TRMDate:</td><td><input value={ep.TRMDate} onChange={(event)=>this.TRMDateChangedHandler(ep, event)}/></td></tr>
                </tbody>
             </table>
          );

    }
}

export class Periods extends React.Component {

    constructor(props) {
		super(props);
		this.state = { earningperiods: [], modelearningperiods: [] };
		this.handleSelectedEarningPeriodChange = this.handleSelectedEarningPeriodChange.bind(this);
		this.handleEarningPeriodChanged = this.handleEarningPeriodChanged.bind(this);
	}

    getModelEarningPeriods(periodId) {
        client({method: 'GET', path: '/api/modelearningperiods?excludeEarnings=true&earningPeriodId=' + periodId}).done(response => {
            this.setState({modelearningperiods: response.entity });
        });
    }

    componentDidMount() {
        client({method: 'GET', path: '/api/earningperiods'}).done(response => {
            this.setState({earningperiods: response.entity, selectedEarningPeriodId: response.entity[0].id });
            this.getModelEarningPeriods(response.entity[0].id);
        });
    }

    handleSelectedEarningPeriodChange(event) {
        const periodId = event.target.value;
        this.setState({selectedEarningPeriodId: periodId});
        this.getModelEarningPeriods(periodId);
    }


    saveModelEarningPeriods(modelearningperiods) {
         client({method: 'POST', path: '/api/modelearningperiods', entity: modelearningperiods, headers: {'Content-Type': 'application/json'}}).done(response => {
            document.getElementById("status").value = "Saved!";
        });
    }

    saveEarningPeriod(earningperiod, continuation) {
         client({method: 'POST', path: '/api/earningperiod', entity: [earningperiod], headers: {'Content-Type': 'application/json'}}).done(response => {
            continuation();
        });
    }

    handleSaveClick() {

        const earningperiod = this.state.earningperiods.find(ep => ep.id == this.state.selectedEarningPeriodId);
        this.saveEarningPeriod(earningperiod, () => this.saveModelEarningPeriods(this.state.modelearningperiods));

    }


    generateNewPeriod(earningperiods) {
        const newPeriod = { id: uuidv4(), fromDate: '', toDate: '', TRM: '', TRMDate: new Date() };
        earningperiods.push(newPeriod);
        const existingModelEarningPeriods = this.state.modelearningperiods;
        const newModelEarningPeriods = existingModelEarningPeriods.map( oldMEP =>
            ({ ...oldMEP, id: uuidv4(), modelEarnings: [] })
        );
        this.setState({earningperiods: earningperiods, selectedEarningPeriodId: newPeriod.id, modelearningperiods: newModelEarningPeriods});
    }

    handleEarningPeriodChanged(earningPeriod) {
        var earningperiods = this.state.earningperiods.filter(ep => ep.id !== earningPeriod.id);
        earningperiods.push(earningPeriod);
        this.setState({earningperiods: earningperiods});
    }

    handleModelEarningPeriodChanged(modelearningperiod) {
        var mepIndex = this.state.modelearningperiods.findIndex(mep => mep.id == modelearningperiod.id);
        this.setState({modelearningperiods: this.state.modelearningperiods.with(mepIndex, modelearningperiod)});
    }


    render() {
        return (
            <>
                <Nav variant="tabs">
                    <Nav.Item>
                        <Nav.Link href="/periods">Periods</Nav.Link>
                    </Nav.Item>
                    <Nav.Item>
                        <Nav.Link href="/earnings">Earnings</Nav.Link>
                    </Nav.Item>
                </Nav>

                <h1>Periods</h1>
                <Container>
                    <Row>
                        <Col>
                            <EarningPeriodListSelector earningperiods={this.state.earningperiods} value={this.state.selectedEarningPeriodId} onChange={this.handleSelectedEarningPeriodChange}/>
                       </Col>
                       <Col>
                            <Button variant="primary" className="col-4" onClick={() => this.generateNewPeriod(this.state.earningperiods)}>Generate new period</Button>
                        </Col>
                    </Row>
                    <Row className="align-items-center">
                        <Col>
                            <EarningPeriod period={this.state.earningperiods.find(ep => ep.id == this.state.selectedEarningPeriodId)} onEarningPeriodChanged={this.handleEarningPeriodChanged} />
                        </Col>
                        <Col>
                            <Button variant="primary" className="col-3" onClick={() => this.handleSaveClick()}>Save</Button>
                        </Col>
                        <Col>
                            <textarea id="status"/>
                        </Col>
                    </Row>
                    <Row>
                        <Col>
                        <ModelEarningPeriod modelearningperiods={this.state.modelearningperiods} onModelEarningPeriodChanged={this.handleEarningPeriodChanged}/>
                        </Col>
                    </Row>
                </Container>
            </>
        )
    }
}