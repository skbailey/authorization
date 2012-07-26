window.fbAsyncInit = ->
  FB.init
    appId      : '152191558175911', # App ID
    #channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', # Channel File
    status     : true, # check login status
    cookie     : true, # enable cookies to allow the server to access the session
    xfbml      : true  # parse XFBML
  
  # Add initialization code
  $ ->
    loginBtn = $(".facebook .login")
    logoutBtn = $(".facebook .logout")
    
    loginBtn.click (evt) ->
      evt.preventDefault()
      FB.login()
      
    logoutBtn.click (evt) ->
      evt.preventDefault()
      FB.logout()
      
    checkStatus = (response) ->
      if response.authResponse
        # User has auth'd the app and is logged into Facebook
        FB.api "/me", (me) ->
          console.log "Hi #{me.name}!"
          loginBtn.hide()
          logoutBtn.show()
      else
        loginBtn.show()
        logoutBtn.hide()
        
    FB.Event.subscribe 'auth.statusChange', (response) ->
      checkStatus(response)
      
  
# Load SDK Asynchonously
((d) ->
  id = 'facebook-jssdk'
  ref = d.getElementsByTagName('script')[0]
  return if d.getElementById(id)
  js = d.createElement('script')
  js.id = id
  js.async = true
  js.src = "//connect.facebook.net/en_US/all.js"
  ref.parentNode.insertBefore(js, ref)
)(document)

