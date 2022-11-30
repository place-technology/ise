module ISE
  module API
    class InternalUser
      def initialize(@session : Session)
      end

      def get(id : String) : Models::Internal::User
        body = JSON.parse(@session.get("/internaluser/#{id}").body)

        Models::Internal::User.from_json(body.as_h.["InternalUser"].to_json)
      end

      def get_by_name(name : String) : Models::Internal::User
        body = JSON.parse(@session.get("/internaluser/name/#{name}").body)

        Models::Internal::User.from_json(body.as_h.["InternalUser"].to_json)
      end

      def list(size : UInt32 = 20, page : UInt32 = 1) : Array(String)
        raise Exception.new("The size parameter '#{size}' is incorrect. Should be positive number between 1 and 100.") if size < 1 || size > 100
        body = JSON.parse(@session.get("/internaluser?size=#{size}&page=#{page}").body)

        body
          .as_h
          .["SearchResult"]
          .as_h
          .["resources"]
          .as_a
          .map(&.as_h.["id"].to_s)
      end

      def create(
        # Main fields for user identification
        id : String? = nil,
        first_name : String? = nil,
        last_name : String? = nil,
        email : String? = nil,
        password : String = "Abcdef123456!",
        description : String? = nil,
        attributes : Hash(String, String)? = nil,
        identity_group : String? = nil,
        name : String = ["internalUser", UUID.random.to_s.split("-").last].join("-"),

        # The Account Name Alias is used to send email notifications about password expiration.
        # See the API specification at: https://developer.cisco.com/docs/identity-services-engine/v1/#!internaluser
        name_alias : String? = nil,

        # Password manipulation and setting fields
        change_password : Bool = false,
        password_never_expires : Bool? = nil,
        enable_password : String? = nil,
        days_for_password_expiration : Int32? = nil,
        password_storage : String = "Internal Users",

        # Expiration setting fields
        expiry_date_enabled : Bool? = nil,
        expiry_date : String? = nil,

        # Availability of the internal user
        enabled : Bool = true
      ) : Models::Internal::User
        internal_user = Models::Internal::User.from_json(%({}))

        internal_user.id = id
        internal_user.first_name = first_name
        internal_user.last_name = last_name
        internal_user.email = email
        internal_user.password = password
        internal_user.description = description
        internal_user.attributes = attributes
        internal_user.identity_group = identity_group
        internal_user.name = name
        internal_user.name_alias = name_alias
        internal_user.change_password = change_password
        internal_user.password_never_expires = password_never_expires
        internal_user.enable_password = enable_password
        internal_user.days_for_password_expiration = days_for_password_expiration
        internal_user.password_storage = password_storage
        internal_user.expiry_date_enabled = expiry_date_enabled
        internal_user.expiry_date = expiry_date
        internal_user.enabled = enabled

        @session.post("/internaluser", {"InternalUser" => internal_user})

        internal_user = self.get_by_name(name)
        internal_user.password = password

        internal_user
      end
    end
  end
end
