@Subscriptions = React.createClass
  handleSubmit: ->
    email_input = $('input#email-input')

    $.ajax
      method: 'POST'
      url: "subscriptions"
      data: { email: email_input.val() }
      dataType: 'JSON'
      success: (data) =>
        $('.negative').addClass('hidden')
        $('.positive').removeClass('hidden')
        email_input.val('')
      error: (data) =>
        console.log(data)
        $('.positive').addClass('hidden')
        $('.negative').removeClass('hidden')


  render: ->
    <div className="subscriptions">
      <div className="ui raised very padded text container segment">
        <h2 className="ui header">Please paste you email to get a daily subscription!</h2>
        <SubscriptionError/>
        <SubscriptionNotice/>
        <div className="ui massive icon input">
          <input type="text" placeholder="Type you email..." id="email-input" onChange={@handleChange}/>
          <button className="massive ui button" onClick={@handleSubmit}>Submit</button>
        </div>
      </div>
    </div>
