require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    if req.cookies['_rails_lite_app']
      @cookies = JSON.parse(req.cookies['_rails_lite_app'])
    end
    @cookies ||= {}
  end

  def [](key)
    @cookies[key]
  end

  def []=(key, val)
    @cookies[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie_hash = { :path => '/', :value => @cookies.to_json }
    res.set_cookie('_rails_lite_app', cookie_hash)
  end
end
