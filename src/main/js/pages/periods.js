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

    specialTRMChangedHandler(modelearningperiod, event) {
            modelearningperiod.specialTRM = event.target.value;
            this.props.onModelEarningPeriodChanged(modelearningperiod);
        }

    modelEarningPeriodRemovedHandler(modelearningperiodId) {
        this.props.onModelEarningPeriodRemoved(modelearningperiodId);
    }

    percentageChangedHandlerForNewPeriod(event) {
        this.setState({TRMForNewPeriod: event.target.value});
    }

    onNewPeriodModelChange(event) {
        this.setState({modelIdForNewPeriod: event.target.value});
    }

    onNewModelEarningPeriodAddedHandler(event) {
        const newMEP = { id: uuidv4(), modelId: this.state.modelIdForNewPeriod, modelName: this.props.models.find(m => m.id == this.state.modelIdForNewPeriod).modelName, percentage: this.state.TRMForNewPeriod, modelEarnings: [] };
        this.props.onModelEarningPeriodAdded(newMEP);
    }

    render() {
        const rows = this.props.modelearningperiods.map(mep =>
                     <tr key={mep.id}>
                        <td>{mep.modelName}</td>
                        <td><input value={mep.percentage} onChange={(event)=>this.percentageChangedHandler(mep, event)}/></td>
                        <td><input value={mep.specialTRM} onChange={(event)=>this.specialTRMChangedHandler(mep, event)}/></td>
                        <td><Button className="col-8" variant="secondary"  onClick={() => this.modelEarningPeriodRemovedHandler(mep.id)}>Remove</Button></td>

                    </tr>
                 );
        const modelIdsWithEarningPeriod = this.props.modelearningperiods.map(mep => mep.modelId);
        const modelnameoptions = this.props.models
            .filter(model => modelIdsWithEarningPeriod.findIndex(midWithPeriod => midWithPeriod == model.id ) == -1) // Only let use select model who doesn't already have an earningperiod
            .map(model =>
                <option key={model.id} value={model.id}>{model.name}</option>
        )   ;

        return (
            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>Model name</th><th>Percentage</th><th>Special TRM</th>
                    </tr>
                </thead>
                <tbody>
                    {rows}
                    <tr><td>
                        <label htmlFor="modelnames">Add new earning period for:</label>
                        <select name="modelnames" id="modelselector" value={this.props.value}  onChange={(event)=>this.onNewPeriodModelChange(event)}>
                            {modelnameoptions}
                        </select>
                    </td>
                    <td><input onChange={(event)=>this.percentageChangedHandlerForNewPeriod(event)}/></td>
                    <td><Button className="col-8" variant="secondary"  onClick={(event)=>this.onNewModelEarningPeriodAddedHandler(event)}>Add</Button></td>

                    </tr>
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
		this.state = { earningperiods: [], modelearningperiods: [], models: [] };
		this.handleSelectedEarningPeriodChange = this.handleSelectedEarningPeriodChange.bind(this);
		this.handleEarningPeriodChanged = this.handleEarningPeriodChanged.bind(this);
		this.saveModelEarningPeriods = this.saveModelEarningPeriods.bind(this);
		this.handleModelEarningPeriodRemoved = this.handleModelEarningPeriodRemoved.bind(this);

	}

    getActiveModels(periodId) {
        client({method: 'GET', path: '/api/models?activeOnly=true'}).done(response => {
            this.setState({models: response.entity });
        });
    }

    getModelEarningPeriods(periodId) {
        client({method: 'GET', path: '/api/modelearningperiods?excludeEarnings=true&earningPeriodId=' + periodId}).done(response => {
            this.setState({modelearningperiods: response.entity });
            this.getActiveModels();
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

    saveEarningPeriod(earningperiod, modelearningperiods) {
         client({method: 'POST', path: '/api/earningperiod', entity: [earningperiod], headers: {'Content-Type': 'application/json'}}).done(response => {
            this.saveModelEarningPeriods(modelearningperiods);
        });
    }

    handleSaveClick() {

        const activeEarningPeriodId = this.state.selectedEarningPeriodId;
        const earningperiod = this.state.earningperiods.find(ep => ep.id == activeEarningPeriodId);
        this.saveEarningPeriod(earningperiod, this.state.modelearningperiods);

    }


    generateNewPeriod(earningperiods) {
        const newPeriod = { id: uuidv4(), fromDate: '', toDate: '', TRM: '', TRMDate: new Date() };
        earningperiods.push(newPeriod);
        const existingModelEarningPeriods = this.state.modelearningperiods;
        const newModelEarningPeriods = existingModelEarningPeriods.map( oldMEP =>
            ({ ...oldMEP, id: uuidv4(), earningPeriodId: newPeriod.id, modelEarnings: [] })
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

    handleModelEarningPeriodRemoved(modelearningperiodId) {
        this.setState({modelearningperiods: this.state.modelearningperiods.filter(mep => mep.id != modelearningperiodId)});
    }

    handleModelEarningPeriodAdded(newModelEarningPeriod) {
        var meps = this.state.modelearningperiods;
        meps.push(newModelEarningPeriod);
        this.setState({modelearningperiods: meps});
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
                        <ModelEarningPeriod
                            models={this.state.models}
                            modelearningperiods={this.state.modelearningperiods}
                            onModelEarningPeriodChanged={this.handleEarningPeriodChanged}
                            onModelEarningPeriodRemoved={this.handleModelEarningPeriodRemoved}
                            onModelEarningPeriodAdded={this.handleModelEarningPeriodAdded} />
                        </Col>
                    </Row>

                </Container>
            </>
        )
    }
}