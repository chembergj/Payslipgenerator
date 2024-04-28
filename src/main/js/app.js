const React = require('react');
const ReactDOM = require('react-dom');
const client = require('./client');
import { useState } from 'react';

class App extends React.Component {

    constructor(props) {
		super(props);
		this.state = { earningperiods: [], modelearningperiods: [] };
		this.handleEarningPeriodChange = this.handleEarningPeriodChange.bind(this);
	}

    getModelEarningPeriods(periodId) {
	    client({method: 'GET', path: '/api/modelearningperiods?earningPeriodId=' + periodId}).done(response => {
            this.setState({selectedEarningPeriod: periodId, modelearningperiods: response.entity });
        });
    }

	componentDidMount() {
		client({method: 'GET', path: '/api/earningperiods'}).done(response => {
			this.setState({earningperiods: response.entity, selectedEarningPeriod: response.entity[0].id });
			this.getModelEarningPeriods(response.entity[0].id);
		});
	}



    handleEarningPeriodChange(event) {
        this.getModelEarningPeriods(event.target.value);
	}



	render() {

    	return (
    	    <>
			    <EarningPeriodListSelector earningperiods={this.state.earningperiods} value={this.state.selectedEarningPeriod} onChange={this.handleEarningPeriodChange}/>
    			<ModelEarningPeriodTable modelearningperiods={this.state.modelearningperiods}  />
            </>
		)
	}
}

class ModelEarningPeriodTable extends React.Component{



	render() {
	    const maxNoModelAccounts = Math.max(...this.props.modelearningperiods.map(mep => mep.modelEarnings.length), 0);
	    const noOfColumns = 3 * maxNoModelAccounts;

        const modelearningperiodRows = this.props.modelearningperiods.map((mep, index) => {
            const remainingColumns = noOfColumns - mep.modelEarnings.length * 3;
            return (
                <React.Fragment key={index}>
                    <tr id={mep.id}><td colSpan={noOfColumns}>{mep.modelName}&nbsp;{mep.percentage}%</td></tr>
                     <tr>
                        {mep.modelEarnings.sort((a, b) => a.website > b.website ? 1 : -1).map((me, meIndex) => (
                            <React.Fragment key={meIndex}>
                                <td>{me.website}</td>
                                <td>{me.modelUserName}</td>
                                <td><input value={me.noOfUnits}/></td>
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
                    {modelearningperiodRows}
                </tbody>
            </table>
        )
	}
}

class EarningPeriodListSelector extends React.Component{
	render() {
		const earningperiodoptions = this.props.earningperiods.map(period =>
			<option key={period.id} value={period.id}>{period.fromDate + " - " + period.toDate}</option>
		);
		return (
		    <>
		     <label htmlFor="earningperiods">Choose an earning period:</label>
              <select name="earningperiods" id="earningperiods" value={this.props.value}  onChange={this.props.onChange}>
                {earningperiodoptions}
              </select>
              </>
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

ReactDOM.render(
	<App />,
	document.getElementById('react')
)