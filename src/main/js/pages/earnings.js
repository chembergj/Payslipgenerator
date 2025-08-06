const React = require('react');
const ReactDOM = require('react-dom');
const { v4: uuidv4 } = require('uuid');
import { useState } from 'react';
const client = require('../client');
import Nav from 'react-bootstrap/Nav';
import { EarningPeriodListSelector } from '../components/earningperiodListSelector.js';

class ModelEarningPeriodTable extends React.Component{

    inputChangedHandler = (modelearningperiods, modelEarningPeriod, modelEarning, event) => {

        const changedModelEarning = { ...modelEarning, noOfUnits: event.target.value };
        const originalModelEarningPeriod = modelearningperiods.find(mep => mep.id == modelEarningPeriod.id);
        const indexOfModelEarningToChange = originalModelEarningPeriod.modelEarnings.findIndex(me => me.id === modelEarning.id);
        const changedModelEarningPeriod = { ...originalModelEarningPeriod, modelEarnings: originalModelEarningPeriod.modelEarnings.with(indexOfModelEarningToChange, changedModelEarning) };

        const indexOfModelEarningPeriodToChange = modelearningperiods.findIndex(mep => mep.id === changedModelEarningPeriod.id);
        const changedModelEarningPeriods = modelearningperiods.with(indexOfModelEarningPeriodToChange, changedModelEarningPeriod);
        this.props.onEarningChanged(changedModelEarningPeriods);
    }

	render() {
	    const maxNoModelAccounts = Math.max(...this.props.modelearningperiods.map(mep => mep.modelEarnings.length), 0);
	    const noOfColumns = 3 * maxNoModelAccounts;

        const modelearningperiodRows = this.props.modelearningperiods.map((mep, index) => {
            const remainingColumns = noOfColumns - mep.modelEarnings.length * 3;
            return (
                <React.Fragment  key={index}>
                    <tr  id={mep.id}><td colSpan={noOfColumns}><p class="list-group-item-heading">{mep.modelName}&nbsp;{mep.percentage}%</p><input name={"mep_" + index} type="hidden" value={mep.id}/>

                        <input type="button" onClick={() => this.props.onAddLine(this.props.modelearningperiods, mep)} value="Add line"/>
                    </td></tr>


                     {
                        mep.payslipLines.map(l => (
                            <PayslipGenericLine line={l} modelearningperiods={this.props.modelearningperiods} modelearningperiod={mep} onGenericLineInputChanged={this.props.onGenericLineInputChanged}  />
                        ))
                    }

                     <tr>
                        {mep.modelEarnings.sort((a, b) => a.website > b.website ? 1 : -1).map((me, meIndex) => (
                            <React.Fragment key={me.id}>
                                <td>{me.website}</td>
                                <td>{me.modelUserName}</td>
                                <td><input name={me.id} value={me.noOfUnits} onChange={(event)=>this.inputChangedHandler(this.props.modelearningperiods, mep, me, event)}/></td>
                            </React.Fragment>
                        ))}
                        {remainingColumns > 0 && <td colSpan={remainingColumns}></td>}
                    </tr>
                </React.Fragment>
            );
        });

        return (
            <table>
                <tbody>
                    <div class="list-group">
                        {modelearningperiodRows}
                    </div>
                </tbody>
            </table>
        )
	}
}


class PayslipGenericLine extends React.Component{


    genericLineInputTextChangedHandler = (modelearningperiods, modelEarningPeriod, line, event) => {

      const originalModelEarningPeriod = modelearningperiods.find(mep => mep.id == modelEarningPeriod.id);
        var originalLine = originalModelEarningPeriod.payslipLines.find(l => l.id == line.id);
        var changedLine = {...originalLine, text: event.target.value};
        var indexOfLine = originalModelEarningPeriod.payslipLines.findIndex(l => l.id == line.id);
        var changedModelEarningPeriod = {...originalModelEarningPeriod, payslipLines: originalModelEarningPeriod.payslipLines.with(indexOfLine, changedLine)};

        // TODO: maybe cheating here - maybe values have to be immutable, so dont just change one line
      const indexOfModelEarningPeriodToChange = modelearningperiods.findIndex(mep => mep.id === originalModelEarningPeriod.id);
      const changedModelEarningPeriods = modelearningperiods.with(indexOfModelEarningPeriodToChange, changedModelEarningPeriod);

      this.props.onGenericLineInputChanged(modelearningperiods);
  }

    genericLineInputAmountChangedHandler = (modelearningperiods, modelEarningPeriod, line, event) => {

      const originalModelEarningPeriod = modelearningperiods.find(mep => mep.id == modelEarningPeriod.id);
        var originalLine = originalModelEarningPeriod.payslipLines.find(l => l.id == line.id);
        var changedLine = {...originalLine, amount: event.target.value};
        var indexOfLine = originalModelEarningPeriod.payslipLines.findIndex(l => l.id == line.id);
        var changedModelEarningPeriod = {...originalModelEarningPeriod, payslipLines: originalModelEarningPeriod.payslipLines.with(indexOfLine, changedLine)};

        // TODO: maybe cheating here - maybe values have to be immutable, so dont just change one line
      const indexOfModelEarningPeriodToChange = modelearningperiods.findIndex(mep => mep.id === originalModelEarningPeriod.id);
      const changedModelEarningPeriods = modelearningperiods.with(indexOfModelEarningPeriodToChange, changedModelEarningPeriod);

      this.props.onGenericLineInputChanged(modelearningperiods);
  }


    render() {
        return (
            <React.Fragment key={this.props.line.id}>
                <tr>
                    <td>Text:</td><td><input value={this.props.line.text} onChange={(event)=>this.genericLineInputTextChangedHandler(this.props.modelearningperiods, this.props.modelearningperiod, this.props.line, event)}/></td>
                    <td>Amount:</td><td><input value={this.props.line.amount} onChange={(event)=>this.genericLineInputAmountChangedHandler(this.props.modelearningperiods, this.props.modelearningperiod, this.props.line, event)}/></td>
                </tr>
            </React.Fragment>
        )
    }
 }

class ModelEarningLine extends React.Component{
	render() {
		return (
			<tr>
				<td>{this.props.earning.modelUserName}</td>
				<td>{this.props.earning.website}</td>
				<td>{this.props.earning.noOfUnits}</td>
			</tr>
		)
	}
}

export class Earnings extends React.Component {

 constructor(props) {
		super(props);
		this.state = { earningperiods: [], modelearningperiods: [] };
		this.handleEarningPeriodChange = this.handleEarningPeriodChange.bind(this);
		this.handleEarningChanged = this.handleEarningChanged.bind(this);
		this.handleAddLine = this.handleAddLine.bind(this);
		this.handleGenericLineChanged = this.handleGenericLineChanged.bind(this);
	}


    addMissingModelEarningGuids(modelearningperiods) {

        modelearningperiods.forEach(mep => {
            mep.modelEarnings.forEach(modelearning => {
                if(!modelearning.id) {
                    modelearning.id = uuidv4();
                }
            });
        });

        return modelearningperiods;
    }

    getModelEarningPeriods(periodId) {
	    client({method: 'GET', path: '/api/modelearningperiods?excludeEarnings=false&earningPeriodId=' + periodId}).done(response => {
            this.setState({selectedEarningPeriodId: periodId, modelearningperiods: this.addMissingModelEarningGuids(response.entity) });
        });
    }

	componentDidMount() {
		client({method: 'GET', path: '/api/earningperiods'}).done(response => {
			this.setState({earningperiods: response.entity, selectedEarningPeriodId: response.entity[0].id });
			this.getModelEarningPeriods(response.entity[0].id);
		});
	}



    handleEarningPeriodChange(event) {
        this.getModelEarningPeriods(event.target.value);
	}

    handleSaveClick(modelearningperiods) {
        var periods = this.state.modelearningperiods;
         client({method: 'POST', path: '/api/modelearnings', entity: periods, headers: {'Content-Type': 'application/json'}}).done(response => {
            document.getElementById("status").value = response.status.code + ": " + response.status.text;
                });
    }

    handleGetAsPDFClick(modelearningperiods) {
        var periodId = this.state.selectedEarningPeriodId;
        window.location.href = '/api/pdf?earningPeriodId=' + this.state.selectedEarningPeriodId;
    }

    handleEarningChanged(modelearningperiods) {
        this.setState({modelearningperiods: modelearningperiods});
    }

    handleGenericLineChanged(modelearningperiods) {
        this.setState({modelearningperiods: modelearningperiods});
    }

    handleAddLine(modelearningperiods, modelearningperiod) {
        modelearningperiod.payslipLines.push({ Id: uuidv4(), modelearningperiodId: modelearningperiod.Id });
        this.setState({modelearningperiods: modelearningperiods});
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

                    <h1>Earnings</h1>
                    <EarningPeriodListSelector earningperiods={this.state.earningperiods} value={this.state.selectedEarningPeriodId} onChange={this.handleEarningPeriodChange}/>
                    <ModelEarningPeriodTable modelearningperiods={this.state.modelearningperiods}  onEarningChanged={this.handleEarningChanged} onAddLine={this.handleAddLine}  onGenericLineInputChanged={this.handleGenericLineChanged} />
                    <input type="button" onClick={() => this.handleSaveClick(this.state.modelearningperiods)} value="Save"/>
                    <textarea id="status"/>
                    <input type="button" onClick={() => this.handleGetAsPDFClick(this.state.modelearningperiods)} value="Get PDF"/>
                </>
            )
    }
}