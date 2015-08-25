@Subscriptions = React.createClass
  getInitialState: ->
    email: ''

  handleChange: (e) ->
    @setState email: e.target.value

  handleSubmit: ->
    $.ajax
      method: 'POST'
      url: "subscriptions"
      data: { email: @state.email }
      dataType: 'JSON'

  render: ->
    <div className="subscriptions">
      <div className="ui raised very padded text container segment">
        <h2 className="ui header">Please paste you email to get a daily subscription!</h2>
        <div className="ui massive icon input">
          <input type="text" placeholder="Type you email..." id="email-input" onChange={@handleChange}/>
          <button className="massive ui button" onClick={@handleSubmit}>Submit</button>
        </div>
      </div>
    </div>
