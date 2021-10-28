import React from "react"
import PropTypes from "prop-types"

class HelloWorld extends React.Component {

  constructor(props){
    super(props);
    this.state = {
      test: this.props.budgets
    }
  }

  render () {
    //let  budgets =  this.props.budgets
    let budgets = [{id: 1, start_date: "2021-10-28", end_date: "2021-10-28", amount: 5651111, created_at: "2021-10-28 07:56:33", updated_at: "2021-10-28 07:56:33", user_id: 1, name: "nil"}, {id: 2, start_date: "2021-10-28", end_date: "2021-10-28", amount: 4699847, created_at: "2021-10-28 07:56:33", updated_at: "2021-10-28 07:56:33", user_id: 1, name: "nil"}, {id: 3, start_date: "2021-10-28", end_date: "2021-10-28", amount: 1283047, created_at: "2021-10-28 07:56:33", updated_at: "2021-10-28 07:56:33", user_id: 1, name: "nil"}, {id: 4, start_date: "2021-10-28", end_date: "2021-10-28", amount: 1163955, created_at: "2021-10-28 07:56:33", updated_at: "2021-10-28 07:56:33", user_id: 1, name: "nil"}, {id: 5, start_date: "2021-10-28", end_date: "2021-10-28", amount: 7504305, created_at: "2021-10-28 07:56:33", updated_at: "2021-10-28 07:56:33", user_id: 1, name: "nil"}]
    
    return (
      
      <React.Fragment>
        {/* {budgetss.map((budget, index) => (
              console.log("and here?",budget )
    ))} */}
        <table>
          <thead>
            <tr>
              <th>#</th>
              <th>Start</th>
              <th>End</th>
              <th>Amount</th>
              <th>Used</th>
              <th>Remain</th>
              <th colSpan="3">Remain</th>
            </tr>
          </thead>
          <tbody>
          {budgets.map((budget, index) => (
            <tr>
              <td>{index}</td>
              <td>{budget.start_date}</td>
              <td>{budget.end_date}</td>
              <td>{budget.amount}</td>
              <td>{budget.user_id}</td>
              <td>{budget.updated_at}</td>
              <td>Edit</td>
              <td>show</td>
              <td>delete</td>
            </tr>
    ))}
          </tbody>
        </table>
       
      </React.Fragment>
    );
  }
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};
export default HelloWorld
