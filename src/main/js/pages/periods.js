const React = require('react');
const ReactDOM = require('react-dom');
const { v4: uuidv4 } = require('uuid');
import { useState } from 'react';
import Nav from 'react-bootstrap/Nav';
const client = require('../client');
import { EarningPeriodListSelector } from '../components/earningperiodListSelector.js';

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
            this.setState({selectedEarningPeriodId: periodId, modelearningperiods: response.entity });
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
                <EarningPeriod period={this.state.earningperiods.find(ep => ep.id == this.state.selectedEarningPeriodId)} />
            </>
        )
    }
}