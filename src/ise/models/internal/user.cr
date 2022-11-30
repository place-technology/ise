class ISE::Models::Internal::User
  include JSON::Serializable

  @[JSON::Field(key: "name")]
  property name : String = "gusetUser"

  @[JSON::Field(key: "id")]
  property id : String?

  @[JSON::Field(key: "description")]
  property description : String?

  @[JSON::Field(key: "changePassword")]
  property change_password : Bool = true

  @[JSON::Field(key: "email")]
  property email : String?

  @[JSON::Field(key: "accountNameAlias")]
  property name_alias : String?

  @[JSON::Field(key: "passwordNeverExpires")]
  property password_never_expires : Bool? = false

  @[JSON::Field(key: "enablePassword")]
  property enable_password : String?

  @[JSON::Field(key: "enabled")]
  property enabled : Bool = true

  @[JSON::Field(key: "customAttributes")]
  property attributes : Hash(String, String)?

  @[JSON::Field(key: "firstName")]
  property first_name : String?

  @[JSON::Field(key: "identityGroup")]
  property identity_group : String?

  @[JSON::Field(key: "lastName")]
  property last_name : String?

  @[JSON::Field(key: "password")]
  property password : String?

  @[JSON::Field(key: "passwordIDStore")]
  property password_storage : String = "Internal Users"

  @[JSON::Field(key: "expiryDateEnabled")]
  property expiry_date_enabled : Bool?

  @[JSON::Field(key: "expiryDate")]
  property expiry_date : String?

  @[JSON::Field(key: "daysForPasswordExpiration")]
  property days_for_password_expiration : Int32? = 60
end
