import React from "react"
import PropTypes from "prop-types"
class Page extends React.Component {
  render () {
    return (
      <React.Fragment className="text-info h2" >
        Title: {this.props.title}
        Description: {this.props.description}
      </React.Fragment>
    );
  }
}

Page.propTypes = {
  title: PropTypes.string,
  description: PropTypes.node
};
export default Page
