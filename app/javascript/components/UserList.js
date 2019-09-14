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
    this.isActive = this.isActive.bind(this);
    this.showIcon = this.showIcon.bind(this);
    this.onFilter = this.onFilter.bind(this);
    this.filterByName = this.filterByName.bind(this);
    this.sort = this.sort.bind(this);
    this.sortBy = this.sortBy.bind(this);
  }

  /**
   * Change table head style, highlight the field which we used
   * for sorting
   * @param {String} key the field
   */
  isActive(key) {
    return (key===this.state.sortBy) ? 'teal-text text-lighten-2' : '';
  }

  /**
   * Show sort icon if current field is used for sorting
   * @param {String} key 
   */
  showIcon(key) {
    let arrow = this.state.order === 1 ? 'arrow_upward' : 'arrow_downward'
    return  (key===this.state.sortBy) ? <i class="material-icons left">{arrow}</i> : '';
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
      <tr key={user.id}>
        <td>{user.name}</td>
        <td>{user.date}</td>
        <td>{user.number}</td>
        <td>{user.description}</td>
      </tr>
    ));

    const header = (key) => {
      let title = key.charAt(0).toUpperCase()  + key.slice(1);
      return <th className={this.isActive(key)} onClick={() => this.sortBy(key)} >{title}{this.showIcon(key)}</th>
    }

    return (
      <div className="container">
        <h1>Data Table</h1>
        <input type="text" className="form-control form-control-lg" placeholder="Search by name" onChange={this.onFilter}/>
        <table class="striped">
          <thead>
            <tr>
              { header('name') }
              { header('date') }
              { header('number') }
              { header('description') }
            </tr>
          </thead>
          <tbody>
            {users}
          </tbody>
        </table>
      </div>
    );
  }
}

UserList.propTypes = {
  users: PropTypes.array
};
export default UserList
