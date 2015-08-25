@Subscriptions = React.createClass
  render: ->
    <div className="subscriptions">
      <div className="ui raised very padded text container segment">
        <h2 className="ui header">Please paste you email to get a daily subscription!</h2>
        <div className="ui massive icon input">
          <input type="text" placeholder="Type you email..." id="email-input"/>
          <button className="massive ui button">Submit</button>
        </div>
      </div>
    </div>
