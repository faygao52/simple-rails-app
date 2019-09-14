import React from "react"
import PropTypes from "prop-types"
class UserList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      order: 1,
      filter: '',
      sortBy: 'id'
    }
    this.onFilter = this.onFilter.bind(this);
    this.filterByName = this.filterByName.bind(this);
    this.sort = this.sort.bind(this);
    this.sortBy = this.sortBy.bind(this);
  }

  /**
   * Filter table result by name
   * @param {String} name 
   */
  filterByName(name) {
    return this.props.users
      .filter(user => 
        user.name.toLowerCase().search(name.toLowerCase()) !== -1
      );
  }

  /**
   * Set filter
   * @param {Object} event 
   */
  onFilter(event) {
    this.setState({ filter: event.target.value });
  }

  /**
   * Compare two object
   * @param {String} key the field used for comparison
   * @param {Integer} order flag used for ordering 1: ascending, -1: descending
   */
  compare(key, order) {
    return function (a, b) {
      if (a[key] < b[key]) return -order;
      if (a[key] > b[key]) return order;
      return 0;
    };
  }

  /**
   * Given an array of users, sort user
   */
  sort(users) {
    let usersCopy = [...users];
    return usersCopy.sort(this.compare(this.state.sortBy, this.state.order));
  }

  /**
   * Sort user list by given field name
   * @param {String} key the field used for comparison
   */
  sortBy(key) {
    debugger;
    let order = this.state.sortBy == key ? - this.state.order : 1;
    this.setState({ sortBy: key, order: order });
  }

  render () {
    const reloadUsers = () => {
      let users = this.filterByName(this.state.filter);
      return this.sort(users);
    }

    const users = reloadUsers().map( user => (
      <div className="row" key={user.id}>
        <div>{user.name}</div>
        <div>{user.date}</div>
        <div>{user.number}</div>
        <div>{user.description}</div>
      </div>
    ));

    return (
      <div>
        <h1>Data Table</h1>
        <input type="text" className="form-control form-control-lg" placeholder="Search by name" onChange={this.onFilter}/>
        <div className="table">
          <div className="header">
            <div onClick={() => this.sortBy('name')} >Name</div>
            <div onClick={() => this.sortBy('date')}>Date</div>
            <div onClick={() => this.sortBy('number')}>Number</div>
            <div onClick={() => this.sortBy('description')}>Description</div>
          </div>
          <div className="body">
            {users}
          </div>
        </div>
      </div>
    );
  }
}

UserList.propTypes = {
  users: PropTypes.array
};
export default UserList
