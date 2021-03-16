module Api
  module V1
    class BaseController < ApplicationController
      before_action :set_default_request_format
      before_action :authorize!

      protected

      def authorize!
        unless logged_in?
          render_json(:unauthorized, {message: "Please log in"})
        end
      end

      def auth_header
        request.headers["Authorization"]
      end

      def decoded_token
        if auth_header
          token = auth_header.split(" ")[1]
          Tokens::Decode.call(token: token).data
        end
      end

      def logged_in_user
        if decoded_token
          user_id = decoded_token["user_id"]
          result = Users::Find.call(id: user_id)
          @user = result.data[:user]
          @user
        end
      end

      def logged_in?
        logged_in_user.present?
      end

      def render_json(status, json = {})
        render status: status, json: json
      end

      def set_default_request_format
        request.format = :json unless params[:format]
      end
    end
  end
end
