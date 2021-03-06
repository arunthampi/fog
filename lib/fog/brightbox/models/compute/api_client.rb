module Fog
  module Compute
    class Brightbox
      class ApiClient < Fog::Model
        identity :id
        attribute :name
        attribute :description
        attribute :secret
        attribute :revoked_at, :type => :time
        attribute :account_id

        def save
          raise Fog::Errors::Error.new('Resaving an existing object may create a duplicate') if identity
          options = {
            :name => name,
            :description => description
          }.delete_if {|k,v| v.nil? || v == "" }
          data = connection.create_api_client(options)
          merge_attributes(data)
          true
        end

        def destroy
          requires :identity
          connection.destroy_api_client(identity)
          true
        end

        def reset_secret
          requires :identity
          connection.reset_secret_api_client(identity)
          true
        end
      end
    end
  end
end
