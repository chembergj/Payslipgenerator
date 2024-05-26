const React = require('react');
const ReactDOM = require('react-dom');
import { useState } from 'react';


export class EarningPeriodListSelector extends React.Component{
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