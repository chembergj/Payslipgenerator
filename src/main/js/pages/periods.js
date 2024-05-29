const React = require('react');
import { useState } from 'react';
const ReactDOM = require('react-dom');
const { v4: uuidv4 } = require('uuid');
import Nav from 'react-bootstrap/Nav';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
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
    render() {
        const rows = this.props.modelearningperiods.map(mep =>
                     <tr key={mep.id}>
                        <td>{mep.modelName}</td>
                        <td><input value={mep.percentage} onChange={(event)=>this.inputChangedHandler(mep, event)}/></td>
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
    render() {
        const ep = this.props.period;

        if(!ep) return null;

         return (
          <table>
             <tbody>
                   <tr><td>From date:</td><td><input value={ep.fromDate} onChange={(event)=>this.inputChangedHandler(ep, event)}/></td></tr>
                   <tr><td>To date:</td><td><input value={ep.toDate}/></td></tr>
                   <tr><td>TRM:</td><td><input value={ep.TRM}/></td></tr>
                   <tr><td>TRMDate:</td><td><input value={ep.TRMDate}/></td></tr>
                </tbody>
             </table>
          );

    }
}

export class Periods extends React.Component {

    constructor(props) {
		super(props);
		this.state = { earningperiods: [], modelearningperiods: [] };
		this.handleEarningPeriodChange = this.handleEarningPeriodChange.bind(this);
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

    handleEarningPeriodChange(event) {
        const periodId = event.target.value;
        this.setState({selectedEarningPeriodId: periodId});
    }

    generateNewPeriod(modelearningperiods) {
        const newPeriod = { id: uuidv4(), fromDate: '', toDate: '', TRM: '', TRMDate: new Date() };
        modelearningperiods.push(newPeriod);
        this.setState({modelearningperiods: modelearningperiods, selectedEarningPeriodId: newPeriod.id});
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
                <EarningPeriodListSelector earningperiods={this.state.earningperiods} value={this.state.selectedEarningPeriodId} onChange={this.handleEarningPeriodChange}/>
                <Button variant="primary" onClick={() => this.generateNewPeriod(this.state.modelearningperiods)}>Generate new period</Button>
                <EarningPeriod period={this.state.earningperiods.find(ep => ep.id == this.state.selectedEarningPeriodId)} />
                <ModelEarningPeriod modelearningperiods={this.state.modelearningperiods}/>
            </>
        )
    }
}