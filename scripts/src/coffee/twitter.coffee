$ ->  
    twttr.anywhere (T) ->
      logoutBtn = $(".twitter .logout")
      loginBtn = $(".twitter .login")
      checkStatus = ->
        if T.isConnected()
          currentUser = T.currentUser
          logoutBtn.show()
          loginBtn.hide()
          
          screenName = currentUser.data('screen_name')
          $.ajax
            url: "http://api.twitter.com/1/users/lookup.json"
            data: 
              screen_name: screenName
            dataType: "jsonp"
            success: (data) ->
              console.log "twitter api results"
              console.log data
        else 
         loginBtn.show()
         logoutBtn.hide()
         
      checkStatus()
      
      #Successful authentication
      T.bind "authComplete", (e, user) ->
        console.log "successfully authentication"
        checkStatus()
        
      #User logged out
      T.bind "signOut", (e) ->
        console.log "user logged out"
        checkStatus()
       
      loginBtn.click (evt) ->
        evt.preventDefault()
        T.signIn()
        
      logoutBtn.click (evt) ->
        evt.preventDefault()
        twttr.anywhere.signOut()