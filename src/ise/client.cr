module ISE
  class Client
    property session : Session

    property internal_user : API::InternalUser

    def initialize(@session : Session)
      @internal_user = API::InternalUser.new(@session)
    end
  end
end
