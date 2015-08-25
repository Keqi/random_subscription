@SubscriptionError = React.createClass
  render: ->
    <div className="ui negative hidden message">
      <div className="header">
        <i className="minus circle icon"></i>
        Your email is either taken or invalid.
      </div>
    </div>
